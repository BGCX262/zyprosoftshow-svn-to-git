//
//  OrderView.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-27.
//---------------------------------
//    文件作用：提示订票和退订得订单信息得视图，在选择完数量和生成
//            一张订票或者退订得单子等待用户确认操作
//            
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderViewDelegate <NSObject>
- (void)tapOnOrderViewButton:(id)sender;
@end
@interface OrderView : UIView
{
    UIImageView *backgroundImgView;
    UILabel *orderLabel;
    id<OrderViewDelegate> delegate;
    UIButton *cancelButton;
    UIButton *yesButton;
}
@property (nonatomic,retain)UILabel *orderLabel;
@property (nonatomic,assign)id<OrderViewDelegate> delegate;
@property (nonatomic,retain)UIButton *cancelButton;
@property (nonatomic,retain)UIButton *yesButton;
@property (nonatomic,retain)UIImageView *backgroundImgView;

@end
