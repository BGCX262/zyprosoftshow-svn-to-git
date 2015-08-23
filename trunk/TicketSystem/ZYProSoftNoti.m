//
//  ZYProSoftNoti.m
//  TicketSystem
//
//  Created by ZYVincent on 12-3-8.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "ZYProSoftNoti.h"

@implementation ZYProSoftNoti
@synthesize noti_id,noti_type,noti_users,noti_content,noti_subject,noti_dateTime;
- (void)dealloc{
    [noti_subject release];
    [noti_id release];
    [noti_type release];
    [noti_users release];
    [noti_content release];
    [noti_dateTime release];
    [super dealloc];
}
@end
