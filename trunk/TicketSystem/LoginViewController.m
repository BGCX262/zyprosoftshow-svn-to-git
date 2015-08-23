//
//  LoginViewController.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-27.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "LoginViewController.h"
#import "RegistViewController.h"


#define GREEN_VALUE 92
#define RED_VALUE 180
#define BLUE_VALUE 220
#define COLOR_ALPHA 1

@implementation LoginViewController
@synthesize delegate;
@synthesize idTextField;
@synthesize pwdTextField;
@synthesize idLabel;
@synthesize pwdLabel;
@synthesize rememberBtn;
@synthesize registBtn;
@synthesize loginBtn;
@synthesize inputBackImgView;
@synthesize kitIfMoved;

//保存用户账号信息
- (void)saveUserInfo
{
    NSString *userID = nil;
    NSString *userPwd = nil;
    if (idTextField.text) {
        userID = idTextField.text;
    }else{
        userID = [NSString stringWithFormat:@"0"];
    }
    if (pwdTextField.text) {
        userPwd = pwdTextField.text;
    }else{
        userPwd = [NSString stringWithFormat:@"0"];
    }
    NSNumber *rememberState = [NSNumber numberWithBool:ifRememberPwd];
    NSArray *userArray = [NSArray arrayWithObjects:userID,userPwd,rememberState, nil];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *file = [path stringByAppendingPathComponent:@"userInfo"];
    
    [NSKeyedArchiver archiveRootObject:userArray toFile:file];
}

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //读取是否记住密码得状态
    ifRememberPwd = NO;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *file = [path stringByAppendingPathComponent:@"userInfo"];
    NSArray *userInfoArray = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    ifRememberPwd = [[userInfoArray objectAtIndex:2]boolValue];
    if (ifRememberPwd) {
        [rememberBtn setBackgroundImage:[UIImage imageNamed:@"rememberButtonYes.png"] forState:UIControlStateNormal];
        pwdTextField.text = [userInfoArray objectAtIndex:1];
    }else{
        [rememberBtn setBackgroundImage:[UIImage imageNamed:@"rememberButtonNo.png"] forState:UIControlStateNormal];
    }
    idTextField.text = [userInfoArray objectAtIndex:0];
    
    idTextField.placeholder = @"请填写身份证号";
    idTextField.adjustsFontSizeToFitWidth = YES;
    idTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    idTextField.returnKeyType = UIReturnKeyDone;
    
    pwdTextField.placeholder = @"请输入0－6位得密码";
    pwdTextField.secureTextEntry = YES;
    pwdTextField.returnKeyType = UIReturnKeyDone;
        
    
}

