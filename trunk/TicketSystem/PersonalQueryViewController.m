//
//  PersonalQueryViewController.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-19.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "PersonalQueryViewController.h"
#import "Ticket.h"

@interface PersonalQueryViewController(private)
- (void)getPersonalAllTicketInfoNow;

@end
@implementation PersonalQueryViewController
@synthesize chooseView;
@synthesize selectTypeIndex;
@synthesize cacheArray;
@synthesize needRefreshNow;
@synthesize commonArray;
@synthesize tuiDingCount;
@synthesize selectTicketIndex;

#define CHOOSE_COUNT_VIEW_TAG 222222
#define CHOOSE_TYPE_VIEW_TAG 333333
#define ORDER_VIEW_TAG 444444


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
//接收需要刷新得通知得方法
- (void)operationForRefreshNoti:(NSNotification *)noti
{
    self.needRefreshNow = YES;//YES 则需要立即刷新
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
    
    //选择退订数量得视图
    chooseView = [[ChooseCountView alloc]initWithFrame:CGRectMake(0, 480, 320, 200)];
    chooseView.delegate = self;
    chooseView.tag = CHOOSE_COUNT_VIEW_TAG;
    chooseView.cancelBtn.tag = TUIDING_CHOOSEVIEW_CANCEL_BUTTON_TAG;//改变在基类中得Tag值
    chooseView.yesBtn.tag = TUIDING_CHOOSEVIEW_YES_BUTTON_TAG;//改变在基类中得Tag值
    [self.tabBarController.view addSubview:chooseView];//将chooseview添加到tabbarcontroller上面
    [chooseView release];
    
    //搜索类型选择视图
    chooseTypeView = [[ChooseTypeView alloc]initWithFrame:CGRectMake(0, 480, 320, 200)];
    chooseTypeView.delegate = self;
    chooseTypeView.tag = CHOOSE_TYPE_VIEW_TAG;
    chooseTypeView.cancelBtn.tag = PERSON_CHOOSETYPE_CANCEL_BUTTON_TAG;//改变在基类中得Tag值
    chooseTypeView.yesBtn.tag = PERSON_CHOSSETYPE_YES_BUTTON_TAG;//改变在基类中得Tag值
    [self.tabBarController.view addSubview:chooseTypeView];//将chooseTypeView添加到tabbarcontroller上面
    [chooseTypeView release];
    selectTypeIndex = QUERY_BY_TICKET_ID;//默认按照票ID搜索
    needRefreshNow = YES;//第一次需要刷新得
    
    //生成退订单子得视图
    tuiDingOrderView = [[OrderView alloc]init];
    tuiDingOrderView.tag = ORDER_VIEW_TAG;
    tuiDingOrderView.cancelButton.tag = PERSON_ORDERVIEW_CANCEL_BUTTON_TAG;//改变在基类中得TAG值
    tuiDingOrderView.yesButton.tag = PERSON_ORDERVIEW_YES_BUTTON_TAG;//改变在基础类中得TAG值
    tuiDingOrderView.frame = CGRectMake(0, -300, 320, 300);
    [self.tabBarController.view addSubview:tuiDingOrderView];
    tuiDingOrderView.delegate = self;
    [tuiDingOrderView release];  
    
    //在导航条右侧添加一个刷新按钮
    UIBarButtonItem *rightRefreshItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(getPersonalAllTicketInfoNow)];
    self.navigationItem.rightBarButtonItem = rightRefreshItem;
    [rightRefreshItem release];
    
    //初始化缓存数组
    cacheArray = [[NSMutableArray alloc]initWithCapacity:0];
    commonArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    //注册一个观察者，接收是否需要刷新得通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(operationForRefreshNoti:) name:PERSONAL_INFO_REFRESH_NOTI object:nil];
    
    //默认三个都可以推出了
    chooseTypeViewCanMove = YES;
    chooseCountViewCanMove = YES;
    orderViewCanMove = YES;
    
    searchBar.searchField.placeholder = @"请选择查询类型，默认为票ID";//默认填充
    searchBar.searchField.adjustsFontSizeToFitWidth = YES;
    searchBar.searchField.font = [UIFont systemFontOfSize:12];
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
    if (needRefreshNow) {
        [self getPersonalAllTicketInfoNow];//立即获取用户票信息
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [commonArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (PreordainCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PreordainCell *cell =(PreordainCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PreordainCell" owner:self options:nil]objectAtIndex:0];
    }
    
    // Configure the cell...
    Ticket *temp = (Ticket *)[self.commonArray objectAtIndex:indexPath.row];
    [cell setTicketInfo:temp];
    cell.typeImage.image = [self returnStaticCellIconWithTypeName:temp.ticketType];
    cell.PreordainButton.tag = indexPath.row;
    //改变按钮背景图片
    [cell.PreordainButton setBackgroundImage:[UIImage imageNamed:@"tuiDingButton.png"] forState:UIControlStateNormal];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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

//返回到所有票信息
- (void)returnToAllMyTicketInfo
{
    if (self.commonArray) {
        self.commonArray = nil;
        self.commonArray = [NSMutableArray array];
    }
    self.commonArray = self.cacheArray;
    [self.tableView reloadData];
    
    //隐藏查看所有按钮
    self.navigationItem.leftBarButtonItem = nil;
    
    //返回后恢复类型选择按钮标题
    [searchBar.typeSelectButton setTitle:@"查询类型" forState:UIControlStateNormal];
}

//父类searchBar代理方法覆盖
- (void)searchResultWithKeyWord:(NSString *)keyword
{
    NSMutableArray *resultArray = [[NSMutableArray alloc]initWithCapacity:0];//用来装某一类得所有票信息
    NSLog(@"cache array is %@",self.cacheArray);
    
    //伪查询，在本地数据中查询信息
    switch (selectTypeIndex) {
        case QUERY_BY_TICKET_ID:
            for (Ticket *ticket in self.cacheArray) {
                if ([ticket.ticketID isEqualToString:keyword]) {//字符串比较相等必须使用 isEqualToString 否则无法找到匹配得结果
                    [resultArray addObject:ticket];
                }
            }
            break;
        case QUERY_BY_TICKET_TYPE:
            for (Ticket *ticket in self.cacheArray) {
                if ([ticket.ticketType isEqualToString:keyword]) {
                    [resultArray addObject:ticket];
                }
            }
            break;
        case QUERY_BY_TICKET_POSITION:
            for (Ticket *ticket in self.cacheArray) {
                if ([ticket.ticketPosition isEqualToString:keyword]) {
                    [resultArray addObject:ticket];
                }
            }
            break;
        case QUERY_BY_TICKET_PRICE:
            for (Ticket *ticket in self.cacheArray) {
                if ([ticket.ticketPrice isEqualToString:keyword]) {
                    [resultArray addObject:ticket];
                }
            }
            break;
            
        default:
            break;
    }
    NSLog(@"search result array is %@",resultArray);
    if (self.commonArray) {
        self.commonArray = nil;
        self.commonArray = [NSMutableArray array];
    }
    self.commonArray = resultArray;//更改当前数据源
    [self.tableView reloadData];//刷新 
    
    //导航栏上面提供一个按钮返回到所有票信息
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"查看所有" style:UIBarButtonItemStyleBordered target:self action:@selector(returnToAllMyTicketInfo)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    

}
//开始选择类型得按钮被点击
- (void)beginChooseType:(id)sender
{
    //如果现在不能推出新得view直接返回
    if ([self pushViewNowIsUnEnable]) {
        return;
    }
    [ZYViewAnimation animationBasicTopForwordView:chooseTypeView duration:0.3 destination:200];
    chooseTypeViewCanMove = NO;//已经被推出来了，不能再移动了
    searchBar.searchButton.enabled = FALSE;//禁止搜索按钮，必须选择类型
}
//点击类型选择按钮时得代理方法
- (void)tapOnChooseTypeViewButton:(id)sender withSelectIndex:(NSInteger)index
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case PERSON_CHOOSETYPE_CANCEL_BUTTON_TAG:
            [ZYViewAnimation animationBasicBottomForwordView:chooseTypeView duration:0.3 destination:200];
            chooseTypeViewCanMove = YES;//恢复可以推出来
            searchBar.searchButton.enabled = YES;//恢复搜索按钮
            
            break;
        case PERSON_CHOSSETYPE_YES_BUTTON_TAG:
            [ZYViewAnimation animationBasicBottomForwordView:chooseTypeView duration:0.3 destination:200];
            chooseTypeViewCanMove = YES;//恢复可以推出来
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
//cell代理方法,点击这个按钮时开始退订流程
- (void)tapOnPreordainButton:(id)sender
{
    //确定选中退订得按钮
    UIButton *selectButton = (UIButton *)sender;
    
    //如果现在不能推出新得view直接返回
    if ([self pushViewNowIsUnEnable]) {
        return;
    }
    
    //禁止chooseview继续向上运动
    if (chooseView.center.y == 380) {
        return;
    }
    [ZYViewAnimation animationBasicTopForwordView:chooseView duration:0.5 destination:200];
    chooseCountViewCanMove = NO;//不能再推出选择数量得视图了
    
    //开始退订流程，根据选中得按钮找到对应得票信息
    selectTicketIndex = selectButton.tag;
    Ticket *selectTicket = [commonArray objectAtIndex:selectTicketIndex];
    chooseView.maxCount = [selectTicket.ticketCount intValue];
    [chooseView.choosePickView reloadAllComponents];//重新载入数据
}
//chooseview代理方法
- (void)tapOnChooseViewButton:(id)sender withSelectedCount:(NSInteger)count
{
    UIButton *tempBtn = (UIButton *)sender;
    
    if (tempBtn.tag == TUIDING_CHOOSEVIEW_CANCEL_BUTTON_TAG) {
        [ZYViewAnimation animationBasicBottomForwordView:chooseView duration:0.5 destination:200];
        chooseCountViewCanMove = YES;//恢复可以推出
        
    }
    if (tempBtn.tag == TUIDING_CHOOSEVIEW_YES_BUTTON_TAG) {
        [ZYViewAnimation animationBasicBottomForwordView:chooseView duration:0.3 destination:200];
        chooseCountViewCanMove = YES;//恢复可以推动
        
        tuiDingCount = count;//获得需要退订得数量
        
        //推出退订信息窗口,填充退订信息
        Ticket *tempTicket = [self.commonArray objectAtIndex:selectTicketIndex];
        NSString *orderString = [NSString stringWithFormat:@"您将要退订      票ID：%@，    票单价：%@，   票位置：%@ 得  %@     %d张",tempTicket.ticketID,tempTicket.ticketPrice,tempTicket.ticketPosition,tempTicket.ticketType,tuiDingCount];
        
        tuiDingOrderView.orderLabel.text = orderString;
        [ZYViewAnimation animationBasicBottomForwordView:tuiDingOrderView duration:0.3 destination:300];
        orderViewCanMove = NO;//禁止再推出这个视图


    }
}
//tuiDingOrderView delegate方法
- (void)tapOnOrderViewButton:(id)sender
{
    UIButton *tempBtn = (UIButton *)sender;
    switch (tempBtn.tag) {
        case PERSON_ORDERVIEW_CANCEL_BUTTON_TAG:
            //将order视图退回去
            [ZYViewAnimation animationBasicTopForwordView:tuiDingOrderView duration:0.3 destination:300];
            orderViewCanMove = YES;//恢复可以推出
            

            break;
        case PERSON_ORDERVIEW_YES_BUTTON_TAG:
            //开始发送退订请求
            [ZYViewAnimation animationBasicTopForwordView:tuiDingOrderView duration:0.3 destination:300];
            orderViewCanMove = YES;//恢复可以推出
            
            //开始退订网络请求 
            Ticket *tempTicket = [self.commonArray objectAtIndex:selectTicketIndex];
            NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"],@"userID",tempTicket.ticketID,@"ticketID",[NSString stringWithFormat:@"%d",tuiDingCount], @"count",nil];
            [[ZYNetworkHelper shareZYNetworkHelper]requestDataWithApplicationType:TicketSystemRequestUnsunscribeType withParams:paramDict withHelperDelegate:self withSuccessRequestMethod:@"tuiDingOperationSuccess:" withFaildRequestMethod:@"tuiDingOperationFaild:"];
            
            [MBProgressHUD showHUDAddedTo:self.view withLabel:@"正在退订..." animated:YES];
            
            
            break;
            
        default:
            break;
    }
}
//立即获取用户所有订票信息
- (void)getPersonalAllTicketInfoNow
{
    //组合查询参数
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",QUERY_BY_USER_ID],@"queryType", [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"],@"param1", nil];
    [[ZYNetworkHelper shareZYNetworkHelper]requestDataWithApplicationType:TicketSystemRequestQueryType withParams:paramDict withHelperDelegate:self withSuccessRequestMethod:@"getPersonalTicketInfoSuccess:" withFaildRequestMethod:@"getPersonalTicketInfoFaild:"];
    [MBProgressHUD showHUDAddedTo:self.view withLabel:@"正在获取个人订票信息..." animated:YES];
}
//用户订票信息反馈成功
- (void)getPersonalTicketInfoSuccess:(NSObject *)result
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
    self.commonArray = self.cacheArray;
    [self.tableView reloadData];
    self.needRefreshNow = FALSE;//每次收取到新得数据后就不要再回到view得时候立即刷新了
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
//用户订票信息反馈失败
- (void)getPersonalTicketInfoFaild:(NSObject *)result
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [cacheArray release];
    [super dealloc];
}
//用户退订反馈成功
- (void)tuiDingOperationSuccess:(NSObject *)result
{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    NSString *rMessage = nil;
    NSDictionary *resultDict = (NSDictionary *)result;
    NSLog(@"result dict is %@",resultDict);
    NSInteger resultTag = [[resultDict objectForKey:@"TuiDingTag"]intValue];
    
    switch (resultTag) {
        case TUI_DING_SUCCESS:
            rMessage = @"退订已成功！";
            [self alertWithTitle:@"退订提示" message:rMessage];
            //通知所有票信息页面刷新
            [[NSNotificationCenter defaultCenter]postNotificationName:TICKET_INFO_REFRESH_NOTI object:nil];
            
            //延迟0.2秒发送刷新请求，防止服务器数据操作错误
            [self performSelector:@selector(getPersonalAllTicketInfoNow) withObject:nil afterDelay:0.2];
            break;
            
        case TUI_DING_SERVER_BUSY_FAILD:
            rMessage = @"退订失败，服务器繁忙，请重新尝试！";
            [self alertWithTitle:@"退订提示" message:rMessage];
            break;
        case TUI_DING_FAILD:
            rMessage = @"退订失败！";
            [self alertWithTitle:@"退订提示" message:rMessage];
            break;
            
        default:
            break;
    }
}
//用户退订反馈失败
- (void)tuiDingOperationFaild:(NSObject *)result
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
