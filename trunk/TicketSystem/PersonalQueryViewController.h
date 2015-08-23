//
//  PersonalQueryViewController.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-19.
//---------------------------------
//    文件作用：退订票和个人所有票信息界面
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
#import "ZYSearchTableViewController.h"
#import "PreordainCell.h"
#import "ChooseCountView.h"
#import "ChooseTypeView.h"
#import "OrderView.h"

@interface PersonalQueryViewController : ZYSearchTableViewController<OrderViewDelegate,PreordainCellDelegate,ChooseCountViewDelegate,ChooseTypeViewDelegate>
{
    ChooseCountView *chooseView;
    ChooseTypeView *chooseTypeView;
    OrderView *tuiDingOrderView;//生成退订单得视图
    
    NSInteger selectTypeIndex;
    
    NSMutableArray *cacheArray;//存储用户票信息
    
    BOOL needRefreshNow;//判断是不是需要立即刷新
    
    NSMutableArray *commonArray;//tableview数据源，供随时改变用
    
    NSInteger tuiDingCount;//需要退订得数量
    NSInteger selectTicketIndex;//选中要退订票得Index值
    
    BOOL chooseTypeViewCanMove;//决定选择类型view是否可以推出
    BOOL chooseCountViewCanMove;//决定选择选择数量view是否可以推出
    BOOL orderViewCanMove;//决定退订单信息是否可以出现
}
@property (nonatomic,retain)ChooseCountView *chooseView;
@property (nonatomic)NSInteger selectTypeIndex;
@property (nonatomic,retain)NSMutableArray *cacheArray;
@property (nonatomic)BOOL needRefreshNow;
@property (nonatomic,retain)NSMutableArray *commonArray;
@property (nonatomic)NSInteger tuiDingCount;
@property (nonatomic)NSInteger selectTicketIndex;

- (void)getPersonalAllTicketInfoNow;
- (BOOL)pushViewNowIsUnEnable;//判断现在是不是可以推出新得pushview
@end
