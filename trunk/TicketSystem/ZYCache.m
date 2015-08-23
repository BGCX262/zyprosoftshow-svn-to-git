//
//  ZYCache.m
//  ZYToolKit
//
//  Created by Vincent_HU  on 11-12-23.
//  Copyright (c) 2011年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "ZYCache.h"

static NSString* _ZYCacheDirectory;

//确保用作缓存的plist文件名不被使用为关键字
#define CHECK_FOR_ZYCACHE_PLIST() if([key isEqualToString:@"ZYCache.plist"]) return;

//初始化缓存字典路径
static inline NSString *ZYCacheDirectory(){
    if (!_ZYCacheDirectory) {
        NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _ZYCacheDirectory = [[[cacheDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"ZYCache"] copy];//确保后面能用
    }
    return _ZYCacheDirectory;
}
//为关键字创建缓存路径
static inline NSString *cachePathForKey(NSString *key){
    return [ZYCacheDirectory() stringByAppendingPathComponent:key];
}

static ZYCache *shareZYCache;

@interface ZYCache()
- (void)removeItemFromCache:(NSString *)key;//根据关键字清除某项缓存
- (void)perforDiskWriteOperation:(NSInvocation*)invocation;//执行写入磁盘操作
- (void)saveCacheDictionary;//保存缓存目录
@end
@implementation ZYCache
@synthesize defaultTimeoutInterval;

//单例方法实现
+ (ZYCache *)currentCache
{
    @synchronized(self){
        if (!shareZYCache) {
            shareZYCache = [[ZYCache alloc]init];
            shareZYCache.defaultTimeoutInterval = 86400;
        }
    }
    return shareZYCache;
}

//对象初始化
- (id)init{
    self = [super init];
    if (self) {
        //创建指定缓存路径字典
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:cachePathForKey(@"ZYCache.plist")];
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            [dict mutableCopy];
        }else{
            cacheDictionary = [[NSMutableDictionary alloc]init];
        }
    }
    
    diskOperationQueue = [[NSOperationQueue alloc]init];//初始化操作队列
    
    
    //???
    for (NSString* key in cacheDictionary) {
        NSDate *date = [cacheDictionary objectForKey:key];
        if ([[[NSDate date] earlierDate:date] isEqualToDate:date]) {
            [[NSFileManager defaultManager] removeItemAtPath:cachePathForKey(key) error:NULL];
        }
    }
    return self;
}

//清空缓存
- (void)clearCache{
    for (NSString *key in [cacheDictionary allKeys]) {
        [self removeItemFromCache:key];
    }
}

//移出指定关键字所对应的缓存
- (void)removeCacheForKey:(NSString *)key
{
    //先判断key是否可以用
    CHECK_FOR_ZYCACHE_PLIST();
    
    [self removeItemFromCache:key];
    [self saveCacheDictionary];
}
//清空指定关键字所指向的缓存
- (void)removeItemFromCache:(NSString *)key
{
    NSString *cachePath = cachePathForKey(key);
    
    //利用NSInvocation对象传递参数给方法,将要清除的缓存路径传递给 -> 删除方法
    NSInvocation *deleteInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(deleteDataAtPath:)]];
    [deleteInvocation setTarget:self];
    [deleteInvocation setSelector:@selector(deleteDataAtPath:)];
    [deleteInvocation setArgument:&cachePath atIndex:2];
    
    [self perforDiskWriteOperation:deleteInvocation];//执行删除操作
    [cacheDictionary removeObjectForKey:key];//缓存目录移出删除的路径
    
}
//查看指定关键字是否有缓存
- (BOOL)hasCacheForKey:(NSString *)key
{
    NSDate *date = [cacheDictionary objectForKey:key];
    if (!date) return NO;
    if ([[[NSDate date] earlierDate:date] isEqualToDate:date]) return NO;
    return [[NSFileManager defaultManager] fileExistsAtPath:cachePathForKey(key)];
}

#pragma mark -
#pragma mark Copy file methods

//--------  路径操作 ----------//
- (void)copyFilePath:(NSString *)filePath asKey:(NSString *)key
{
    [self copyFilePath:filePath asKey:key withTimeoutInterval:self.defaultTimeoutInterval];
}

- (void)copyFilePath:(NSString *)filePath asKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval
{
    [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:cachePathForKey(key) error:NULL];
    [cacheDictionary setObject:[NSDate dateWithTimeIntervalSinceNow:timeoutInterval] forKey:key];//设置路径创建时间
    [self performSelectorOnMainThread:@selector(saveAfterDelay) withObject:nil waitUntilDone:YES];
    
}

