//
//  ZYProSoftMemberViewController.m
//  TicketSystem
//
//  Created by ZYVincent on 12-3-5.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "ZYProSoftMemberViewController.h"
#import "ZYProSofter.h"

@implementation ZYProSoftMemberViewController
@synthesize cacheArray;


//帮助函数
- (void)alertWithTitle:(NSString *)title message:(NSString *)rMessage
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:rMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

//判定是否认证
- (UIImage *)returnIfJoinedZYProSoftTeam:(NSInteger)zyProSoft_Tag
{
    if (zyProSoft_Tag == 1) {
        return [UIImage imageNamed:@"cell_icon_member.png"];
    }
    return [UIImage imageNamed:@"cell_icon_notMember.png"];
}
- (UIImage *)returnButtonWithZYProSoftTag:(NSInteger)zyProSoft_Tag
{
    if (zyProSoft_Tag == 1) {
        return [UIImage imageNamed:@"memberButton.png"];
    }
    return [UIImage imageNamed:@"jionUsButton.png"];
}
//检测视图是否可以弹出
- (BOOL)pushViewNowIsUnEnable
{
    if (typeChooseViewCanMove == NO) {
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
    self.searchBar.searchField.placeholder = @"请选择查询类型，默认用户ID";

    //添加选择类型得View
    typeChooseView = [[ChooseTypeView alloc]init];
    typeChooseView.delegate = self;
    typeChooseView.cancelBtn.tag = ZYPROSOFT_CHOOSE_TYPE_CANCEL_BUTTON_TAG;
    typeChooseView.yesBtn.tag = ZYPROSOFT_CHOOSE_TYPE_YES_BUTTON_TAG;
    typeChooseView.frame = CGRectMake(0, 480, 320, 200);
    [self.tabBarController.view addSubview:typeChooseView];
    [typeChooseView release];
    
    //添加成员提示视图
    joinTeamView = [[JoinZYProSoftTeamView alloc]init];
    joinTeamView.frame = CGRectMake(0, -205, 320, 205);
    joinTeamView.delegate = self;
    [self.tabBarController.view addSubview:joinTeamView];
//    [joinTeamView release];//从xib加载得，不要释放，否则出错
    
    //在导航条右侧添加一个刷新按钮
    UIBarButtonItem *rightRefreshItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshNow)];
    self.navigationItem.rightBarButtonItem = rightRefreshItem;
    [rightRefreshItem release];

    
    //改变类型选择数据源
    NSArray *typeArray = [NSArray arrayWithObjects:@"用户ID",@"用户名",@"已认证",@"未认证", nil];
    NSArray *indexArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",QUERY_USERINFO_BY_USER_ID],[NSString stringWithFormat:@"%d",QUERY_USERINFO_BY_USER_NAME],[NSString stringWithFormat:@"%d",QUERY_USER_MEMBER_TYPE],[NSString stringWithFormat:@"%d",QUERY_USER_NOTMEMBER_TYPE],nil];
    typeChooseView.indexArray = indexArray;
    typeChooseView.sourceArray = typeArray;
    [typeChooseView.choosePickView reloadAllComponents];

    //初始化缓存
    cacheArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    //立即刷新
    [self refreshNow];
    needRefreshNow = NO;
    
    //默认可以推出
    typeChooseViewCanMove = YES;
    joinTeamViewCanMove = YES;
    
    //默认查询类型
    selectTypeIndex = QUERY_USERINFO_BY_USER_ID;
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
    //离开就停止刷新
    [self stopLoading];
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
    return [cacheArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (PreordainCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PreordainCell *cell = (PreordainCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PreordainCell" owner:self options:nil]objectAtIndex:0];
    }
    
    // Configure the cell...
    //重新设置位置，以便使用
    cell.ticketPriceLabel.hidden = YES;
    cell.ticketTypeLabel.hidden = YES;
    cell.TypeContentLabel.hidden = YES;
    cell.ticketTypeLabel.hidden = YES;
    cell.LastCountLabel.hidden = YES;
    cell.ticketPriceLabel.hidden = YES;
    cell.ticketLastCountLabel.hidden = YES;
    cell.PriceContentLabel.hidden = YES;
    cell.IDContentLabel.frame = CGRectMake(102, 10, 200, 30);
    cell.ticketPositionLabel.frame = CGRectMake(80, 40, 36, 22);
    cell.PositionContentLabel.frame = CGRectMake(102, 40, 106, 30);
    cell.ticketPositionLabel.text = @"用户名：";
    
    //选中时用
    ZYProSofter *member = (ZYProSofter *)[self.cacheArray objectAtIndex:indexPath.row];
    if ([member.memberID isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]]) {
        cell.PreordainButton.enabled = YES;
    }else{
        cell.PreordainButton.enabled = FALSE;
    }
    if ([member.memberJoinTag isEqualToString:@"1"]) {
        cell.PositionContentLabel.textColor = [UIColor redColor];//加红显示
    }
    [cell setZYProSofter:member];
    cell.typeImage.image = [self returnIfJoinedZYProSoftTeam:[member.memberJoinTag intValue]];//设置图片类型
    [cell.PreordainButton setBackgroundImage:[self returnButtonWithZYProSoftTag:[member.memberJoinTag intValue]] forState:UIControlStateNormal];//设置类型
    cell.PreordainButton.tag = indexPath.row;
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
//选择查询类型得代理方法
- (void)tapOnChooseTypeViewButton:(id)sender withSelectIndex:(NSInteger)index
{
    UIButton *tempBtn = (UIButton *)sender;
    switch (tempBtn.tag) {
        case ZYPROSOFT_CHOOSE_TYPE_CANCEL_BUTTON_TAG:
            [ZYViewAnimation animationBasicBottomForwordView:typeChooseView duration:0.3 destination:200];
            typeChooseViewCanMove = YES;
            searchBar.searchButton.enabled = YES;
            break;
        case ZYPROSOFT_CHOOSE_TYPE_YES_BUTTON_TAG:
            
            [ZYViewAnimation animationBasicBottomForwordView:typeChooseView duration:0.3 destination:200];
            typeChooseViewCanMove = YES;
            searchBar.searchButton.enabled =YES;
            selectTypeIndex = index;
            //临时改变按钮标题
            switch (index) {
                case QUERY_USERINFO_BY_USER_ID:
                    [searchBar.typeSelectButton setTitle:@"用户ID：" forState:UIControlStateNormal];
                    break;
                case QUERY_USERINFO_BY_USER_NAME:
                    [searchBar.typeSelectButton setTitle:@"用户名：" forState:UIControlStateNormal];
                    break;
                case QUERY_USER_MEMBER_TYPE:
                    [searchBar.typeSelectButton setTitle:@"已认证：" forState:UIControlStateNormal];
                    searchBar.searchField.text = @"所有 已认证";
                    break;
                case QUERY_USER_NOTMEMBER_TYPE:
                    [searchBar.typeSelectButton setTitle:@"未认证：" forState:UIControlStateNormal];
                    searchBar.searchField.text = @"所有 未认证";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}
- (void)beginChooseType:(id)sender
{
    //不能弹出就返回
    if ([self pushViewNowIsUnEnable]) {
        return;
    }
    //弹出类型选择视图 
    [ZYViewAnimation animationBasicTopForwordView:typeChooseView duration:0.3 destination:200];
    typeChooseViewCanMove = NO;//改变弹出状态
    searchBar.searchButton.enabled = FALSE;
}

//搜索栏得方法覆盖
- (void)searchResultWithKeyWord:(NSString *)keyword
{
    NSString *paramKeyString = nil;
    if (selectTypeIndex == QUERY_USER_MEMBER_TYPE) {
        paramKeyString = [NSString stringWithFormat:@"%d",1];
        selectTypeIndex = QUERY_USERINFO_BY_USER_TYPE;
    }else if(selectTypeIndex == QUERY_USER_NOTMEMBER_TYPE){
        paramKeyString = [NSString stringWithFormat:@"%d",0];
        selectTypeIndex = QUERY_USERINFO_BY_USER_TYPE;
    }else{
        paramKeyString = keyword;
    }
    //组合请求参数
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",selectTypeIndex],@"queryType",paramKeyString,@"param1", nil];
    [[ZYNetworkHelper shareZYNetworkHelper]requestDataWithApplicationType:TicketSystemRequestQueryType withParams:paramDict withHelperDelegate:self withSuccessRequestMethod:@"searchMemberInfoSuccess:" withFaildRequestMethod:@"searchMemeberInfoFaild:"];
    
    [MBProgressHUD showHUDAddedTo:self.view withLabel:@"正在搜索指定成员信息..." animated:YES];
}
//加入ZYProSoft团队得代理方法
- (void)tapOnJoinZYProSoftTeamViewButton:(id)sender
{
    UIButton *tempBtn = (UIButton *)sender;
    switch (tempBtn.tag) {
        case ZYPROSOFT_NOTIVIEW_CANCEL_BUTTON_TAG:
            [ZYViewAnimation animationBasicTopForwordView:joinTeamView duration:0.3 destination:280];
            joinTeamViewCanMove = YES;
            break;
        case ZYPROSOFT_NOTIVIEW_YES_BUTTON_TAG:
            [ZYViewAnimation animationBasicTopForwordView:joinTeamView duration:0.3 destination:280];
            joinTeamViewCanMove = YES;
            //组合参数
            NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"],@"userID",joinTeamView.checkCodeField.text,@"checkCode", nil];
            [[ZYNetworkHelper shareZYNetworkHelper]requestDataWithApplicationType:TicketSystemRequestZYProSofterType withParams:paramDict withHelperDelegate:self withSuccessRequestMethod:@"joinZYProSoftSuccess:" withFaildRequestMethod:@"joinZYProSoftFaild:"];
            [MBProgressHUD showHUDAddedTo:self.view withLabel:@"正在执行申请..." animated:YES];
            
            break;
        case ZYPROSOFT_NOTIVIEW_GETCODE_BUTTON_TAG:
            [ZYViewAnimation animationBasicTopForwordView:joinTeamView duration:0.3 destination:280];
            joinTeamViewCanMove = YES;
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.ruyijian.com"]];
            break;
        default:
            break;
    }
}
//cell代理方法
- (void)tapOnPreordainButton:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    ZYProSofter *selectMember = [self.cacheArray objectAtIndex:temp.tag];
    if ([selectMember.memberJoinTag intValue]==1) {
        NSString *sMessage = @"你已经是ZYProSoft团队成员，你可以登陆团队官方网站：http://www.ruyijian.com和团队其他成员沟通交流。";
        UIAlertView *zyProSoftAlertView = [[UIAlertView alloc]initWithTitle:@"验证提示" message:sMessage delegate:self cancelButtonTitle:@"暂不登陆" otherButtonTitles:@"立即登陆", nil];
        [zyProSoftAlertView show];
        [zyProSoftAlertView release];
        return;
    }
    if (joinTeamViewCanMove == NO) {
        return;
    }
    [ZYViewAnimation animationBasicBottomForwordView:joinTeamView duration:0.3 destination:280];
    joinTeamViewCanMove = NO;
}
//获取所有成员信息
- (void)getAllMemberInfo
{
    //组合参数
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",QUERY_ALL_USERINFO],@"queryType",
                               @"",@"param1",nil];
    [[ZYNetworkHelper shareZYNetworkHelper]requestDataWithApplicationType:TicketSystemRequestQueryType withParams:paramDict withHelperDelegate:self withSuccessRequestMethod:@"getAllMemberInfoSuccess:" withFaildRequestMethod:@"getAllMemberInfoSuccess:"];
}
//覆盖基础类刷新方法
- (void)refresh
{
    [self performSelector:@selector(getAllMemberInfo) withObject:nil afterDelay:0.2];
}
// 立即刷新
- (void)refreshNow
{
    //开始刷新
    [self.tableView setContentOffset:CGPointMake(0, -100)];
    [self startLoading];

}
//获取所有成员信息成功
- (void)getAllMemberInfoSuccess:(NSObject *)result
{
    if (self.cacheArray) {
        self.cacheArray = nil;
        self.cacheArray = [NSMutableArray array];
    }
    //处理获得信息
    NSArray *resultArray = (NSArray *)result;
    for (int i = 0; i < [resultArray count]; i++) {
        NSDictionary *memberDict = [resultArray objectAtIndex:i];
        ZYProSofter *member = [[ZYProSofter alloc]init];
        member.memberID = [memberDict objectForKey:@"user_id"];
        member.memberName = [memberDict objectForKey:@"user_name"];
        member.memberJoinTag = [memberDict objectForKey:@"zyProSoft_Tag"];
        [self.cacheArray addObject:member];
        [member release];
    }
    [self.tableView reloadData];//刷新列表数据
    [self stopLoading];
    //左边导航按钮消失
    self.navigationItem.leftBarButtonItem = nil;
}
//获取所有成员信息失败
- (void)getAllMemberInfoFaild:(NSObject *)result
{
    [self stopLoading];
}
//搜索指定信息成功
- (void)searchMemberInfoSuccess:(NSObject *)result
{
    if (self.cacheArray) {
        self.cacheArray = nil;
        self.cacheArray = [NSMutableArray array];
    }
    //处理获得信息
    NSArray *resultArray = (NSArray *)result;
    for (int i = 0; i < [resultArray count]; i++) {
        NSDictionary *memberDict = [resultArray objectAtIndex:i];
        ZYProSofter *member = [[ZYProSofter alloc]init];
        member.memberID = [memberDict objectForKey:@"user_id"];
        member.memberName = [memberDict objectForKey:@"user_name"];
        member.memberJoinTag = [memberDict objectForKey:@"zyProSoft_Tag"];
        //把自己得位置放到第二位
        if ([member.memberID isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]]) {
            [self.cacheArray insertObject:member atIndex:0];
        }else{
            [self.cacheArray addObject:member];

        }
        [member release];
    }
    //添加左边导航按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"查看所有" style:UIBarButtonItemStyleBordered target:self action:@selector(refreshNow)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    [self.tableView reloadData];//刷新列表数据
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
//搜索指定信息失败
- (void)searchMemeberInfoFaild:(NSObject *)result
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
//加入ZYProSoft团队反馈成功
- (void)joinZYProSoftSuccess:(NSObject *)result
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *sMessage = nil;
    
    NSDictionary *resultDict = (NSDictionary *)result;
    NSInteger resultTag = [[resultDict objectForKey:@"zyProSoftCheckTag"]intValue];
    switch (resultTag) {
        case ZYPROSOFT_CHECKCODE_IS_FAULT:
            sMessage = @"你提供得验证码不正确，请登陆http://www.ruyijian.com -> ZYProSoft团队官方网站获取验证码！";
            UIAlertView *zyProSoftAlertView = [[UIAlertView alloc]initWithTitle:@"验证提示" message:sMessage delegate:self cancelButtonTitle:@"暂不获取" otherButtonTitles:@"立即获取", nil];
            [zyProSoftAlertView show];
            [zyProSoftAlertView release];
            
            break;
        case ZYPROSOFT_CHECK_SUCCESS:
            sMessage = @"恭喜，你已经成功加入ZYProSoft团队!";
            [self refreshNow];// 立即刷新
            UIAlertView *checkSuccessAlertView = [[UIAlertView alloc]initWithTitle:@"验证提示" message:sMessage delegate:self cancelButtonTitle:@"返回订票系统" otherButtonTitles:@"登陆团队官网", nil];
            [checkSuccessAlertView show];
            [checkSuccessAlertView release];     
            break;
        case ZYPROSOFT_UPDATE_FAILD:
            sMessage = @"服务器繁忙，请稍后再试。";
            [self alertWithTitle:@"验证提示" message:sMessage];
            break;
        default:
            break;
    }
}
//加入ZYProSoft团队反馈失败
- (void)joinZYProSoftFaild:(NSObject *)result
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
//alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.ruyijian.com"]];
            break;
        case 0:
            break;
        default:
            break;
    }
}

- (void)dealloc{
    [cacheArray release];
    [joinTeamView release];
    [super dealloc];
}

@end
