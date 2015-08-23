//
//  Ticket.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-27.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "Ticket.h"

@implementation Ticket
@synthesize ticketID,ticketType,ticketCount,ticketPrice,ticketPosition;

- (void)dealloc{
    [ticketPosition release];
    [ticketID release];
    [ticketCount release];
    [ticketPrice release];
    [ticketType release];
    [super dealloc];
}
@end
