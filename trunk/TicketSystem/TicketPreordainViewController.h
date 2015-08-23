//
//  TicketPreordainViewController.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-19.
//---------------------------------
//    文件作用：订票窗口得界面
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
#import "PreordainCell.h"
#import "ChooseCountView.h"
#import "ZYPullRefreshTableViewController.h"
#import "OrderView.h"
#import "ChooseTypeView.h"

@interface TicketPreordainViewController : ZYPullRefreshTableViewController<PreordainCellDelegate,ChooseCountViewDelegate,OrderViewDelegate,ChooseTypeViewDelegate>
{
    ChooseCountView *chooseView;
    OrderView *orderView;
    ChooseTypeView *typeChooseView;
    
    NSMutableArray *cacheArray;//存储所有票类信息

    NSInteger selectRowIndex;//按下订票按钮得tag值
    NSInteger selectOrderCount;//订票张数
    NSInteger selectTypeIndex;//选择搜索类型选中参数
    
    BOOL chooseTypeViewCanMove;//决定选择类型view是否可以推出
    BOOL chooseCountViewCanMove;//决定选择选择数量view是否可以推出
    BOOL orderViewCanMove;//决定退订单信息是否可以出现
}
@property (nonatomic,retain)NSMutableArray *cacheArray;
@property (nonatomic)NSInteger selectRowIndex;
@property (nonatomic)NSInteger selectOrderCount;

//立即刷新方法
- (void)refreshNow;
- (BOOL)pushViewNowIsUnEnable;//判断现在是不是可以推出新得pushview

@end
