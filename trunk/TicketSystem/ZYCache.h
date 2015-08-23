//
//  ZYCache.h
//  ZYToolKit
//
//  Created by Vincent_HU  on 11-12-23.
//  Copyright (c) 2011年 __ZYProSoft__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCache : NSObject
{
@private
	NSMutableDictionary* cacheDictionary;
	NSOperationQueue* diskOperationQueue;
	NSTimeInterval defaultTimeoutInterval;
}
@property (nonatomic,assign)NSTimeInterval defaultTimeoutInterval;
//单例对象
+ (ZYCache *)currentCache;

- (void)clearCache;//清空缓存
- (void)removeCacheForKey:(NSString *)key;//清空某项缓存

- (BOOL)hasCacheForKey:(NSString*)key;//判断某项是否有缓存

//－－－－－－－－//  二进制数据缓存 //------------//
- (NSData*)dataForKey:(NSString*)key;//依据关键字获取NSData数据
- (void)setData:(NSData*)data forKey:(NSString*)key;//使用关键字存储数据到缓存
- (void)setData:(NSData *)data forKey:(NSString *)key withTimeoutInterVal:(NSTimeInterval)timeoutInterval;//在指定操作时间限制下缓存数据

//－－－－－－－－//  字符缓存 //------------//
- (NSString*)stringForKey:(NSString*)key;//获取字符数据缓存
- (void)setString:(NSString*)aString forKey:(NSString *)aKey;//依据关键字存储字符数据
- (void)setString:(NSString *)aString forKey:(NSString *)aKey withTimeoutInterval:(NSTimeInterval)timeoutInterval;//在指定操作时间限制下缓存字符数据

//－－－－－－－－//  图片缓存 //------------//
- (UIImage*)imageForKey:(NSString*)key;//依据关键字获取缓存图片
- (void)setImage:(UIImage*)anImage forKey:(NSString*)key;//使用关键字存储图片
- (void)setImage:(UIImage *)anImage forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;//在指定操作时间限制下缓存图片

//－－－－－－－－//  plist缓存 //------------//
- (NSData*)plistForKey:(NSString*)key;//依据关键字获取plist数据
- (void)setPlist:(id)plistObject forKey:(NSString*)key;//使用关键字存储plist对象
- (void)setPlist:(id)plistObject forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;//在指定操作时间限制下缓存plist对象

//－－－－－－－－//  文件操作 //------------//
- (void)copyFilePath:(NSString*)filePath asKey:(NSString*)key;//使用关键字存储新的文件路径
- (void)copyFilePath:(NSString*)filePath asKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;//在指定操作时间限制下复制新的文件路径
@end
