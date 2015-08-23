//
//  ZYSearchTableViewController.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-24.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "ZYSearchTableViewController.h"

#define SEARCHBAR_HEIGHT 40
@implementation ZYSearchTableViewController
@synthesize searchBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSearchBarToTableView];
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
- (void)addSearchBarToTableView
{
    searchBar = [[ZYSearchBar alloc]init];
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0,-SEARCHBAR_HEIGHT, 320, SEARCHBAR_HEIGHT);
    
    self.tableView.contentInset = UIEdgeInsetsMake(SEARCHBAR_HEIGHT, 0, 0, 0);
    [self.tableView addSubview:searchBar];
    
}
//searchbar代理方法，子类覆盖重写
- (void)searchResultWithKeyWord:(NSString *)keyword
{
    
}
//类型选择代理方法
- (void)beginChooseType:(id)sender
{
    
}

- (void)dealloc{
    [self.searchBar release];
    [super dealloc];
}
@end
