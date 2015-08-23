//
//  ZYProSoftNotiContentViewController.h
//  TicketSystem
//
//  Created by ZYVincent on 12-3-8.
//---------------------------------
//    文件作用：ZYProSoft团队通知详细情况视图
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
#import "ZYProSoftNoti.h"
@interface ZYProSoftNotiContentViewController : UIViewController
{
    ZYProSoftNoti *selfNoti;
}
@property (nonatomic,retain)ZYProSoftNoti *selfNoti;
@property (retain, nonatomic) IBOutlet UILabel *idLabel;
@property (retain, nonatomic) IBOutlet UILabel *usersLabel;
@property (retain, nonatomic) IBOutlet UILabel *contentLabel;
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateTimeLabel;

@property (retain, nonatomic) IBOutlet UILabel *subjectLabel;

@end
