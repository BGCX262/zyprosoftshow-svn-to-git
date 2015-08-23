//
//  TicketPreordainViewController.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-19.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "TicketPreordainViewController.h"
#import "Ticket.h"

@interface TicketPreordainViewController(private)
- (void)getAllTicketInfo;
- (void)refreshNow;
@end

@implementation TicketPreordainViewController
@synthesize cacheArray;
@synthesize selectRowIndex;
@synthesize selectOrderCount;


//静态得返回类型图片
- (UIImage *)returnStaticCellIconWithTypeName:(NSString *)name
{
    UIImage *resultImage = nil;
    if ([name isEqualToString:@"电影票"]) {
        return resultImage = [UIImage imageNamed:@"cell_icon_film.png"];
    }else if([name isEqualToString:@"餐厅券"]){
        return resultImage = [UIImage imageNamed:@"cell_icon_canting.png"];

    }else if([name isEqualToString:@"篮球票"]){
        return resultImage = [UIImage imageNamed:@"cell_icon_basketBall.png"];

    }else if([name isEqualToString:@"足球票"]){
        return resultImage = [UIImage imageNamed:@"cell_icon_football.png"];

    }else if([name isEqualToString:@"优惠券"]){
        return resultImage = [UIImage imageNamed:@"cell_icon_youhui.png"];

    }else if([name isEqualToString:@"邀请函"]){
        return resultImage = [UIImage imageNamed:@"cell_icon_yaoqing.png"];

    }
    return resultImage = [UIImage imageNamed:@"cell_icon_qita.png"];

}
//帮助函数
- (void)alertWithTitle:(NSString *)title message:(NSString *)rMessage
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:rMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}
//接收订票页面得刷新通知
- (void)operationForRefreshNoti:(NSNotification *)noti
{
    //立即刷新
    [self refreshNow];
}
//只允许一个视图为推出状态
- (BOOL)pushViewNowIsUnEnable
{
    if (chooseTypeViewCanMove == NO || chooseCountViewCanMove == NO || orderViewCanMove == NO) {
        return YES;//只要有一个推出就不可以推出新得view
    }
    return NO;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //贴皮肤
    UIImageView *backImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tableViewBackground.png"]];
    self.tableView.backgroundView = backImgView;
    [backImgView release];
    
    //搜索栏换皮肤
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchBar.backgroundImgView.image = [UIImage imageNamed:@"searchBarBackground.png"];
    [self.searchBar.typeSelectButton setBackgroundImage:[UIImage imageNamed:@"typeSelectButton.png"]forState:UIControlStateNormal];
    [self.searchBar.searchButton setBackgroundImage:[UIImage imageNamed:@"searchButton.png"] forState:UIControlStateNormal];
    
    //添加选择得view
    chooseView = [[ChooseCountView alloc]initWithFrame:CGRectMake(0, 480, 320, 200)];
    chooseView.delegate = self;
    [self.tabBarController.view addSubview:chooseView];//将chooseview添加到tabbarcontroller上面
    [chooseView release];
    
    //添加确认订单View
    orderView = [[OrderView alloc]init];
    orderView.frame = CGRectMake(0, -300, 320, 300);
    [self.tabBarController.view addSubview:orderView];
    orderView.delegate = self;
    [orderView release];
    
    //添加选择类型得View
    typeChooseView = [[ChooseTypeView alloc]init];
    typeChooseView.delegate = self;
    typeChooseView.frame = CGRectMake(0, 480, 320, 200);
    [self.tabBarController.view addSubview:typeChooseView];
    [typeChooseView release];
    
    //在导航条右侧添加一个刷新按钮
    UIBarButtonItem *rightRefreshItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshNow)];
    self.navigationItem.rightBarButtonItem = rightRefreshItem;
    [rightRefreshItem release];
    
    //searchbar placeholder
    searchBar.searchField.placeholder = @"请先选择搜索类型，默认：票ID";
    selectTypeIndex = QUERY_BY_TICKET_ID;//默认按照票ID查询
    searchBar.searchField.font = [UIFont systemFontOfSize:12];
    
    //默认三个视图都是可以推出得
    chooseTypeViewCanMove = YES;
    chooseCountViewCanMove = YES;
    orderViewCanMove = YES;
    
    //初始化缓存数组
    self.cacheArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    //注册一个通知，观察订票页面发来得刷新请求
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(operationForRefreshNoti:) name:TICKET_INFO_REFRESH_NOTI object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{    
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //停止执行刷新方法得线程执行，并推出下拉刷新得效果
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refresh) object:nil];
    [self stopLoading];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//立即刷新方法
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.cacheArray count];
}

