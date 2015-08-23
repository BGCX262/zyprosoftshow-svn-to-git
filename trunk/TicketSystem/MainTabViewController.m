//
//  MainTabViewController.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-19.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "MainTabViewController.h"
#import "HomePageViewController.h"
#import "TicketPreordainViewController.h"
#import "PersonalQueryViewController.h"
#import "AboutViewController.h"
#import "ZYProSoftMemberViewController.h"

#define RED_VALUE 2
#define GREEN_VALUE 75
#define BLUE_VALUE 104
#define COLOR_ALPHA 1

@implementation MainTabViewController
@synthesize customTabBarItems;

//替换默认得tabbar
- (void)initCustomTabBar
{
    customTabBarItems=[[NSMutableArray alloc]init];
    
    //自定义tabbar
    UIView *customTabBar=[[UIView alloc]init];
    customTabBar.frame=self.tabBar.frame;
    
    customTabBar.frame=self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    [customTabBar release];
    
    for (int i=0;i<4; i++) {
        
        NSString *tabBarClickedImageName=[NSString stringWithFormat:@"bar_item%dSelected.png",i];
        NSString *tabBarImageName=[NSString stringWithFormat:@"bar_item%dNormal.png",i];
        
        UICustomTabBar *tabBar=[[UICustomTabBar alloc]
                                initWithNormalStateImage:[UIImage imageNamed:tabBarImageName] 
                                andClickedStateImage:[UIImage imageNamed:tabBarClickedImageName]];
        
        tabBar.frame = CGRectMake(80*i,1,80,49);
        tabBar.delegate=self;
        tabBar.tabBarTag=i;
        
        [customTabBar addSubview:tabBar];
        [tabBar release];
        [customTabBarItems addObject:tabBar];
        
        //如果是第一个那么默认是选中的
        if (1==i) {
            [tabBar switchToClickedState];
        }
    }
}
//tabbar代理方法
- (void)tabBarDidTapped:(id)sender{
    
    UICustomTabBar *tabBar=(UICustomTabBar*)sender;
    for (UICustomTabBar *tabBarInstance in customTabBarItems) {
        [tabBarInstance switchToNormalState];
    }
    [tabBar switchToClickedState];
    UIViewController *selectedController=[self.viewControllers objectAtIndex:tabBar.tabBarTag];
    self.selectedViewController=selectedController;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        //设置tabbar颜色
//        self.tabBar.tintColor = [UIColor colorWithRed:RED_VALUE/255.0 green:GREEN_VALUE/255.0 blue:BLUE_VALUE/255.0 alpha:COLOR_ALPHA];

        //初始化NavControllers
        HomePageViewController *homeController = [[HomePageViewController alloc]initWithNibName:@"HomePageViewController" bundle:nil];
        homeController.navigationItem.title = @"系统主页";
        homePageNavController = [[UINavigationController alloc]initWithRootViewController:homeController];
        homePageNavController.navigationBar.tintColor = [UIColor colorWithRed:RED_VALUE/225.0 green:GREEN_VALUE/225.0 blue:BLUE_VALUE/225.0 alpha:COLOR_ALPHA];
        
        [homeController release];
        
        TicketPreordainViewController *ticketViewController = [[TicketPreordainViewController alloc]initWithNibName:@"TicketPreordainViewController" bundle:nil];
        ticketViewController.navigationItem.title = @"查询订票";
        ticketQueryNavController = [[UINavigationController alloc]initWithRootViewController:ticketViewController];
        ticketQueryNavController.navigationBar.tintColor = [UIColor colorWithRed:RED_VALUE/225.0 green:GREEN_VALUE/225.0 blue:BLUE_VALUE/225.0 alpha:COLOR_ALPHA];
        [ticketViewController release];
        
        PersonalQueryViewController *personQueryController = [[PersonalQueryViewController alloc]initWithNibName:@"PersonalQueryViewController" bundle:nil];
        personQueryController.navigationItem.title = @"个人中心";
        personalQueryNavController = [[UINavigationController alloc]initWithRootViewController:personQueryController];
        personalQueryNavController.navigationBar.tintColor = [UIColor colorWithRed:RED_VALUE/225.0 green:GREEN_VALUE/225.0 blue:BLUE_VALUE/225.0 alpha:COLOR_ALPHA];
        [personQueryController release];
        
//        AboutViewController *aboutController = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
//        aboutController.navigationItem.title = @"关于作者";
        ZYProSoftMemberViewController *zyProSoftViewController = [[ZYProSoftMemberViewController alloc]init];
        zyProSoftViewController.navigationItem.title = @"ZYProSoft团队";
        aboutNavController = [[UINavigationController alloc]initWithRootViewController:zyProSoftViewController];
        aboutNavController.navigationBar.tintColor = [UIColor colorWithRed:RED_VALUE/225.0 green:GREEN_VALUE/225.0 blue:BLUE_VALUE/225.0 alpha:COLOR_ALPHA];
        [zyProSoftViewController release];
        
        //添加到tabbarcontroller
        NSArray *navControllers = [NSArray arrayWithObjects:homePageNavController,ticketQueryNavController,personalQueryNavController,aboutNavController, nil];
        self.viewControllers = navControllers;
        [homePageNavController release];
        [ticketQueryNavController release];
        [personalQueryNavController release];
        [aboutNavController release];
        
        [self initCustomTabBar];//自定tabbar
        
    }
    return self;
}

//立即刷新票类信息
- (void)refreshTicketDataNow
{
    if (self.selectedIndex == 1) {
        TicketPreordainViewController *viewController = [ticketQueryNavController.viewControllers objectAtIndex:0];
        [viewController refreshNow];
    }
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)dealloc{
    [customTabBarItems release];
    [super dealloc];
}
@end
