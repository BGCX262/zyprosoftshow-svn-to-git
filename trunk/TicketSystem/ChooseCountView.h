//
//  ChooseCountView.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-21.
//---------------------------------
//    文件作用：选择订票数量和退订数量用到得视图，提供一个pickeView来选择数量
//            
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
// 

#import <UIKit/UIKit.h>

@protocol ChooseCountViewDelegate <NSObject>
- (void)tapOnChooseViewButton:(id)sender withSelectedCount:(NSInteger)count;
@end
@interface ChooseCountView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    //最大数量
    NSInteger maxCount;
    //最终选择数
    NSInteger selectCount;
    UIPickerView *choosePickView;
    
    id<ChooseCountViewDelegate> delegate;
    
    UIButton *cancelBtn;
    UIButton *yesBtn;
}
@property (nonatomic,assign)id<ChooseCountViewDelegate> delegate;
@property (nonatomic)NSInteger maxCount;
@property (nonatomic,retain)UIPickerView *choosePickView;
@property (nonatomic,retain)UIButton *yesBtn;
@property (nonatomic,retain)UIButton *cancelBtn;

- (void)tapOnButton:(id)sender;

- (id)initChooseCountViewWithMaxCount:(NSInteger)count;
@end
