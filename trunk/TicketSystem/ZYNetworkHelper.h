//
//  ZYNetworkHelper.h
//  ZYToolKit
//
//  Created by ZYVincent_HU  on 11-12-23.
//---------------------------------
//    文件作用：全局网络请求组件，采用NSURLConnection编写，支持异步请求，多个请求。
//            结合SBJson包，在获取结果后直接解析出json数据。调用方法简单。支持内部简单得错误处理报告
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2011年 __ZYProSoft__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJsonParser.h"

//-----------------应用程序请求类型---------------//
typedef enum{
    TicketSystemRequestRegistType = 0,
    TicketSystemRequestLoginType,
    TicketSystemRequestQueryType,
    TicketSystemRequestPreordainType,
    TicketSystemRequestUnsunscribeType,
    TicketSystemRequestHomePageAndAboutType,
    TicketSystemRequestZYProSofterType,
    
}TicketSystemRequestType;


@interface ZYNetworkHelper : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
@private
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_urlRequest;
    
    NSTimeInterval requestTimeoutInterval;
    NSMutableData *_activeData;
    
    SBJsonParser *jsonParser;

    NSMutableDictionary *connectionsForCallBackDict;
}
@property (nonatomic,retain)NSURLConnection *urlConnection;
@property (nonatomic,retain)NSMutableURLRequest *urlRequest;
@property (retain)NSMutableData *activeData;
@property (nonatomic)NSTimeInterval requestTimeoutInterval;
@property (nonatomic,retain)SBJsonParser *jsonParser;
@property (nonatomic,retain)NSMutableDictionary *connectionsForCallBackDict;

+ (id)shareZYNetworkHelper;
- (id)init;

//请求某个网络地址数据
- (void)requestDataFromURL:(NSString*)url 
                withParams:(NSDictionary*)params 
        withHelperDelegate:(id)CallBackDelegate withSuccessRequestMethod:(NSString*)successMethod withFaildRequestMethod:(NSString*)faildMethod;

//为特定应用程序请求数据
- (void)requestDataWithApplicationType:(TicketSystemRequestType)requestType withParams:(NSDictionary *)params withHelperDelegate:(id)CallBackDelegate withSuccessRequestMethod:(NSString *)successMethod withFaildRequestMethod:(NSString *)faildMethod;
@end
