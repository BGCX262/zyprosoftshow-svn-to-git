//
//  ChooseCountView.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-21.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "ChooseCountView.h"

@implementation ChooseCountView
@synthesize delegate;
@synthesize maxCount;
@synthesize choosePickView;
@synthesize cancelBtn;
@synthesize yesBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //背景皮肤
        UIImageView *backgroundImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,200)];
        backgroundImgView.image = [UIImage imageNamed:@"chooseViewBackgroundView.png"];
        [self addSubview:backgroundImgView];
        [backgroundImgView release];
        
        
        choosePickView = [[UIPickerView alloc]init];
        choosePickView.frame = CGRectMake(0, 40, 320, 80);
        choosePickView.showsSelectionIndicator = YES;
        choosePickView.delegate = self;
        choosePickView.dataSource = self;
        [self addSubview:choosePickView];
        [choosePickView release];
        
        //add label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 35)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentLeft;
        label.text = @"请选择张数";
        label.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:label];
        [label release];
        
        //add cancel button
        cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelBtn.frame = CGRectMake(160, 2, 60, 35);
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"chooseViewButtonCancel.png"] forState:UIControlStateNormal];
        cancelBtn.tag = CHOOSEVIEW_CANCEL_BUTTON_TAG;
        [cancelBtn addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        //add yes button
        yesBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        yesBtn.frame = CGRectMake(235, 2, 60, 35);
        [yesBtn setBackgroundImage:[UIImage imageNamed:@"chooseViewButtonYes.png"] forState:UIControlStateNormal];
        yesBtn.tag = CHOOSEVIEW_YES_BUTTON_TAG;
        [yesBtn addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:yesBtn];
        
        //默认选中一张
        selectCount = 1;
    }
    return self;
}
- (id)initChooseCountViewWithMaxCount:(NSInteger)count
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.maxCount = count;
        
        self.backgroundColor = [UIColor grayColor];
        choosePickView = [[UIPickerView alloc]init];
        choosePickView.frame = CGRectMake(0, 40, 320, 80);
        choosePickView.showsSelectionIndicator = YES;
        choosePickView.delegate = self;
        choosePickView.dataSource = self;
        [self addSubview:choosePickView];
        [choosePickView release];
        
        //add label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 35)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentLeft;
        label.text = @"请选择张数";
        label.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:label];
        [label release];
        
        //add cancel button
        cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelBtn.frame = CGRectMake(160, 2, 60, 35);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.tag = CHOOSEVIEW_CANCEL_BUTTON_TAG;
        [cancelBtn addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        //add yes button
        yesBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        yesBtn.frame = CGRectMake(235, 2, 60, 35);
        [yesBtn setTitle:@"确定" forState:UIControlStateNormal];
        yesBtn.tag = CHOOSEVIEW_YES_BUTTON_TAG;
        [yesBtn addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:yesBtn];
        
        //默认选中一张
        selectCount = 1;
    }
    return self;
}
-(void)tapOnButton:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(tapOnChooseViewButton:withSelectedCount:)]) {
        [delegate tapOnChooseViewButton:sender withSelectedCount:selectCount];
    }
}
#pragma mark - datasource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return maxCount;//每人最多限定10张票
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d",row+1];
}
#pragma mark -delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectCount = row+1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}
@end
