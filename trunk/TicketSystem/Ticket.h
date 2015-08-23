//
//  Ticket.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-27.
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

@interface Ticket : NSObject
{
    NSString *ticketID;
    NSString *ticketType;
    NSString *ticketPrice;
    NSString *ticketPosition;
    NSString *ticketCount;
}
@property (nonatomic,retain)NSString *ticketID;
@property (nonatomic,retain)NSString *ticketType;
@property (nonatomic,retain)NSString *ticketPrice;
@property (nonatomic,retain)NSString *ticketPosition;
@property (nonatomic,retain)NSString *ticketCount;

@end
