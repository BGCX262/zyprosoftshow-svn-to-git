//
//  ZYNetworkHelper.m
//  ZYToolKit
//
//  Created by ZYVincent_HU  on 11-12-23.
//  Copyright (c) 2011年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "ZYNetworkHelper.h"
#import "NSDictionary+UrlEncodedString.h"

static ZYNetworkHelper *shareHelper;
@implementation ZYNetworkHelper
@synthesize urlConnection = _urlConnection;
@synthesize urlRequest = _urlRequest;
@synthesize activeData = _activeData;
@synthesize requestTimeoutInterval;
@synthesize jsonParser;
@synthesize connectionsForCallBackDict;

+ (id)shareZYNetworkHelper
{
    @synchronized(self){
        if (!shareHelper) {
            shareHelper = [[self alloc]init];
        }
    }
    return shareHelper;
}
- (id)init{
    self = [super init];
    if (self) {
        self.requestTimeoutInterval = 30;
        self.jsonParser = [[SBJsonParser alloc]init];
        self.connectionsForCallBackDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

#pragma mark - 
#pragma mark requestApplicationType
//符合当前TicketSystem得请求类型
- (void)requestDataWithApplicationType:(TicketSystemRequestType)requestType withParams:(NSDictionary *)params withHelperDelegate:(id)CallBackDelegate withSuccessRequestMethod:(NSString *)successMethod withFaildRequestMethod:(NSString *)faildMethod
{
    //build URL with Requestion type
    NSURL *requestUrl = nil;

    switch (requestType) {
        case TicketSystemRequestRegistType:
            requestUrl = [NSURL URLWithString:REGIST_INTERFACE_URL];
            break;
        case TicketSystemRequestLoginType:
            requestUrl = [NSURL URLWithString:LOGIN_INTERFACE_URL];
            break;
        case TicketSystemRequestPreordainType:
            requestUrl = [NSURL URLWithString:PREORDAIN_INTERFACE_URL];
            break;
        case TicketSystemRequestQueryType:
            requestUrl = [NSURL URLWithString:QUERY_INTERFACE_URL];
            break;
        case TicketSystemRequestUnsunscribeType:
            requestUrl = [NSURL URLWithString:UNSUBSCRIBE_INTERFACE_URL];
            break;
        case TicketSystemRequestHomePageAndAboutType:
            requestUrl = [NSURL URLWithString:HOMEPAGE_AND_ABOUT_INTERFACE_URL];
            break;
        case TicketSystemRequestZYProSofterType:
            requestUrl = [NSURL URLWithString:ZYPROSOFT_TEAM_INTERFACE_URL];
            break;
        default:
            break;
    }
    
    //use url with function :RequestionMethod 
    //接收callbackDelegate 和 成功调用方法 失败调用方法
    NSDictionary *callBackDict = [NSDictionary dictionaryWithObjectsAndKeys:CallBackDelegate,@"delegate",successMethod,@"success",faildMethod,@"faild", nil];
    
    NSDictionary *paramDict = params;
    NSMutableData *paramData = [NSMutableData data];
    NSMutableString *paramString = [NSMutableString string];
    //处理params
    if (nil == params) {
        
    }else{
        
        for (id key in [paramDict keyEnumerator]) {
//            NSString *string = [NSString stringWithFormat:@"\"%@\"=\"%@,",key,[params valueForKey:key]];
            NSString *string = [params urlEncodedString];//编码成php页面能够接受得参数
            [paramString appendString:string];
            
        }
        [paramData appendData:[[NSString stringWithFormat:@"%@",paramString] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    
    //设置请求参数
    request.HTTPMethod = @"POST";//这里一定要注意，必须和php页面要求接收参数得方法一致
    request.timeoutInterval = self.requestTimeoutInterval;
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    request.HTTPBody = paramData;
    
    //判断当前请求是否为空对象,是则清空，否则创建连接
    if (nil != _urlConnection ) {
        
        [_urlConnection release];
        _urlConnection = nil;
    }
    _urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    
    
    //判断当前存储是否有数据，是则清空，否则创建
    if (nil != _activeData) {
        [_activeData release];
        _activeData = nil;
    }
    _activeData = [[NSMutableData alloc]initWithLength:0];
    
    //存储新建连接的所有信息
    [connectionsForCallBackDict setObject:callBackDict forKey:[NSNumber numberWithLongLong:[_urlConnection hash]]];
    
    //开始请求
    //    [_urlConnection start];    

}
#pragma mark -
#pragma mark requestMethod

//请求数据
- (void)requestDataFromURL:(NSString *)url withParams:(NSDictionary *)params withHelperDelegate:(id)CallBackDelegate withSuccessRequestMethod:(NSString*)successMethod withFaildRequestMethod:(NSString*)faildMethod
{
    
    //接收callbackDelegate 和 成功调用方法 失败调用方法
    NSDictionary *callBackDict = [NSDictionary dictionaryWithObjectsAndKeys:CallBackDelegate,@"delegate",successMethod,@"success",faildMethod,@"faild", nil];
    
    NSDictionary *paramDict = params;
    NSMutableData *paramData = [NSMutableData data];
    NSMutableString *paramString = [NSMutableString string];
    //处理params
    if (nil == params) {
        
    }else{
        
        for (id key in [paramDict keyEnumerator]) {
            NSString *string = [NSString stringWithFormat:@"\"%@\":\"%@,",key,[params valueForKey:key]];
            [paramString appendString:string];
            
        }
        [paramData appendData:[[NSString stringWithFormat:@"{%@",paramString] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //设置请求参数
    request.HTTPMethod = @"POST";
    request.timeoutInterval = self.requestTimeoutInterval;
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    request.HTTPBody = paramData;
    
    //判断当前请求是否为空对象,是则清空，否则创建连接
    if (nil != _urlConnection ) {
        
        [_urlConnection release];
        _urlConnection = nil;
    }
    _urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    

    
    //判断当前存储是否有数据，是则清空，否则创建
    if (nil != _activeData) {
        [_activeData release];
        _activeData = nil;
    }
    _activeData = [[NSMutableData alloc]initWithLength:0];
    
    //存储新建连接的所有信息
    [connectionsForCallBackDict setObject:callBackDict forKey:[NSNumber numberWithLongLong:[_urlConnection hash]]];
    
    //开始请求
//    [_urlConnection start];    
}

- (void)cancel{
    [_urlConnection cancel];
}

- (void)alertWithErrorCode:(NSInteger)errorCode
{
    NSString *errorMessage = nil;
    switch (errorCode) {
        case NSURLErrorBadURL:
            errorMessage = @"网络地址无效";
            break;
        case NSURLErrorCannotConnectToHost:
            errorMessage = @"服务器没有响应";
            break;
        case NSURLErrorCannotFindHost:
            errorMessage = @"无法找到指定主机";
            break;
        case NSURLErrorCannotParseResponse:
            errorMessage = @"无法解析回复";
            break;
        case NSURLErrorBadServerResponse:
            errorMessage = @"错误得服务器返回";
            break;
            
        default:
            errorMessage = nil;
            break;
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"网络错误" message:errorMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

#pragma mark - 
#pragma mark connectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%@",response);
    //重新接收数据
    if (_activeData != nil) {
        [_activeData release];
        _activeData = nil;
    }
    _activeData = [[NSMutableData alloc]initWithLength:0];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self alertWithErrorCode:[error code]];//错误处理
    
    //获取connection匹配
    NSNumber *connectionKey = [NSNumber numberWithLongLong:[connection hash]];
    
    //执行失败响应方法 
    for (id key in [connectionsForCallBackDict keyEnumerator]) {
        if ([key longLongValue] == [connectionKey longLongValue]) {
            //获取当前connection对应的dict
            NSDictionary *connectDict = [connectionsForCallBackDict objectForKey:key];
            
            //执行代理方法
            [[connectDict objectForKey:@"delegate"] performSelector:NSSelectorFromString([connectDict objectForKey:@"faild"]) withObject:@"Request Faild!"];
            break;
        }
    }
    [connectionsForCallBackDict removeObjectForKey:connectionKey];//移除这个连接
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{    

    //将数据存储到活动数据缓存中收集
    [_activeData appendData:data];
    
}
//收取数据完了开始解析传递给请求得对象
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //获取connection匹配
    NSNumber *connectionKey = [NSNumber numberWithLongLong:[connection hash]];
    
    //将data转化为dict
    NSDictionary *resultDict = [jsonParser objectWithData:_activeData];
    
    NSLog(@"result dict is %@",resultDict);
    NSLog(@"connectionForcallBackDict is %@",connectionsForCallBackDict);
    
    //将数据传递给请求者
    for (id key in [connectionsForCallBackDict keyEnumerator]) {
        NSLog(@"%@",key);
        if ([key  longLongValue] == [connectionKey longLongValue]) {
            //获取当前connection对应的dict
            NSDictionary *connectDict = [connectionsForCallBackDict objectForKey:key];
            
            //执行代理方法
            [[connectDict objectForKey:@"delegate"] performSelector:NSSelectorFromString([connectDict objectForKey:@"success"]) withObject:resultDict];
            
        }
        
    }
    [connectionsForCallBackDict removeObjectForKey:connectionKey];//移除连接
    //将活动数据设为空，重新接收新数据
    [_activeData release];
    _activeData = nil;
}
#pragma mark - dealloc
- (void)dealloc{
    
    [connectionsForCallBackDict release];
    [jsonParser release];
    [_urlConnection release];
    [_urlRequest release];
    [_activeData release];
    [super dealloc];
}
@end
