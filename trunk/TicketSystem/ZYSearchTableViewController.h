//
//  ZYSearchTableViewController.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-24.
//---------------------------------
//    文件作用：带搜索栏得自定义TableViewController，作为基类使用
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//

#import "ZYSearchBar.h"

@interface ZYSearchTableViewController : UITableViewController<ZYSearchBarDelegate>
{
    ZYSearchBar *searchBar;
}
@property (nonatomic,retain)ZYSearchBar *searchBar;

//将searchbar添加到tableview上面
- (void)addSearchBarToTableView;

@end
