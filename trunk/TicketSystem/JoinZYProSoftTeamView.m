//
//  JoinZYProSoftTeamView.m
//  TicketSystem
//
//  Created by ZYVincent on 12-3-6.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "JoinZYProSoftTeamView.h"

@implementation JoinZYProSoftTeamView
@synthesize notMemberNotiLabel;
@synthesize checkLabel;
@synthesize checkCodeField;
@synthesize yesButton;
@synthesize canCelButton;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //owner:self 设置完之后fileowner就连接view了，否则在这个view上面声明得delegate无法执行
        self = [[[NSBundle mainBundle]loadNibNamed:@"JoinZYProSoftTeamView" owner:self options:nil]objectAtIndex:0];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)dealloc {
    [notMemberNotiLabel release];
    [checkLabel release];
    [checkCodeField release];
    [canCelButton release];
    [yesButton release];
    [super dealloc];
}
- (IBAction)tapOnButton:(id)sender {
    
    [checkCodeField resignFirstResponder];
    NSLog(@"join here");
    if (delegate && [delegate respondsToSelector:@selector(tapOnJoinZYProSoftTeamViewButton:)]) {
        [delegate tapOnJoinZYProSoftTeamViewButton:sender];
    }
}
@end