- (void)viewDidUnload
{
    [self setIdTextField:nil];
    [self setPwdTextField:nil];
    [self setIdLabel:nil];
    [self setPwdLabel:nil];
    [self setRememberBtn:nil];
    [self setRegistBtn:nil];
    [self setLoginBtn:nil];
    [self setInputBackImgView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)alertWithMassage:(NSString *)tMessage
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"登录提示" message:tMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)loginSuccess:(NSObject*)result
{   
    NSString *message = nil;
    NSDictionary *resultDict = (NSDictionary *)result;
    NSInteger loginTag = [[resultDict objectForKey:@"loginTag"]intValue];
    if (loginTag == LOGIN_SUCCESS) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //在本地纪录用户信息
        [[NSUserDefaults standardUserDefaults]setObject:idTextField.text forKey:@"userID"];//纪录在本地用
        [self saveUserInfo];
        
        if (delegate && [delegate respondsToSelector:@selector(loginSuccessed:)]) {
            [delegate loginSuccessed:result];
        }
    }else if(loginTag == LOGIN_UNREGISTE_FAILD){
        message = @"对不起，该身份证号没有注册,请重新输入";
        idTextField.text = @"";
        pwdTextField.text = @"";
        [idTextField becomeFirstResponder];
        [self alertWithMassage:message];
    }else if(loginTag == LOGIN_FAILD){
        message = @"密码错误，请重新输入密码";
        pwdTextField.text = @"";
        [pwdTextField becomeFirstResponder];
        [self alertWithMassage:message];
    }
    
    

}
- (void)loginFaild:(NSObject*)result
{
    NSLog(@"Login Faild!");
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
//检测id和密码得填写情况
- (BOOL)idAndPwdCheck
{
    NSString *message = nil;
    if ([idTextField.text length]>18 ||[idTextField.text length] <=0 || [pwdTextField.text length]>6 || [pwdTextField.text length] <= 0) {
        message = @"请将账号和密码填写完整";
        [self alertWithMassage:message];
        idTextField.text = @"";
        pwdTextField.text = @"";
        [idTextField becomeFirstResponder];
        return FALSE;
    }
    if([Uitil checkIfPersonalIDNumber:idTextField.text]==FALSE){
        message = @"身份证号不正确！";
        [self alertWithMassage:message];
        idTextField.text = @"";
        pwdTextField.text = @"";
        [idTextField becomeFirstResponder];
        return FALSE;
    }
    return YES;
    
}
//控制输入框得位置
#define UIKIT_MOVE_DISTANCE 170
- (void)UIKitMoveToAdjustKeyboard:(BOOL)showOrHide{
    if (showOrHide) {
        [ZYViewAnimation animationBasicTopForwordView:idLabel duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicTopForwordView:idTextField duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicTopForwordView:pwdLabel duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicTopForwordView:pwdTextField duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicTopForwordView:rememberBtn duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicTopForwordView:registBtn duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicTopForwordView:loginBtn duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicTopForwordView:inputBackImgView duration:0.3 destination:UIKIT_MOVE_DISTANCE];

    }else{
        [ZYViewAnimation animationBasicBottomForwordView:idLabel duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicBottomForwordView:idTextField duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicBottomForwordView:pwdLabel duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicBottomForwordView:pwdTextField duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicBottomForwordView:rememberBtn duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicBottomForwordView:registBtn duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicBottomForwordView:loginBtn duration:0.3 destination:UIKIT_MOVE_DISTANCE];
        [ZYViewAnimation animationBasicBottomForwordView:inputBackImgView duration:0.3 destination:UIKIT_MOVE_DISTANCE];

    }
}

- (IBAction)loginAction:(id)sender {
    
    //只有检验登录合法才开始网络连接
    if ([self idAndPwdCheck]) {
        if (kitIfMoved == YES) {
            [self UIKitMoveToAdjustKeyboard:NO];
            kitIfMoved = NO;

        }
        //键盘恢复
        [idTextField resignFirstResponder];
        [pwdTextField resignFirstResponder];
        
        NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:idTextField.text,@"id",pwdTextField.text,@"pwd", nil];
        
        [[ZYNetworkHelper shareZYNetworkHelper]requestDataWithApplicationType:TicketSystemRequestLoginType withParams:paramDict withHelperDelegate:self withSuccessRequestMethod:@"loginSuccess:" withFaildRequestMethod:@"loginFaild:"];//需要注意得地方，如果回调方法带参数则必须要有冒号,否则会出现无法识别得错误

        [MBProgressHUD showHUDAddedTo:self.view withLabel:@"正在登录..." animated:YES];
        
    }
    
}

//注册
- (IBAction)registAction:(id)sender {
    RegistViewController *viewController = [[RegistViewController alloc]initWithNibName:@"RegistViewController" bundle:nil];
    [self presentModalViewController:viewController animated:YES];
    
}
- (void)rememberButtonChangeImg:(BOOL)state
{
    if (state) {
        [rememberBtn setBackgroundImage:[UIImage imageNamed:@"rememberButtonYes.png"] forState:UIControlStateNormal];
    }else{
        [rememberBtn setBackgroundImage:[UIImage imageNamed:@"rememberButtonNo.png"] forState:UIControlStateNormal];
    }
    [self saveUserInfo];//保存用户信息
}
//记住密码
- (IBAction)rememberPwdAction:(id)sender {
    ifRememberPwd = !ifRememberPwd;
    [self rememberButtonChangeImg:ifRememberPwd];
}

//textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [self UIKitMoveToAdjustKeyboard:NO];
    kitIfMoved = NO;
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == idTextField) {
        if (kitIfMoved) {
            return;
        }
        [self UIKitMoveToAdjustKeyboard:YES];
        kitIfMoved = YES;
    }
    if (textField == pwdTextField) {
        if (kitIfMoved) {
            return;
        }
        [self UIKitMoveToAdjustKeyboard:YES];
        kitIfMoved = YES;
    }
}


- (void)dealloc {
    [idTextField release];
    [pwdTextField release];
    [idLabel release];
    [pwdLabel release];
    [rememberBtn release];
    [registBtn release];
    [loginBtn release];
    [inputBackImgView release];
    [super dealloc];
}

@end
