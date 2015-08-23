//
//  ZYProSoftNotiContentViewController.m
//  TicketSystem
//
//  Created by ZYVincent on 12-3-8.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "ZYProSoftNotiContentViewController.h"

@implementation ZYProSoftNotiContentViewController
@synthesize idLabel;
@synthesize usersLabel;
@synthesize contentLabel;
@synthesize typeLabel;
@synthesize dateTimeLabel;
@synthesize subjectLabel;
@synthesize selfNoti;


//转换通知类型
- (NSString *)returnRealNotiTypeWithType:(NSInteger)type
{
    NSString *typeString = nil;
    switch (type) {
        case NOTI_TYPE_NOTI:
            typeString = @"通知";
            break;
        case NOTI_TYPE_MEETING:
            typeString = @"会议";
            break;
        case NOTI_TYPE_GONGXI:
            typeString = @"恭喜";
            break;
        case NOTI_TYPE_GONGGAO:
            typeString = @"公告";
            break;
        case NOTI_TYPE_JINGGAO:
            typeString = @"警告";
            break;
        case NOTI_TYPE_JINJI:
            typeString = @"紧急";
            break;
        case NOTI_TYPE_QITA:
            typeString = @"其他";
            break;
            
        default:
            typeString = @"其他";
            break;
    }
    return typeString;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    subjectLabel.text = selfNoti.noti_subject;
    idLabel.text = selfNoti.noti_id;
    usersLabel.text = selfNoti.noti_users;
    contentLabel.text = selfNoti.noti_content;
    typeLabel.text = [self returnRealNotiTypeWithType:[selfNoti.noti_type intValue]];
    dateTimeLabel.text = selfNoti.noti_dateTime;
}

- (void)viewDidUnload
{
    [self setSubjectLabel:nil];
    [self setIdLabel:nil];
    [self setUsersLabel:nil];
    [self setContentLabel:nil];
    [self setTypeLabel:nil];
    [self setDateTimeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [selfNoti release];
    [subjectLabel release];
    [idLabel release];
    [usersLabel release];
    [contentLabel release];
    [typeLabel release];
    [dateTimeLabel release];
    [super dealloc];
}
@end
