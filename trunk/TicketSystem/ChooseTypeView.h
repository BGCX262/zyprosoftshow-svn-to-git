//
//  ChooseTypeView.h
//  TicketSystem
//
//  Created by ZYVincent on 12-3-1.
//---------------------------------
//    文件作用：选择搜索类型时用到得类，作为基类使用
//            
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2012年 __ZYVincent__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseTypeViewDelegate <NSObject>
- (void)tapOnChooseTypeViewButton:(id)sender withSelectIndex:(NSInteger)index;
@end
@interface ChooseTypeView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    id<ChooseTypeViewDelegate>delegate;
    UIButton *cancelBtn;
    UIButton *yesBtn;
    
    NSInteger selectTypeIndex;
    
    UIPickerView *choosePickView;
    
    NSArray *sourceArray;//标题数组
    NSArray *indexArray;//类型数组
}
@property (nonatomic,assign)id<ChooseTypeViewDelegate> delegate;
@property (nonatomic,retain)NSArray *sourceArray;
@property (nonatomic,retain)UIPickerView *choosePickView;
@property (nonatomic,retain)NSArray *indexArray;

@property (nonatomic)NSInteger selectTypeIndex;
@property (nonatomic,retain)UIButton *cancelBtn;
@property (nonatomic,retain)UIButton *yesBtn;


@end
