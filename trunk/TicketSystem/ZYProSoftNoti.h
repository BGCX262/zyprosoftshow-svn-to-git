//
//  ZYProSoftNoti.h
//  TicketSystem
//
//  Created by ZYVincent on 12-3-8.
//---------------------------------
//    文件作用：ticket对象得model
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYProSoftNoti : NSObject
{
    NSString *noti_id;
    NSString *noti_type;
    NSString *noti_subject;
    NSString *noti_users;
    NSString *noti_content;
    NSString *noti_dateTime;
}
@property (nonatomic,retain)NSString *noti_id;
@property (nonatomic,retain)NSString *noti_type;
@property (nonatomic,retain)NSString *noti_subject;
@property (nonatomic,retain)NSString *noti_users;
@property (nonatomic,retain)NSString *noti_content;
@property (nonatomic,retain)NSString *noti_dateTime;

@end
