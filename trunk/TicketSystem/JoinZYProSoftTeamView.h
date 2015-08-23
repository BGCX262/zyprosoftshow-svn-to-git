//
//  JoinZYProSoftTeamView.h
//  TicketSystem
//
//  Created by ZYVincent on 12-3-6.
//---------------------------------
//    文件作用：申请加入ZYProSoft团队得验证视图
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

@protocol JoinZYProSoftTeamViewDelegate <NSObject>
- (void)tapOnJoinZYProSoftTeamViewButton:(id)sender;
@end
@interface JoinZYProSoftTeamView : UIView<UITextFieldDelegate>
{
    id<JoinZYProSoftTeamViewDelegate> delegate;
}
@property (nonatomic,assign)id<JoinZYProSoftTeamViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UILabel *notMemberNotiLabel;
@property (retain, nonatomic) IBOutlet UILabel *checkLabel;
@property (retain, nonatomic) IBOutlet UITextField *checkCodeField;
@property (retain, nonatomic) IBOutlet UIButton *yesButton;

- (IBAction)tapOnButton:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *canCelButton;

@end
