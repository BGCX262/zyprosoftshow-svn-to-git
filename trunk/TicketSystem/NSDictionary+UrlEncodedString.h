//
//  NSDictionary+UrlEncodedString.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-28.
//---------------------------------
//    文件作用：转换参数字典为php页面能接受得编码
//           
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(UrlString)
- (NSString*)urlEncodedString;
@end
