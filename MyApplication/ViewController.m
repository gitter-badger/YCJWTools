//
//  ViewController.m
//  MyApplication
//
//  Created by DwightDing on 16/6/4.
//  Copyright © 2016年 Ding Chenguang. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"
#import "LoginSuccessViewController.h"
@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
#pragma 界面定义
- (void) initView{
    //    navbar背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    
    //    navbar字体白色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
    // 设置登录按钮action
    [_login addTarget:self action:@selector(loginaction ) forControlEvents:UIControlEventTouchDown];
    // 设置返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    //登陆后禁止返回除非点按注销登录
    self.extendedLayoutIncludesOpaqueBars = YES;
    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [sandboxpath objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"user.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    if ([dic objectForKey:@"username"]) {
        [self userLoginwithusername:[dic objectForKey:@"username"] password:[dic objectForKey:@"password"]];
    }
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    //    键盘响应 return键盘消失
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma 用户登录
- (void) loginaction{
    [self userLoginwithusername:nil password:nil];
}
- (void)userLoginwithusername:(NSString*)uname password:(NSString*)pass{
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURL *URL=[NSURL URLWithString:@"http://www.ycjw.zjut.edu.cn/logon.aspx"];//登录模块
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;
    request.HTTPMethod=@"POST";
    
    if (uname!=nil &&pass !=nil) {
        _yczh.text = uname;
        _ycmm.text = pass;
    }
    NSString *viewstate = @"__VIEWSTATE=dDwtMTU2MDM2OTk5Nzt0PDtsPGk8MT47PjtsPHQ8O2w8aTwzPjtpPDEzPjs%2BO2w8dDw7bDxpPDE%2BO2k8Mz47aTw1PjtpPDc%2BO2k8OT47aTwxMT47aTwxMz47aTwxNT47aTwxNz47PjtsPHQ8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZy5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47dDxwPHA8bDxCYWNrSW1hZ2VVcmw7PjtsPGh0dHA6Ly93d3cueWNqdy56anV0LmVkdS5jbi8vaW1hZ2VzL2JnMS5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47dDxwPHA8bDxCYWNrSW1hZ2VVcmw7PjtsPGh0dHA6Ly93d3cueWNqdy56anV0LmVkdS5jbi8vaW1hZ2VzL2JnMS5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47Pj47dDx0PDt0PGk8Mz47QDwtLeeUqOaIt%2Bexu%2BWeiy0tO%2BaVmeW4iDvlrabnlJ87PjtAPC0t55So5oi357G75Z6LLS075pWZ5biIO%2BWtpueUnzs%2BPjs%2BOzs%2BOz4%2BOz4%2BO2w8SW1nX0RMOz4%2Bqmizg8nuU1ebhUFzNA%2Fqu71sECk%3D&";
    NSString *param=[NSString stringWithFormat:@"__EVENTTARGET=&__EVENTARGUMENT=&%@&Cbo_LX=学生&Txt_UserName=%@&Txt_Password=%@&Img_DL.x=0&Img_DL.y=0",viewstate,_yczh.text,_ycmm.text];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    request.HTTPBody=[param dataUsingEncoding:enc];
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36" forHTTPHeaderField:@"User-Agent"];
    
    
    NSURLSessionDataTask * dataRequesting =[defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        NSString *logData = [[NSString alloc] initWithData:data encoding:enc];
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
            {
                UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"错误提示"
                                                             message:connectionError.localizedDescription
                                                            delegate:nil
                                                   cancelButtonTitle:@"确认"
                                                   otherButtonTitles:nil];
                [alt show];
                return;
            }
        }
        
        else {
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"提示"
                                                         message:@"登录成功"
                                                        delegate:nil
                                               cancelButtonTitle:@"确认"
                                               otherButtonTitles:nil];
            [alt show];
            //        NSLog(@"%@",logData);
            NSData *endata = [logData dataUsingEncoding:NSUTF8StringEncoding];
            TFHpple *doc = [[TFHpple alloc] initWithHTMLData:endata];
            NSArray *elements = [doc searchWithXPathQuery:@"//font"];
            TFHppleElement *element = [elements objectAtIndex:17];
            NSString *content = [element content];
            //        NSLog(@"%@",content);
            
            LoginSuccessViewController *lvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginSuccess"];
            lvc.uinfo = content;
            lvc.session = defaultSession;
            NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            //获取完整路径
            NSString *documentsDirectory = [sandboxpath objectAtIndex:0];
            NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"user.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_yczh.text,@"username",_ycmm.text,@"password", nil];
            [dic writeToFile:plistPath atomically:YES];
            
            [self.navigationController pushViewController:lvc animated:YES];
        }
    }];
    [dataRequesting resume];
}

@end
