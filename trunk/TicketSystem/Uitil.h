//
//  Uitil.h
//  TicketSystem
//
//  Created by ZYVincent on 12-3-5.
//---------------------------------
//    文件作用：帮助类，可以写一些帮助方法，这里有身份证验证方法
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.

#import <Foundation/Foundation.h>

@interface Uitil : NSObject

//验证身份证号是否合法
+ (BOOL)checkIfPersonalIDNumber:(NSString *)IDNumber;

+ (NSString*)returnCurrentDateTime;
@end