- (PreordainCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PreordainCell *cell = (PreordainCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PreordainCell" owner:self options:nil]objectAtIndex:0];
    }
    Ticket *temp = (Ticket *)[self.cacheArray objectAtIndex:indexPath.row];
    [cell setTicketInfo:temp];
    cell.typeImage.image = [self returnStaticCellIconWithTypeName:temp.ticketType];
    cell.PreordainButton.tag = indexPath.row;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    
}

#pragma mark - preordainCellDelegate
- (void)tapOnPreordainButton:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if ([self pushViewNowIsUnEnable]) {
        return;
    }
    //禁止chooseview继续向上运动
    if (chooseView.center.y == 380) {
        return;
    }
    [ZYViewAnimation animationBasicTopForwordView:chooseView duration:0.5 destination:200];
    chooseCountViewCanMove = NO;//禁止再推出这个视图
    
    //获取当前选中得按钮得tag值
    selectRowIndex = btn.tag;
    chooseView.maxCount = 20;//每个人最多定20张票该类票
    [chooseView.choosePickView reloadAllComponents];//重新载入数据
    
}
//chooseViewDelegate
- (void)tapOnChooseViewButton:(id)sender withSelectedCount:(NSInteger)count
{
    UIButton *tempBtn = (UIButton *)sender;
    
    if (tempBtn.tag == CHOOSEVIEW_CANCEL_BUTTON_TAG) {
        [ZYViewAnimation animationBasicBottomForwordView:chooseView duration:0.5 destination:200];//收起选择view
        chooseCountViewCanMove = YES;//恢复视图可推出
    }
    if (tempBtn.tag == CHOOSEVIEW_YES_BUTTON_TAG) {
        [ZYViewAnimation animationBasicBottomForwordView:chooseView duration:0.5 destination:200];
        chooseCountViewCanMove = YES;//恢复可以推出 
        
        //初始化订单信息
        selectOrderCount = count;//保存当前订票张数
        Ticket *tempTicket = [cacheArray objectAtIndex:selectRowIndex];
        NSString *orderString = [NSString stringWithFormat:@"您将要预定        票ID：%@，    票单价：%@，   票位置：%@  得 %@      %d张",tempTicket.ticketID,tempTicket.ticketPrice,tempTicket.ticketPosition,tempTicket.ticketType,count];
        orderView.orderLabel.text = orderString;
        
        [ZYViewAnimation animationBasicBottomForwordView:orderView duration:0.5 destination:300];//推出orderView
        orderViewCanMove = NO;//禁止再推出这个视图
        
    }
    
}
//orderViewDelegate
- (void)tapOnOrderViewButton:(id)sender
{
    UIButton *tempBtn = (UIButton *)sender;
    if (tempBtn.tag == ORDERVIEW_CANCEL_BUTTON_TAG) {
        [ZYViewAnimation animationBasicTopForwordView:orderView duration:0.5 destination:300];
        orderViewCanMove = YES;//恢复可以推出
    }
    if (tempBtn.tag == ORDERVIEW_YES_BUTTON_TAG) {
        //将订单视图隐藏
        [ZYViewAnimation animationBasicTopForwordView:orderView duration:0.5 destination:300];
        orderViewCanMove = YES;//恢复可以推出
        
        //发送订单请求
        NSLog(@"jump int to here");
        
        //组合发送请求所需要参数
        Ticket *tempTicket = [cacheArray objectAtIndex:selectRowIndex];
        NSString *ticketID = tempTicket.ticketID;
        
        NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"],@"userID",ticketID,@"ticketID",[NSString stringWithFormat:@"%d",selectOrderCount],@"count",nil];
        
        [[ZYNetworkHelper shareZYNetworkHelper]requestDataWithApplicationType:TicketSystemRequestPreordainType withParams:paramDict withHelperDelegate:self withSuccessRequestMethod:@"preordainTicketSuccess:" withFaildRequestMethod:@"preordainTicketFaild:"];
        
        [MBProgressHUD showHUDAddedTo:self.view withLabel:@"正在执行订票..." animated:YES];
    }
}

