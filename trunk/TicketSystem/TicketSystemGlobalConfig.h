//
//  TicketSystemGlobalConfig.h
//  TicketSystem
//
//  Created by ZYVincent on 12-2-22.
//---------------------------------
//    文件作用：应用程序全局定义文件，定义一些全局宏，定义与服务器通信得宏，
//            设置全局得一些参数，如网络请求得接口地址
//            
//    作者：胡涛
//    支持:http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！
//---------------------------------
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//

#define CHOOSEVIEW_CANCEL_BUTTON_TAG 6666
#define CHOOSEVIEW_YES_BUTTON_TAG 8888

#define CHOOSETYPE_CANCEL_BUTTON_TAG 5555
#define CHOSSETYPE_YES_BUTTON_TAG 4444
#define ORDERVIEW_CANCEL_BUTTON_TAG 9999
#define ORDERVIEW_YES_BUTTON_TAG 7777

#define PERSON_CHOOSETYPE_CANCEL_BUTTON_TAG 1111
#define PERSON_CHOSSETYPE_YES_BUTTON_TAG 2222

#define TUIDING_CHOOSEVIEW_CANCEL_BUTTON_TAG 88888
#define TUIDING_CHOOSEVIEW_YES_BUTTON_TAG 99999

#define PERSON_ORDERVIEW_CANCEL_BUTTON_TAG 66666
#define PERSON_ORDERVIEW_YES_BUTTON_TAG 77777

#define ZYPROSOFT_CHOOSE_TYPE_CANCEL_BUTTON_TAG 44444
#define ZYPROSOFT_CHOOSE_TYPE_YES_BUTTON_TAG 33333

#define NOTI_CHOOSETYPE_CANCEL_BUTTON_TAG 666777
#define NOTI_CHOOSETYPE_YES_BUTTON_TAG 777666

//登录注册模块
#define LOGIN_SUCCESS 20010 //登录成功
#define LOGIN_UNREGISTE_FAILD 20011 //登录失败，用户名id不存在
#define LOGIN_FAILD 20013 //登录失败，密码错误
#define REGISTE_SUCCESS 20014 //注册成功
#define REGISTE_FAILD 20015 //身份证id已经被注册
#define REGISTE_FAILD_SERVER_BUSY 20016 //服务器繁忙,注册失败

#define DING_PIAO_COUNT_FALSE_TYPE 30011 //数据冲突
#define DING_PIAO_SERVER_FAILD_TYPE 30012 //服务器更新用户订票信息失败
#define DING_PIAO_SUCCESS 30013 //订票成功
#define DING_PIAO_UPDATE_FAILD 30014 //订票失败

//退订操作
#define TUI_DING_SUCCESS 50010 //退订成功
#define TUI_DING_SERVER_BUSY_FAILD 50011//服务器繁忙，退订失败
#define TUI_DING_FAILD 50012//退订失败

//查询操作
#define QUERY_ALL_RESULT 40009//查询所有结果
#define QUERY_BY_USER_ID 40010//根据用户ID查询
#define QUERY_BY_TICKET_ID 40011//根据票ID查询
#define QUERY_BY_TICKET_PRICE 40013//根据票价查询
#define QUERY_BY_TICKET_POSITION 40014//根据票位置查询
#define QUERY_BY_TICKET_TYPE 40012//根据票类型查询 
#define QUERY_FAILD 40023 //查询结果失败
#define QUERY_RESULT_IS_NULL 40024 //查询结果为空
#define QUERY_USERINFO_BY_USER_ID  40033//根据用户ID来查询用户信息
#define QUERY_USERINFO_BY_USER_NAME 40034//根据用户名来查询用户信息
#define QUERY_USERINFO_BY_USER_TYPE 40035//根据用户类型来查询用户信息
#define QUERY_ALL_USERINFO 40036//查询所有用户信息
#define QUERY_USER_MEMBER_TYPE 40040//用户已认证
#define QUERY_USER_NOTMEMBER_TYPE 40041//用户未认证
#define QUERY_NEW_ZYPROSOFT_NOTI_TYPE 50001//查询最新的团队通知
#define QUERY_ZYPROSOFT_NOTI_FAILD 50002//查询最新团队通知失败
#define QUERY_SERVER_NOTI_UPDATE_TYPE 50003//查询服务器最新的更新时间
#define SERVER_NOTI_UPDATE_TIME_IS_EQUAL 50004//服务器更新时间和客户端一致
#define SERVER_NOTI_UPDATE_TIME_IS_NEW 50005//服务器更新时间比客户端的晚
#define QUERY_NOTI_BY_NOTI_TYPE 56666 //根据通知类型来查询

//返回通知的类型
#define NOTI_TYPE_NOTI 666000  //通知
#define NOTI_TYPE_GONGGAO 666001 //公告
#define NOTI_TYPE_GONGXI 666002 //恭喜
#define NOTI_TYPE_MEETING 666003 //会议
#define NOTI_TYPE_JINGGAO 666004 //警告
#define NOTI_TYPE_JINJI 666005 //紧急
#define NOTI_TYPE_QITA 666006 //其他

//客户端与服务器通信接口
#define REGIST_INTERFACE_URL @"http://www.ruyijian.com/TicketSystem/register.php"//注册接口
#define LOGIN_INTERFACE_URL @"http://www.ruyijian.com/TicketSystem/Login.php"//登录接口
#define QUERY_INTERFACE_URL @"http://www.ruyijian.com/TicketSystem/Query.php"//查询接口
#define PREORDAIN_INTERFACE_URL @"http://www.ruyijian.com/TicketSystem/preordain.php"//订票接口
#define UNSUBSCRIBE_INTERFACE_URL @"http://www.ruyijian.com/TicketSystem/TuiDing.php"//退订接口
#define HOMEPAGE_AND_ABOUT_INTERFACE_URL @"http://www.ruyijian.com/TicketSystem/about.php" //主页和关于得请求接口
#define ZYPROSOFT_TEAM_INTERFACE_URL @"http://www.ruyijian.com/TicketSystem/ZYProSofter.php" //ZYProSoft团队成员数据申请接口

#define PERSONAL_INFO_REFRESH_NOTI @"RefreshNow" //通知个人所有票信息页面刷新
#define TICKET_INFO_REFRESH_NOTI @"TicketRefreshNow" //通知订票页面更新所有票信息


//ZYProSoft团队视图得Tag值
#define ZYPROSOFT_NOTIVIEW_CANCEL_BUTTON_TAG 888888
#define ZYPROSOFT_NOTIVIEW_GETCODE_BUTTON_TAG 8888888
#define ZYPROSOFT_NOTIVIEW_YES_BUTTON_TAG   88888888
#define ZYPROSOFT_CHECKCODE_IS_FAULT 99997//验证码错误
#define ZYPROSOFT_UPDATE_FAILD 99998//个人信息更新失败
#define ZYPROSOFT_CHECK_SUCCESS 99999//验证成功
