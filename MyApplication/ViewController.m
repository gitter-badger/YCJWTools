//
//  ViewController.m
//  MyApplication
//
//  Created by DwightDing on 16/6/4.
//  Copyright © 2016年 Ding Chenguang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置登录按钮action
    [_login addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchDown];
}
//设置界面相关参数
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    navbar背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
//    navbar字体白色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
//    键盘响应 return键盘消失
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma 用户登录模块
- (void)userLogin{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURL *URL=[NSURL URLWithString:@"http://www.ycjw.zjut.edu.cn/logon.aspx"];//登录模块
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;
    request.HTTPMethod=@"POST";
    NSString *viewstate = @"__VIEWSTATE=dDwtMTU2MDM2OTk5Nzt0PDtsPGk8MT47PjtsPHQ8O2w8aTwzPjtpPDEzPjs%2BO2w8dDw7bDxpPDE%2BO2k8Mz47aTw1PjtpPDc%2BO2k8OT47aTwxMT47aTwxMz47aTwxNT47aTwxNz47PjtsPHQ8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZy5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47dDxwPHA8bDxCYWNrSW1hZ2VVcmw7PjtsPGh0dHA6Ly93d3cueWNqdy56anV0LmVkdS5jbi8vaW1hZ2VzL2JnMS5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47dDxwPHA8bDxCYWNrSW1hZ2VVcmw7PjtsPGh0dHA6Ly93d3cueWNqdy56anV0LmVkdS5jbi8vaW1hZ2VzL2JnMS5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47Pj47dDx0PDt0PGk8Mz47QDwtLeeUqOaIt%2Bexu%2BWeiy0tO%2BaVmeW4iDvlrabnlJ87PjtAPC0t55So5oi357G75Z6LLS075pWZ5biIO%2BWtpueUnzs%2BPjs%2BOzs%2BOz4%2BOz4%2BO2w8SW1nX0RMOz4%2Bqmizg8nuU1ebhUFzNA%2Fqu71sECk%3D&";
    NSString *param=[NSString stringWithFormat:@"__EVENTTARGET=&__EVENTARGUMENT=&%@&Cbo_LX=学生&Txt_UserName=%@&Txt_Password=%@&Img_DL.x=0&Img_DL.y=0",viewstate,_yczh.text,_ycmm.text];
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:enc];
    
    
    // 设置请求头信息
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36" forHTTPHeaderField:@"User-Agent"];
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        
        NSString *logData = [[NSString alloc] initWithData:data encoding:enc];
        NSLog(@"%@",logData);
        NSString *usernameOrPwdWrong = @"<script language=javascript>alert('登陆失败!忘记密码请到院办初始化!'); </script>";
        NSRange wrongObj=[logData rangeOfString:usernameOrPwdWrong options:NSCaseInsensitiveSearch];
        NSString *loginSuccess = @"学生密码修改";
        NSRange successObj=[logData rangeOfString:loginSuccess options:NSCaseInsensitiveSearch];
        
        if (connectionError || data == nil|| successObj.length<=0)
        {
            if(wrongObj.length>0) {
                UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"提示"
                                                             message:@"密码不正确"
                                                            delegate:nil
                                                   cancelButtonTitle:@"确认"
                                                   otherButtonTitles:nil];
                [alt show];
                
            }
            else
                
                return;
        }
        
        else {
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"提示"
                                                         message:@"登录成功"
                                                        delegate:nil
                                               cancelButtonTitle:@"确认"
                                               otherButtonTitles:nil];
            [alt show];
            [self performSegueWithIdentifier:@"loginSuccess" sender:self];
        }
    }];
    [dataTask resume];
}

@end