//获取最新票信息得方法
- (void)getAllTicketInfo
{
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",QUERY_ALL_RESULT],@"queryType",@"*",@"param1", nil];
    
    [[ZYNetworkHelper shareZYNetworkHelper]requestDataWithApplicationType:TicketSystemRequestQueryType withParams:paramDict withHelperDelegate:self withSuccessRequestMethod:@"getAllTicketInfoSuccess:" withFaildRequestMethod:@"getAllTicketInfoFaild:"];
}
//覆盖父类得刷新时候执行得方法
- (void)refresh
{
    [self performSelector:@selector(getAllTicketInfo) withObject:nil afterDelay:0.2];
}
//立即刷新方法
- (void)refreshNow
{
    //开始刷新
    [self.tableView setContentOffset:CGPointMake(0, -100)];
    [self startLoading];
}
//搜索栏得搜索方法,覆盖这个方方
- (void)searchResultWithKeyWord:(NSString *)keyword
{
    //组合查询参数
    NSLog(@"queryType is %d",selectTypeIndex);
    NSLog(@"param1 is %@",keyword);
    
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",selectTypeIndex],@"queryType",keyword,@"param1", nil];
    [[ZYNetworkHelper shareZYNetworkHelper]requestDataWithApplicationType:TicketSystemRequestQueryType withParams:paramDict withHelperDelegate:self withSuccessRequestMethod:@"querySuccess:" withFaildRequestMethod:@"queryFaild:"];
    [MBProgressHUD showHUDAddedTo:self.view withLabel:@"正在搜索..." animated:YES];
}
//按下选择类型按钮得代理方法
- (void)beginChooseType:(id)sender
{
    //如果不允许推出新得pushView直接返回
    if ([self pushViewNowIsUnEnable]) {
        return;
    }
    if (typeChooseView.center.y == 380) {
        return;
    }
    [ZYViewAnimation animationBasicTopForwordView:typeChooseView duration:0.3 destination:200];
    chooseTypeViewCanMove = NO;//禁止继续推出视图
    searchBar.searchButton.enabled = FALSE;//选择完类型才支持搜索
}
//选择类型chooseTypeViewDelegate
- (void)tapOnChooseTypeViewButton:(id)sender withSelectIndex:(NSInteger)index
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case CHOOSETYPE_CANCEL_BUTTON_TAG:
            [ZYViewAnimation animationBasicBottomForwordView:typeChooseView duration:0.3 destination:200];
            chooseTypeViewCanMove = YES;//恢复可以推出
            searchBar.searchButton.enabled = YES;//恢复搜索按钮
            break;
        case CHOSSETYPE_YES_BUTTON_TAG:
            [ZYViewAnimation animationBasicBottomForwordView:typeChooseView duration:0.3 destination:200];
            chooseTypeViewCanMove = YES;//恢复可以推出 
            searchBar.searchButton.enabled = YES;//恢复搜索按钮
            
            selectTypeIndex = index;
            //临时改变按钮标题
            switch (index) {
                case QUERY_BY_TICKET_ID:
                    [searchBar.typeSelectButton setTitle:@"票ID：" forState:UIControlStateNormal];
                    break;
                case QUERY_BY_TICKET_POSITION:
                    [searchBar.typeSelectButton setTitle:@"票位置：" forState:UIControlStateNormal];
                    break;
                case QUERY_BY_TICKET_PRICE:
                    [searchBar.typeSelectButton setTitle:@"票价格：" forState:UIControlStateNormal];
                    break;
                case QUERY_BY_TICKET_TYPE:
                    [searchBar.typeSelectButton setTitle:@"票类型：" forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

//导航左按钮返回到所有票信息页面
- (void)returnToAllTicketInfo
{
    [self refreshNow];
    
    self.navigationItem.leftBarButtonItem = nil;
    //反馈成功后恢复类型选择按钮标题
    [searchBar.typeSelectButton setTitle:@"查询类型" forState:UIControlStateNormal];
}
//成功获取所有票类信息
- (void)getAllTicketInfoSuccess:(NSObject *)result
{
    //初始化当前用于存储所有票信息得数组
    if (self.cacheArray) {
        self.cacheArray = nil;
        self.cacheArray = [NSMutableArray array];
    }
    
    //获取所有票信息保存
    NSArray *resultArr = (NSArray *)result;
    for (NSDictionary *ticketItem in resultArr) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
        Ticket *tempTicket = [[Ticket alloc]init];
        tempTicket.ticketID = [ticketItem objectForKey:@"ticket_id"];
        tempTicket.ticketType = [ticketItem objectForKey:@"ticket_type"];
        tempTicket.ticketPrice = [ticketItem objectForKey:@"ticket_price"];
        tempTicket.ticketPosition = [ticketItem objectForKey:@"ticket_position"];
        tempTicket.ticketCount = [ticketItem objectForKey:@"ticket_count"];
        
        [self.cacheArray addObject:tempTicket];
        [tempTicket release];
        [pool drain];
    }
    [self.tableView reloadData];
    [self stopLoading];
    self.navigationItem.leftBarButtonItem = nil;//已经是全部信息了，将返回全部信息按钮设置为空
}
//获取票信息失败
- (void)getAllTicketInfoFaild:(NSObject *)result
{
    [self stopLoading];
}
- (void)dealloc{
    [cacheArray release];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}

//订票反馈成功处理函数
- (void)preordainTicketSuccess:(NSObject *)result
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSString *message = nil;
    NSString *title = @"订票反馈";
    
    NSDictionary *resultDict = (NSDictionary *)result;
    NSInteger resultCode = [[resultDict objectForKey:@"preordainTag"]intValue];
    switch (resultCode) {
        case DING_PIAO_SUCCESS:
            message = @"恭喜你，订票已成功！";
            [self alertWithTitle:title message:message];
            [self performSelector:@selector(refreshNow) withObject:nil afterDelay:0.2];//立即刷新一下
            
            //注册一个通知，通知个人订票信息刷新
            [[NSNotificationCenter defaultCenter]postNotificationName:PERSONAL_INFO_REFRESH_NOTI object:nil];
            
            break;
        case DING_PIAO_COUNT_FALSE_TYPE:
            message = @"对不起，您要求定票得张数已经超过服务器上现有得票得张数";
            [self alertWithTitle:title message:message];
            break;
        case DING_PIAO_SERVER_FAILD_TYPE:
            message = @"服务器繁忙，订票失败！";
            [self alertWithTitle:title message:message];
            break;
        case DING_PIAO_UPDATE_FAILD:
            message = @"更新用户所有票信息失败，订票失败！";
            [self alertWithTitle:title message:message];
            break;
            
        default:
            break;
    }
}
//订票反馈失败处理函数
- (void)preordainTicketFaild:(NSObject *)result
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
//查询反馈成功处理函数
- (void)querySuccess:(NSObject *)result
{
    if (self.cacheArray) {
    self.cacheArray = nil;
    self.cacheArray = [NSMutableArray array];
    }
    //获取所有票信息保存
    NSArray *resultArr = (NSArray *)result;
    for (NSDictionary *ticketItem in resultArr) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
        Ticket *tempTicket = [[Ticket alloc]init];
        tempTicket.ticketID = [ticketItem objectForKey:@"ticket_id"];
        tempTicket.ticketType = [ticketItem objectForKey:@"ticket_type"];
        tempTicket.ticketPrice = [ticketItem objectForKey:@"ticket_price"];
        tempTicket.ticketPosition = [ticketItem objectForKey:@"ticket_position"];
        tempTicket.ticketCount = [ticketItem objectForKey:@"ticket_count"];
            
        [self.cacheArray addObject:tempTicket];
        [tempTicket release];
        [pool drain];
    }
    [self.tableView reloadData];
    [self stopLoading];
    
    //设置一个导航左按钮来返回到所有信息页面
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"查看所有" style:UIBarButtonItemStyleBordered target:self action:@selector(returnToAllTicketInfo)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
//查询反馈失败处理函数
- (void)queryFaild:(NSObject *)result
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
