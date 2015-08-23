//
//  TicketSystemAppDelegate.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-19.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "TicketSystemAppDelegate.h"
#import "TestViewController.h"

@implementation TicketSystemAppDelegate

@synthesize window = _window;
@synthesize viewController;
@synthesize mainTabViewController;

- (void)dealloc
{
    [_window release];
    [viewController release];
    [mainTabViewController release];
    [super dealloc];
}

//登录成功代理方法
- (void)loginSuccessed:(NSObject *)result
{    
    [self.viewController.view removeFromSuperview];
    [self.window addSubview:mainTabViewController.view];
    mainTabViewController.selectedIndex = 1;
    [mainTabViewController refreshTicketDataNow];//立即刷新票类信息

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //alloc mainTabViewController
    mainTabViewController = [[MainTabViewController alloc]init];
    
    //add mainviewController
    viewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    viewController.delegate = self;
    [self.window addSubview:viewController.view]; 
//    TestViewController *test = [[TestViewController alloc]initWithNibName:@"TestViewController" bundle:nil];
//    [self.window addSubview:test.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
