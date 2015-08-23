//
//  TicketSystemAppDelegate.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-19.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import <UIKit/UIKit.h>
#import "MainTabViewController.h"
#import "LoginViewController.h"
@interface TicketSystemAppDelegate : UIResponder <UIApplicationDelegate,LoginViewControllerDelegate>
{
    LoginViewController *viewController;
    MainTabViewController *mainTabViewController;
}
@property (strong, nonatomic) UIWindow *window;
@property (retain,nonatomic)LoginViewController *viewController;
@property (nonatomic,retain)MainTabViewController *mainTabViewController;

@end
