//
//  RegistViewController.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-27.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "RegistViewController.h"


@implementation RegistViewController
@synthesize backScrollView;
@synthesize idTextField;
@synthesize nameTextField;
@synthesize pwdTextField;
@synthesize rePwdTextField;

//帮助函数
- (void)alertWithMessage:(NSString *)Errormessage
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"错误提示" message:Errormessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
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
    //重新设置键盘得返回按钮
    idTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    idTextField.placeholder = @"请输入正确得身份证号";
    idTextField.adjustsFontSizeToFitWidth = YES;
    idTextField.returnKeyType = UIReturnKeyNext;
    
    nameTextField.returnKeyType = UIReturnKeyNext;
    nameTextField.placeholder = @"请输入您得姓名";
    nameTextField.adjustsFontSizeToFitWidth = YES;
    pwdTextField.returnKeyType = UIReturnKeyNext;
    pwdTextField.placeholder = @"请输入0－6位密码";
    pwdTextField.secureTextEntry = YES;
    rePwdTextField.returnKeyType = UIReturnKeyDone;
    rePwdTextField.placeholder = @"请再次输入密码";
    rePwdTextField.secureTextEntry = YES;
    
    self.backScrollView.contentSize = CGSizeMake(320, 600);
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == rePwdTextField) {
        [rePwdTextField becomeFirstResponder];
        [backScrollView scrollRectToVisible:CGRectMake(0, 400,320 ,310 ) animated:YES];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *errorMessage = nil;
    
    if (textField == pwdTextField) {
        if ([pwdTextField.text length]>6 || [pwdTextField.text length] <= 0) {
            pwdTextField.text = @"";
            errorMessage = @"密码位数超过6位或者为空，请重新输入密码";
            [self alertWithMessage:errorMessage];
            [pwdTextField becomeFirstResponder];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *errorMessage = nil;
    if (textField == rePwdTextField) {
        
        //判断两次密码输入是否一致
        if (![pwdTextField.text isEqualToString:rePwdTextField.text]) {
            errorMessage = @"两次密码输入不一致，请重新输入";
            [self alertWithMessage:errorMessage];
            pwdTextField.text = @"";
            rePwdTextField.text = @"";
            [pwdTextField becomeFirstResponder];
            return YES;
        }
        [textField resignFirstResponder];
        [backScrollView scrollRectToVisible:CGRectMake(0, 0, 320, 480) animated:YES];
        
    }else{
        if (textField == idTextField) {
            if ([idTextField.text length]==0) {
                errorMessage = @"身份证号不能为空，请重新填写";
                [self alertWithMessage:errorMessage];
                idTextField.text = @"";
                [idTextField becomeFirstResponder];
                
            }
            [nameTextField becomeFirstResponder];
        }else if(textField == nameTextField){
            if ([nameTextField.text length]==0) {
                errorMessage = @"姓名不能为空，请重新填写";
                [self alertWithMessage:errorMessage];
                nameTextField.text = @"";
                [nameTextField becomeFirstResponder];
                
            }
            [pwdTextField becomeFirstResponder];
        }else if(textField == pwdTextField){
            if ([pwdTextField.text length]>6 || pwdTextField.text <= 0) {
                pwdTextField.text = @"";
                errorMessage = @"密码位数超过6位或者为空,请重新输入";
                [self alertWithMessage:errorMessage];
                [pwdTextField becomeFirstResponder];
                return YES;
            }else{
                [rePwdTextField becomeFirstResponder];
                [backScrollView scrollRectToVisible:CGRectMake(0, 400,320 ,310 ) animated:YES];
                return YES;
            }
           
        }
    }
    return YES;
}

- (void)viewDidUnload
{
    [self setBackScrollView:nil];
    [self setIdTextField:nil];
    [self setNameTextField:nil];
    [self setPwdTextField:nil];
    [self setRePwdTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [backScrollView release];
    [idTextField release];
    [nameTextField release];
    [pwdTextField release];
    [rePwdTextField release];
    [super dealloc];
}
- (IBAction)registAction:(id)sender {
    //检测注册信息是否填写完整
    if ([idTextField.text length]==0 || [nameTextField.text length] == 0 || [pwdTextField.text length] == 0 || [rePwdTextField.text length] == 0) {
        [self alertWithMessage:@"注册信息填写不完整，请补充完整"];
        NSArray *textAry = [NSArray arrayWithObjects:idTextField,nameTextField,pwdTextField,rePwdTextField, nil];
        for (UITextField *checkField in textAry) {
            if ([checkField.text length] == 0 ) {
                [checkField becomeFirstResponder];
                break;
            }
        }
    }else if([Uitil checkIfPersonalIDNumber:idTextField.text] == FALSE){//检测身份证号是否正确
        [self alertWithMessage:@"身份证号不正确！"];
        [idTextField becomeFirstResponder];
    }else{
        [rePwdTextField resignFirstResponder];
        [backScrollView scrollRectToVisible:CGRectMake(0, 400,320 ,310 ) animated:YES];
        
        NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:idTextField.text,@"id",nameTextField.text,@"name",rePwdTextField.text,@"pwd",@"0",@"zyProSoft_Tag", nil];
        [[ZYNetworkHelper shareZYNetworkHelper]requestDataWithApplicationType:TicketSystemRequestRegistType withParams:paramDict withHelperDelegate:self withSuccessRequestMethod:@"registSuccess:" withFaildRequestMethod:@"registFaild:"];
        [MBProgressHUD showHUDAddedTo:self.view withLabel:@"正在注册..." animated:YES];
    }
    
}

- (IBAction)cancelRegistAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
- (void)successOperation
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册成功" message:@"恭喜你注册成功，请使用身份证号作为ID登录。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
    [alert show];
    [alert release];
    [self dismissModalViewControllerAnimated:YES];
}
- (void)severBusyFaildOperaion
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册失败" message:@"服务器繁忙，请稍后再试！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
    [alert show];
    [alert release];
}
- (void)faildOperation
{   
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册失败" message:@"该身份证已被注册，请更换身份证号重新尝试！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
    [alert show];
    [alert release];
}
//注册请求返回处理办法
- (void)registSuccess:(NSObject *)result
{
    NSDictionary *resultJson = (NSDictionary *)result;
    NSInteger resultTag = [[resultJson objectForKey:@"registTag"]intValue];
    switch (resultTag) {
        case REGISTE_FAILD_SERVER_BUSY:
            [self severBusyFaildOperaion];
            break;
        case REGISTE_FAILD:
            [self faildOperation];
            break;
        case REGISTE_SUCCESS:
            [self successOperation];
            break;
            
        default:
            break;
    }
}
//注册请求返回失败处理办法
- (void)registFaild:(NSObject *)result
{
    NSLog(@"%@",result);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [backScrollView scrollRectToVisible:CGRectMake(0, 0,320 ,480 ) animated:YES];

}
@end
