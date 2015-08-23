//
//  ZYProSofter.h
//  TicketSystem
//
//  Created by ZYVincent on 12-3-5.
//---------------------------------
//    文件作用：ZYProSofter对象得model
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYProSofter : NSObject
{
    NSString *memberID;
    NSString *memberName;
    NSString *memberJoinTag;
}
@property (nonatomic,retain)NSString *memberID;
@property (nonatomic,retain)NSString *memberName;
@property (nonatomic,retain)NSString *memberJoinTag;

@end