#pragma mark -
#pragma mark Data methods

//----------- NSData 数据缓存 ---------//

- (void)setData:(NSData *)data forKey:(NSString *)key
{
    [self setData:data forKey:key withTimeoutInterVal:self.defaultTimeoutInterval];
}

- (void)setData:(NSData *)data forKey:(NSString *)key withTimeoutInterVal:(NSTimeInterval)timeoutInterval
{
    CHECK_FOR_ZYCACHE_PLIST();
    
    NSString *cachePath = cachePathForKey(key);
    NSInvocation *writeInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(writeData:toPath:)]];
    [writeInvocation setTarget:self];
    [writeInvocation setSelector:@selector(writeData:toPath:)];
    [writeInvocation setArgument:&data atIndex:2];
    [writeInvocation setArgument:&cachePath atIndex:3];
    
    [self perforDiskWriteOperation:writeInvocation];
    [cacheDictionary setObject:[NSDate dateWithTimeIntervalSinceNow:timeoutInterval] forKey:key];
    
    [self performSelectorOnMainThread:@selector(saveAfterDelay) withObject:nil waitUntilDone:YES];//确保保存在主线程中，而不是在当前线程中
    
}

//阻止多线程快速存储，防止降低程序执行速度
- (void)saveAfterDelay
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(saveCacheDictionary) object:nil];//退出前一个缓存请求
    [self performSelector:@selector(saveCacheDictionary) withObject:nil afterDelay:0.3];//执行新的存储操作
}

//获取缓存数据
- (NSData*)dataForKey:(NSString *)key
{
    if ([self hasCacheForKey:key]) {
        return [NSData dataWithContentsOfFile:cachePathForKey(key) options:0 error:NULL];
    } else{
        return nil;
    }
    
}

// 写入数据操作
- (void)writeData:(NSData*)data toPath:(NSString *)path{
    [data writeToFile:path atomically:YES];
}

//删除数据操作
- (void)deleteDataAtPath:(NSString *)path{
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}

//保存当前缓存目录
- (void)saveCacheDictionary{
    @synchronized(self){
        [cacheDictionary writeToFile:cachePathForKey(@"ZYCache.plist") atomically:YES];
    }
}

#pragma mark -
#pragma mark String methods

//获取字符缓存
- (NSString *)stringForKey:(NSString *)key{
    return [[[NSString alloc] initWithData:[self dataForKey:key] encoding:NSUTF8StringEncoding]autorelease];
}

//存储字符
- (void)setString:(NSString *)aString forKey:(NSString *)aKey
{
    [self setString:aString forKey:aKey withTimeoutInterval:self.defaultTimeoutInterval];
}

- (void)setString:(NSString *)aString forKey:(NSString *)aKey withTimeoutInterval:(NSTimeInterval)timeoutInterval
{
    [self setData:[aString dataUsingEncoding:NSUTF8StringEncoding] forKey:aKey withTimeoutInterVal:timeoutInterval];
}

#pragma mark -
#pragma mark Image methds

//获取缓存图片
- (UIImage*)imageForKey:(NSString *)key{
    return [UIImage imageWithContentsOfFile:cachePathForKey(key)];
}

//存储图片
- (void)setImage:(UIImage *)anImage forKey:(NSString *)key{
    [self setImage:anImage forKey:key withTimeoutInterval:self.defaultTimeoutInterval];
}

- (void)setImage:(UIImage *)anImage forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval
{
    [self setData:UIImagePNGRepresentation(anImage) forKey:key withTimeoutInterVal:timeoutInterval];
}

#pragma mark -
#pragma mark Property List methods

//获取缓存plist数据
- (NSData*)plistForKey:(NSString *)key{
    NSData *plistData = [self dataForKey:key];
    
    return [NSPropertyListSerialization propertyListFromData:plistData mutabilityOption:NSPropertyListImmutable format:nil errorDescription:nil];
    
}

//存储plist对象
- (void)setPlist:(id)plistObject forKey:(NSString *)key{
    [self setString:plistObject forKey:key withTimeoutInterval:self.defaultTimeoutInterval];
}
- (void)setPlist:(id)plistObject forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval
{
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistObject format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
    
    [self setData:plistData forKey:key withTimeoutInterVal:timeoutInterval];
}

#pragma mark -
#pragma mark Disk writing operations

- (void)perforDiskWriteOperation:(NSInvocation *)invocation
{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithInvocation:invocation];
    
    [diskOperationQueue addOperation:operation];
    [operation release];
}

#pragma mark -
- (void)dealloc{
    [diskOperationQueue release];
    [cacheDictionary release];
    [super dealloc];
}
@end
