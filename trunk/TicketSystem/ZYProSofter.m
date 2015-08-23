//
//  ZYProSofter.m
//  TicketSystem
//
//  Created by ZYVincent on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "ZYProSofter.h"

@implementation ZYProSofter
@synthesize memberID,memberName,memberJoinTag;
- (void)dealloc{
    [memberID release];
    [memberName release];
    [memberJoinTag release];
    [super dealloc];
}
@end
