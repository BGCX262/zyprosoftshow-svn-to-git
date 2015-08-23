//
//  ZYProSoftMemberViewController.h
//  TicketSystem
//
//  Created by ZYVincent on 12-3-5.
//---------------------------------
//    文件作用：ZYProSoft团队中心 可以查看所有ZYProSoft团队成员情况
//            支持验证码验证，申请加入团队等功能
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYPullRefreshTableViewController.h"
#import "ChooseTypeView.h"
#import "PreordainCell.h"
#import "JoinZYProSoftTeamView.h"

@interface ZYProSoftMemberViewController : ZYPullRefreshTableViewController<ChooseTypeViewDelegate,PreordainCellDelegate,JoinZYProSoftTeamViewDelegate,UIAlertViewDelegate>
{
    ChooseTypeView *typeChooseView;//选择查询类型
    JoinZYProSoftTeamView *joinTeamView;//加入ZYProSoft团队得视图
    BOOL joinTeamViewCanMove;//判定是否可以再移动
    
    NSMutableArray *cacheArray;//缓存数组
    BOOL typeChooseViewCanMove;//判定选择类型视图是否可以弹出
    
    NSInteger selectTypeIndex;//查询类型索引
    BOOL needRefreshNow;//是否需要立即刷新
}
@property (nonatomic,retain)NSMutableArray *cacheArray;

- (void)refreshNow;//立即刷新
@end
