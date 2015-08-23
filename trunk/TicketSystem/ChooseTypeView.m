//
//  ChooseTypeView.m
//  TicketSystem
//
//  Created by ZYVincent on 12-3-1.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "ChooseTypeView.h"

@implementation ChooseTypeView
@synthesize delegate;
@synthesize selectTypeIndex;
@synthesize cancelBtn,yesBtn;
@synthesize sourceArray;
@synthesize choosePickView;
@synthesize indexArray;

- (void)tapOnButton:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(tapOnChooseTypeViewButton:withSelectIndex:)]) {
        [delegate tapOnChooseTypeViewButton:sender withSelectIndex:selectTypeIndex];
    }
}
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
        
        //add label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 35)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentLeft;
        label.text = @"请选择类型";
        label.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:label];
        [label release];
        
        //add cancel button
        cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelBtn.frame = CGRectMake(160, 2, 60, 35);
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"chooseViewButtonCancel.png"] forState:UIControlStateNormal];
        cancelBtn.tag = CHOOSETYPE_CANCEL_BUTTON_TAG;
        [cancelBtn addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        //add yes button
        yesBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        yesBtn.frame = CGRectMake(235, 2, 60, 35);
        [yesBtn setBackgroundImage:[UIImage imageNamed:@"chooseViewButtonYes.png"] forState:UIControlStateNormal];
        yesBtn.tag = CHOSSETYPE_YES_BUTTON_TAG;
        [yesBtn addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:yesBtn];
        
        choosePickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, 320, 80)];
        choosePickView.showsSelectionIndicator = YES;
        choosePickView.delegate = self;
        choosePickView.dataSource = self;
        selectTypeIndex = QUERY_BY_TICKET_ID;
        
        [self addSubview:choosePickView];
        [choosePickView release];
        
        //初始化sourceArray
        sourceArray = [[NSArray alloc]initWithObjects:@"票ID",@"票类型",@"票价",@"票位置", nil];
        indexArray = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",QUERY_BY_TICKET_ID],[NSString stringWithFormat:@"%d",QUERY_BY_TICKET_TYPE],[NSString stringWithFormat:@"%d",QUERY_BY_TICKET_PRICE],[NSString stringWithFormat:@"%d",QUERY_BY_TICKET_POSITION], nil];
}
    return self;
}

//pickView Datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [sourceArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [sourceArray objectAtIndex:row];
}

//pickViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    switch (row) {
//        case 0:
//            selectTypeIndex = [[indexArray objectAtIndex:row]intValue];
//            break;
//        case 1:
//            selectTypeIndex = [[indexArray objectAtIndex:row]intValue];
//            break;
//        case 2:
//            selectTypeIndex = QUERY_BY_TICKET_PRICE;
//            break;
//        case 3:
//            selectTypeIndex = QUERY_BY_TICKET_POSITION;
//            break;
//            
//        default:
//            selectTypeIndex = QUERY_BY_TICKET_ID;
//            break;
//    }
    selectTypeIndex = [[indexArray objectAtIndex:row]intValue];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)dealloc{
    [sourceArray release];
    [indexArray release];
    [super dealloc];
}
@end
