//
//  ZYProSoftNotiCell.h
//  TicketSystem
//
//  Created by ZYVincent on 12-3-8.
//---------------------------------
//    文件作用：ZYProSoft团队通知视图
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

@interface ZYProSoftNotiCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *usersLabel;
@property (retain, nonatomic) IBOutlet UILabel *subjectLabel;
@property (retain, nonatomic) IBOutlet UIImageView *cellBackgroundImgView;
@property (retain, nonatomic) IBOutlet UIImageView *notiTypeImgView;

- (void)setWithNotiSubject:(NSString *)subject withNotiUser:(NSString *)users;
@end
