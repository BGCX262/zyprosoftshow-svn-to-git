//
//  OrderView.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-27.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "OrderView.h"

@implementation OrderView
@synthesize orderLabel,delegate;
@synthesize cancelButton,yesButton;
@synthesize backgroundImgView;

- (void)tapOnButton:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(tapOnOrderViewButton:)]) {
        [delegate tapOnOrderViewButton:sender];
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        backgroundImgView = [[UIImageView alloc]init];
        backgroundImgView.frame = CGRectMake(0, 0, 320, 300);
        backgroundImgView.image = [UIImage imageNamed:@"orderViewBackground.png"];
        [self addSubview:backgroundImgView];
        [backgroundImgView release];
        
        //add orderlabel
        orderLabel = [[UILabel alloc]init];
        orderLabel.backgroundColor = [UIColor clearColor];
        orderLabel.frame = CGRectMake(20, 0, 290, 230);
        orderLabel.numberOfLines = 0;
        orderLabel.font = [UIFont boldSystemFontOfSize:15];
        orderLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview: orderLabel];
        [orderLabel release];
        
        //add cancel button
        cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelButton.frame = CGRectMake(80, 200, 65,45);
        cancelButton.tag = ORDERVIEW_CANCEL_BUTTON_TAG;
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"orderButtonCancel.png"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        //add yes button
        yesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        yesButton.frame = CGRectMake(190, 200, 65, 45);
        yesButton.tag = ORDERVIEW_YES_BUTTON_TAG;
        [yesButton setBackgroundImage:[UIImage imageNamed:@"orderButtonYes.png"] forState:UIControlStateNormal];
        [yesButton addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:yesButton];
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

@end
