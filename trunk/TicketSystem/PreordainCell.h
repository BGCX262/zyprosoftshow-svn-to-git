//
//  PreordainCell.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-19.
//---------------------------------
//    文件作用：订票与退订tableViewController用到得Cell，
//            可以显示ticket对象得所有信息
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
// 

#import <UIKit/UIKit.h>
#import "Ticket.h"
#import "ZYProSofter.h"

@protocol PreordainCellDelegate <NSObject>
- (void)tapOnPreordainButton:(id)sender;
@end
@interface PreordainCell : UITableViewCell
{
    id<PreordainCellDelegate> delegate;
}
@property (retain, nonatomic) IBOutlet UILabel *PositionContentLabel;
@property (retain, nonatomic) IBOutlet UILabel *ticketIDLabel;
@property (retain, nonatomic) IBOutlet UILabel *ticketTypeLabel;
@property (retain, nonatomic) IBOutlet UILabel *ticketPriceLabel;
@property (retain, nonatomic) IBOutlet UILabel *ticketPositionLabel;
@property (retain, nonatomic) IBOutlet UILabel *IDContentLabel;
@property (retain, nonatomic) IBOutlet UILabel *TypeContentLabel;
@property (retain, nonatomic) IBOutlet UILabel *PriceContentLabel;
@property (retain, nonatomic) IBOutlet UILabel *LastCountLabel;
@property (retain, nonatomic) IBOutlet UIButton *PreordainButton;
@property (retain, nonatomic) IBOutlet UIImageView *typeImage;
@property (retain, nonatomic) IBOutlet UILabel *ticketLastCountLabel;
- (IBAction)tapOnButton:(id)sender;
@property (nonatomic,assign)id<PreordainCellDelegate> delegate;

- (void)setTicketInfo:(Ticket *)ticket;
- (void)setZYProSofter:(ZYProSofter *)zyProSofter;

@end
