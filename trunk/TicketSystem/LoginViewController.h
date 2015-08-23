//
//  LoginViewController.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-27.
//---------------------------------
//    文件作用：登陆窗口
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

@protocol LoginViewControllerDelegate <NSObject>
- (void)loginSuccessed:(NSObject*)result;
@end
@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    id<LoginViewControllerDelegate> delegate;
    
    BOOL kitIfMoved;
    
    BOOL ifRememberPwd;//是否记住密码
}
@property (nonatomic,assign)id<LoginViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UITextField *idTextField;
@property (retain, nonatomic) IBOutlet UITextField *pwdTextField;
@property (retain, nonatomic) IBOutlet UILabel *idLabel;
@property (retain, nonatomic) IBOutlet UILabel *pwdLabel;
@property (retain, nonatomic) IBOutlet UIButton *rememberBtn;
@property (retain, nonatomic) IBOutlet UIButton *registBtn;
@property (retain, nonatomic) IBOutlet UIButton *loginBtn;
@property (retain, nonatomic) IBOutlet UIImageView *inputBackImgView;
@property (nonatomic)BOOL kitIfMoved;

- (IBAction)loginAction:(id)sender;
- (IBAction)registAction:(id)sender;
- (IBAction)rememberPwdAction:(id)sender;

@end
