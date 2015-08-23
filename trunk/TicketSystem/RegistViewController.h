//
//  RegistViewController.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-27.
//---------------------------------
//    文件作用：注册界面
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

@interface RegistViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *backScrollView;
@property (retain, nonatomic) IBOutlet UITextField *idTextField;
@property (retain, nonatomic) IBOutlet UITextField *nameTextField;
@property (retain, nonatomic) IBOutlet UITextField *pwdTextField;
@property (retain, nonatomic) IBOutlet UITextField *rePwdTextField;
- (IBAction)registAction:(id)sender;
- (IBAction)cancelRegistAction:(id)sender;

@end
