//
//  LoginSuccessViewController.m
//  MyApplication
//
//  Created by DwightDing on 16/6/10.
//  Copyright © 2016年 Ding Chenguang. All rights reserved.
//

#import "LoginSuccessViewController.h"
#import "TFHpple.h"
#import "ScoreViewController.h"
#import "CourseViewController.h"
#import "MBProgressHUD.h"
@interface LoginSuccessViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    NSMutableArray *courses;
    NSMutableArray *scores;
    NSArray *yeararr;
    int year;
    int term;
}
@end

@implementation LoginSuccessViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) initview{
    //设置标题等界面
    self.title = @"登录成功";
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    _info.text = _uinfo;
    UIBarButtonItem *exit = [[UIBarButtonItem alloc]initWithTitle:@"注销登录" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
    [self.navigationItem setRightBarButtonItem:exit];
    [_classtable addTarget:self action:@selector(getClass) forControlEvents:UIControlEventTouchDown];
    [_score addTarget:self action:@selector(getscore) forControlEvents:UIControlEventTouchDown];
    NSBundle *boundle = [NSBundle mainBundle];
    NSString *path = [boundle pathForResource:@"year" ofType:@"plist"];
    //    默认数值
    year=2015;
    term=1;
    yeararr = [[NSArray alloc]initWithContentsOfFile:path];
    _picker.delegate = self;
    _picker.dataSource = self;
    [_picker selectRow:6 inComponent:0 animated:YES];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
}
- (void) logout{
    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [sandboxpath objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"user.plist"];
    NSDictionary *dic = [[NSDictionary alloc]init];
    [dic writeToFile:plistPath atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) getClass{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"查询中";
    [HUD show:YES];
    /*
     *@author Ding 2016/6/5
     *请求获取课表
     */
    NSURL *URL=[NSURL URLWithString:@"http://www.ycjw.zjut.edu.cn//stdgl/cxxt/Web_Std_XQKB.aspx"];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;
    request.HTTPMethod=@"POST";
    /*
     *@author Ding 2016/6/5
     *原创教务网站的请求字段
     */
    NSMutableString *req = [[NSMutableString alloc]initWithString:@"__EVENTTARGET=&__EVENTARGUMENT=&__VIEWSTATE=dDw5NjExNjI1OTE7dDw7bDxpPDE%2BOz47bDx0PDtsPGk8NT47aTw3PjtpPDk%2BO2k8MTU%2BO2k8MTk%2BO2k8MjE%2BOz47bDx0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w85a2m55Sf566h55CGXD7mn6Xor6Lns7vnu59cPuWtpueUn%2BivvuihqOafpeivojs%2BPjs%2BOzs%2BOz4%2BO3Q8cDxwPGw8VGV4dDs%2BO2w8MjAxNi0wNi0xNiAwNzoxNTowMDs%2BPjs%2BOzs%2BO3Q8dDw7dDxpPDQxPjtAPDE5OTkvMjAwMCgxKTsxOTk5LzIwMDAoMik7MjAwMC8yMDAxKDEpOzIwMDAvMjAwMSgyKTsyMDAxLzIwMDIoMSk7MjAwMS8yMDAyKDIpOzIwMDIvMjAwMygxKTsyMDAyLzIwMDMoMik7MjAwMy8yMDA0KDEpOzIwMDMvMjAwNCgyKTsyMDA0LzIwMDUoMSk7MjAwNC8yMDA1KDIpOzIwMDUvMjAwNigxKTsyMDA1LzIwMDYoMik7MjAwNi8yMDA3KDEpOzIwMDYvMjAwNygyKTsyMDA3LzIwMDgoMSk7MjAwNy8yMDA4KDIpOzIwMDgvMjAwOSgxKTsyMDA4LzIwMDkoMik7MjAwOS8yMDEwKDEpOzIwMDkvMjAxMCgyKTsyMDEwLzIwMTEoMSk7MjAxMC8yMDExKDIpOzIwMTEvMjAxMigxKTsyMDExLzIwMTIoMik7MjAxMi8yMDEzKDEpOzIwMTIvMjAxMygyKTsyMDEzLzIwMTQoMSk7MjAxMy8yMDE0KDIpOzIwMTQvMjAxNSgxKTsyMDE0LzIwMTUoMik7MjAxNS8yMDE2KDEpOzIwMTUvMjAxNigyKTsyMDE2LzIwMTcoMSk7MjAxNi8yMDE3KDIpOzIwMTcvMjAxOCgxKTsyMDE3LzIwMTgoMik7MjAxOC8yMDE5KDEpOzIwMTgvMjAxOSgyKTsyMDk4LzIwOTkoMSk7PjtAPDE5OTkvMjAwMCgxKTsxOTk5LzIwMDAoMik7MjAwMC8yMDAxKDEpOzIwMDAvMjAwMSgyKTsyMDAxLzIwMDIoMSk7MjAwMS8yMDAyKDIpOzIwMDIvMjAwMygxKTsyMDAyLzIwMDMoMik7MjAwMy8yMDA0KDEpOzIwMDMvMjAwNCgyKTsyMDA0LzIwMDUoMSk7MjAwNC8yMDA1KDIpOzIwMDUvMjAwNigxKTsyMDA1LzIwMDYoMik7MjAwNi8yMDA3KDEpOzIwMDYvMjAwNygyKTsyMDA3LzIwMDgoMSk7MjAwNy8yMDA4KDIpOzIwMDgvMjAwOSgxKTsyMDA4LzIwMDkoMik7MjAwOS8yMDEwKDEpOzIwMDkvMjAxMCgyKTsyMDEwLzIwMTEoMSk7MjAxMC8yMDExKDIpOzIwMTEvMjAxMigxKTsyMDExLzIwMTIoMik7MjAxMi8yMDEzKDEpOzIwMTIvMjAxMygyKTsyMDEzLzIwMTQoMSk7MjAxMy8yMDE0KDIpOzIwMTQvMjAxNSgxKTsyMDE0LzIwMTUoMik7MjAxNS8yMDE2KDEpOzIwMTUvMjAxNigyKTsyMDE2LzIwMTcoMSk7MjAxNi8yMDE3KDIpOzIwMTcvMjAxOCgxKTsyMDE3LzIwMTgoMik7MjAxOC8yMDE5KDEpOzIwMTgvMjAxOSgyKTsyMDk4LzIwOTkoMSk7Pj47bDxpPDMzPjs%2BPjs7Pjt0PHA8cDxsPFRleHQ7PjtsPOWtpueUnzrkuIHmmajlhYnnmoTor77ooajkv6Hmga87Pj47Pjs7Pjt0PEAwPHA8cDxsPFBhZ2VDb3VudDtfIUl0ZW1Db3VudDtfIURhdGFTb3VyY2VJdGVtQ291bnQ7RGF0YUtleXM7PjtsPGk8MT47aTw5PjtpPDk%2BO2w8aTwxNDU2MD47aTwxOTI5OD47aTwxOTMzND47aTwxNzQ5Nj47aTw3OTY1PjtpPDEzMTE%2BO2k8MTg4NjU%2BO2k8MTkyODY%2BO2k8MTg0MjI%2BOz47Pj47Pjs7Ozs7Ozs7Ozs%2BO2w8aTwwPjs%2BO2w8dDw7bDxpPDE%2BO2k8Mj47aTwzPjtpPDQ%2BO2k8NT47aTw2PjtpPDc%2BO2k8OD47aTw5Pjs%2BO2w8dDw7bDxpPDA%2BO2k8MT47aTwyPjtpPDM%2BO2k8ND47aTw1Pjs%2BO2w8dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOaTjeS9nOezu%2Be7n%2BWkp%2BWei%2BWunumqjOKFoDrkvZXnjrLlqJwgIDs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzorqHnrpfmnLrnp5HlrabkuI7mioDmnK%2FlrabpmaI7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w8MC41Oz4%2BOz47Oz47Pj47dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPDHlkag7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w8XGU7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w85b%2BF5L%2Bu6K%2B%2BOz4%2BOz47Oz47Pj47Pj47dDw7bDxpPDA%2BO2k8MT47aTwyPjtpPDM%2BO2k8ND47aTw1Pjs%2BO2w8dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOW%2BruacuuaOpeWPo%2BaKgOacr%2BWkp%2BWei%2BWunumqjOKFoDrpm7foibPpnZkgIDs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzorqHnrpfmnLrnp5HlrabkuI7mioDmnK%2FlrabpmaI7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w8MC41Oz4%2BOz47Oz47Pj47dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPDHlkag7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w8XGU7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w85b%2BF5L%2Bu6K%2B%2BOz4%2BOz47Oz47Pj47Pj47dDw7bDxpPDA%2BO2k8MT47aTwyPjtpPDM%2BO2k8ND47aTw1Pjs%2BO2w8dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOWIm%2BaWsOWunui3teKFpTrpmYjms6IgIDs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzorqHnrpfmnLrnp5HlrabkuI7mioDmnK%2FlrabpmaI7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w8MTs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwzMDs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwxLTE15ZGoOuaYn%2BacnzEoMS0yKSAg54mp55CG5a6e6aqM5a6kXDs7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w85b%2BF5L%2Bu6K%2B%2BOz4%2BOz47Oz47Pj47Pj47dDw7bDxpPDA%2BO2k8MT47aTwyPjtpPDM%2BO2k8ND47aTw1Pjs%2BO2w8dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOaJi%2Bacuui9r%2BS7tuW8gOWPkeKFoDrmnY7kvJ8gIDs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzorqHnrpfmnLrnp5HlrabkuI7mioDmnK%2FlrabpmaI7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w8Mzs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDw0ODs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwxLTE25ZGoOuaYn%2BacnzEoNi03KSAg5YGlQjEwMlw7MS045ZGoOuaYn%2BacnzQoMy00KSAg5YGlQjEwN1w7Oz4%2BOz47Oz47Pj47dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOW%2FheS%2Fruivvjs%2BPjs%2BOzs%2BOz4%2BOz4%2BO3Q8O2w8aTwwPjtpPDE%2BO2k8Mj47aTwzPjtpPDQ%2BO2k8NT47PjtsPHQ8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzlvq7mnLrmjqXlj6PmioDmnK%2FihaA66Zu36Imz6Z2ZICA7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w86K6h566X5py656eR5a2m5LiO5oqA5pyv5a2m6ZmiOz4%2BOz47Oz47Pj47dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPDQ7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w8NjQ7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w8MS0xNuWRqDrmmJ%2FmnJ8yKDEwLTExKSAg5rOV5a2mQjEwNlw7MS0xNuWRqDrmmJ%2FmnJ80KDEtMikgIOazleWtpkIyMDdcOzs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzlv4Xkv67or747Pj47Pjs7Pjs%2BPjs%2BPjt0PDtsPGk8MD47aTwxPjtpPDI%2BO2k8Mz47aTw0PjtpPDU%2BOz47bDx0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w85bel56iL57uP5rWO4oWgOumDreWFg%2Ba6kCAgOz4%2BOz47Oz47Pj47dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOe7j%2Bi0uOeuoeeQhuWtpumZojs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwyOz4%2BOz47Oz47Pj47dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPDMyOz4%2BOz47Oz47Pj47dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPDEtMTblkag65pif5pyfMig2LTcpICDpg4HmlodCMjA2XDs7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w85b%2BF5L%2Bu6K%2B%2BOz4%2BOz47Oz47Pj47Pj47dDw7bDxpPDA%2BO2k8MT47aTwyPjtpPDM%2BO2k8ND47aTw1Pjs%2BO2w8dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOi9r%2BS7tuW3peeoi%2BKFoDrokaPlpKnpmLMgIDs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzorqHnrpfmnLrnp5HlrabkuI7mioDmnK%2FlrabpmaI7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w8Mjs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwzMjs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwxLTE25ZGoOuaYn%2BacnzQoNi03KSAg6K%2BtNTAxXDs7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w86ZmQ6YCJ6K%2B%2BOz4%2BOz47Oz47Pj47Pj47dDw7bDxpPDA%2BO2k8MT47aTwyPjtpPDM%2BO2k8ND47aTw1Pjs%2BO2w8dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOaTjeS9nOezu%2Be7n%2BiuvuiuoeKFoDrpmYjms6IgIDs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzorqHnrpfmnLrnp5HlrabkuI7mioDmnK%2FlrabpmaI7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w8Mzs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDw0ODs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwxLTjlkag65pif5pyfMSgxMC0xMSkgIOWNmuaYk0IyMDRcOzEtMTblkag65pif5pyfMygzLTQpICDpg4HmlodCMjAzXDs7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w85b%2BF5L%2Bu6K%2B%2BOz4%2BOz47Oz47Pj47Pj47dDw7bDxpPDA%2BO2k8MT47aTwyPjtpPDM%2BO2k8ND47aTw1Pjs%2BO2w8dDw7bDxpPDE%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOW1jOWFpeW8j%2Bezu%2Be7n%2BKFoDrlrqboi6XombkgIDs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzorqHnrpfmnLrnp5HlrabkuI7mioDmnK%2FlrabpmaI7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w8Mzs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDw0ODs%2BPjs%2BOzs%2BOz4%2BO3Q8O2w8aTwxPjs%2BO2w8dDxwPHA8bDxUZXh0Oz47bDw5LTE25ZGoOuaYn%2BacnzMoMTAtMTEpICDku4HlkowxMDdcOzEtMTblkag65pif5pyfNCg4LTkpICDpg4HmlodCNDA4XDs7Pj47Pjs7Pjs%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%2BO2w86ZmQ6YCJ6K%2B%2BOz4%2BOz47Oz47Pj47Pj47Pj47Pj47dDxAMDxwPHA8bDxQYWdlQ291bnQ7XyFJdGVtQ291bnQ7XyFEYXRhU291cmNlSXRlbUNvdW50O0RhdGFLZXlzOz47bDxpPDA%2BO2k8LTE%2BO2k8LTE%2BO2w8Pjs%2BPjs%2BOzs7Ozs7Ozs7Oz47Oz47Pj47Pj47PqoCfSM5aJPcql4ap59EYdTzvYlf&Cbo_Xueqi="];
    [req appendString:[NSString stringWithFormat:@"%d",year]];
    [req appendString:@"%2F"];
    [req appendString:[NSString stringWithFormat:@"%d",year+1]];
    [req appendString:@"%28"];
    [req appendString:[NSString stringWithFormat:@"%d",term]];
    [req appendString:@"%29&Button2=%B0%B4%BF%CE%B1%ED%B2%E9%D1%AF"];
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    request.HTTPBody=[req dataUsingEncoding:enc];
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:33.0) Gecko/20100101 Firefox/33.0" forHTTPHeaderField:@"User-Agent"];
    //    通过登录成功后的Session进行继续操作，免去多次请求登录
    NSURLSessionDataTask * dataRequesting =[self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        if (connectionError)
        {
            [HUD hide:YES];
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"错误提示"
                                                         message:connectionError.localizedDescription
                                                        delegate:nil
                                               cancelButtonTitle:@"确认"
                                               otherButtonTitles:nil];
            [alt show];
            return;
            
        }
        //     获取HTML数据，使用Xparse解析，引入第三方框架Hpple
        NSString *strData = [[NSString alloc] initWithData:data encoding:enc];
        NSData *endata = [strData dataUsingEncoding:NSUTF8StringEncoding];
        //        由于TFHpple解析只能解析UTF－8信息，对原来的GBK编码进行UTF－8重新编码
        TFHpple *doc = [[TFHpple alloc] initWithHTMLData:endata];
        //        获取table节点 其中的class属性未style6 为纯课表HTML代码
        NSArray *elements = [doc searchWithXPathQuery:@"//table[@class='style6']"];
        if ([elements count]) {
            //            得到第一个节点的信息，课表一般来说只有一个
            TFHppleElement *element = [elements objectAtIndex:0];
            //            声明一个动态数组，存储不同时长的课程信息，方便之后获取开始的时间（结束减去持续时间，通过rowspan）
            NSMutableArray *courseLast = [[NSMutableArray alloc]init];
            //
            courses = [[NSMutableArray alloc]init];
            for (int i = 1; i<=8; i++) {
                //                课程一般不超过8节吧 ：）
                NSArray *course = [element searchWithXPathQuery:[NSString stringWithFormat:@"//tr//td[@rowspan='%d']",i]];
                //                对不同的rowspan值进行分组存储
                [courseLast addObject:course];
            }
            //            可是又一个问题来了，课程只有一节课怎么办呢，只好重新获取咯，因为课程只有一节没有rowspan属性
            NSArray *courseall = [element searchWithXPathQuery:@"//tr//td"];
            //            获取所有表格节点
            for (int i = 0 ; i<[courseall count]; i++) {
                //                对每个节点查找
                TFHppleElement *temp = [courseall objectAtIndex:i];
                //                如果是有rowspan属性，就不用操作啦
                NSString *a = [[temp attributes]objectForKey:@"rowspan"];
                //                获取内容 单元格
                NSArray *b = [temp searchWithXPathQuery:@"//span"];
                if ([b count]&&a==nil) {
                    //                    如果b有span节点就不是表头啦，而且不是刚才解析的超过2节课
                    TFHppleElement *isExit =  [b objectAtIndex:0];
                    //                    接下来判断那个是不是第一节第二节之类的信息，把它删掉删掉
                    if (![[isExit content] isEqualToString:@""]&&![[isExit content]containsString:@"第"]) {
                        //                        存的就是只上一节课的信息咯
                        [[courseLast objectAtIndex:0]addObject:temp];
                    }
                }
            }
            //            通过对课时来存储的数组，cost表示上课时间长度
            int cost = 0;
            for (NSArray *obj in courseLast ) {
                if (obj.count!=0) {
                    for (TFHppleElement *courseEle in obj) {
                        NSArray *courseName = [courseEle searchWithXPathQuery:@"//span"];
                        TFHppleElement *temp = [courseName objectAtIndex:0];
                        NSString *courseInfo=[temp content];
                        NSDictionary *attr = [temp attributes];
                        NSString *time = [attr objectForKey:@"id"];
                        NSArray *timeinfo = [time componentsSeparatedByString:@"_"];
                        NSArray *arr = [courseInfo componentsSeparatedByString:@"/"];
                        NSString *pureNumbers = [[timeinfo[3] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
                        NSInteger end = [pureNumbers integerValue];
                        if (cost == 0) {
                            end = end - 1;
                            pureNumbers = [NSString stringWithFormat:@"%ld",(long)end];
                        }
                        NSInteger start = end - cost;
                        NSString *starttimeValue = [NSString stringWithFormat:@"%ld",(long)start];
                        NSDictionary *dic ;
                        NSString *placeandtime = [NSString stringWithFormat:@"%@第%@~%@节",arr[1],starttimeValue,pureNumbers];
                        if (arr.count ==4) {
                            dic = [NSDictionary dictionaryWithObjectsAndKeys:arr[0],@"课程",placeandtime,@"时间地点",arr[2],@"地点",arr[3],@"老师",[[timeinfo[4] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""],@"上课星期",pureNumbers,@"停止时间",starttimeValue,@"开始时间",   nil];
                        }
                        else if (arr.count ==3 )
                        {
                            dic = [NSDictionary dictionaryWithObjectsAndKeys:arr[0],@"课程",placeandtime,@"时间地点",@"",@"地点",arr[2],@"老师",[[timeinfo[4] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""],@"上课星期",pureNumbers,@"停止时间",starttimeValue,@"开始时间",   nil];
                        }else{
                            dic = [NSDictionary dictionaryWithObjectsAndKeys:arr[0],@"课程",placeandtime,@"时间地点",@"",@"地点",@"",@"老师",[[timeinfo[4] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""],@"上课星期",pureNumbers,@"停止时间",starttimeValue,@"开始时间",   nil];
                        }
                        if ([courses count]) {
                            NSString *obj1 = [[courses objectAtIndex:0]objectForKey:@"停止时间"];
                            if (pureNumbers.intValue < obj1.intValue) {
                                [courses insertObject:dic atIndex:0];
                            }else{
                                [courses addObject:dic];
                            }
                        }else{
                            [courses addObject:dic];
                        }
                    }
                }
                cost++;
            }
            CourseViewController *lvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Course"];
            lvc.coursearr = courses;
            [HUD hide:YES afterDelay:2];
            [self.navigationController pushViewController:lvc animated:YES];
        }
        else{
            [HUD hide:YES];
            HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.delegate = self;
            HUD.labelText = @"没有该学期的课程信息";
            [HUD show:YES];
            [HUD hide:YES afterDelay:2];
        }
    }];
    [dataRequesting resume];
    
}


- (void) getscore{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"查询成功";
    [HUD show:YES];
    
    
    NSURL *URL=[NSURL URLWithString:@"http://www.ycjw.zjut.edu.cn//stdgl/cxxt/cjcx/Cjcx_Xsgrcj.aspx"];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;
    request.HTTPMethod=@"POST";
    NSMutableString *req = [[NSMutableString alloc]initWithString:@"__EVENTTARGET=&__EVENTARGUMENT=&__VIEWSTATE=dDw4Mjc4OTE1MTQ7dDw7bDxpPDE%2BOz47bDx0PDtsPGk8NT47aTw3PjtpPDk%2BO2k8MTM%2BO2k8MTc%2BO2k8MzU%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOWtpuWPt%2B%2B8mjIwMTMyNjgxMTMwNTs%2BPjs%2BOzs%2BO3Q8cDxwPGw8VGV4dDs%2BO2w85aeT5ZCN77ya5LiB5pmo5YWJOz4%2BOz47Oz47dDxwPHA8bDxUZXh0Oz47bDznj63nuqfvvJrorqHnrpfmnLrlrp7pqoznj60xMzAxOz4%2BOz47Oz47dDx0PDt0PGk8NDM%2BO0A8XGU777yd5omA5pyJ5a2m5pyf77ydOzE5OTkvMjAwMCgxKTsxOTk5LzIwMDAoMik7MjAwMC8yMDAxKDEpOzIwMDAvMjAwMSgyKTsyMDAxLzIwMDIoMSk7MjAwMS8yMDAyKDIpOzIwMDIvMjAwMygxKTsyMDAyLzIwMDMoMik7MjAwMy8yMDA0KDEpOzIwMDMvMjAwNCgyKTsyMDA0LzIwMDUoMSk7MjAwNC8yMDA1KDIpOzIwMDUvMjAwNigxKTsyMDA1LzIwMDYoMik7MjAwNi8yMDA3KDEpOzIwMDYvMjAwNygyKTsyMDA3LzIwMDgoMSk7MjAwNy8yMDA4KDIpOzIwMDgvMjAwOSgxKTsyMDA4LzIwMDkoMik7MjAwOS8yMDEwKDEpOzIwMDkvMjAxMCgyKTsyMDEwLzIwMTEoMSk7MjAxMC8yMDExKDIpOzIwMTEvMjAxMigxKTsyMDExLzIwMTIoMik7MjAxMi8yMDEzKDEpOzIwMTIvMjAxMygyKTsyMDk4LzIwOTkoMSk7MjAxMy8yMDE0KDEpOzIwMTMvMjAxNCgyKTsyMDE0LzIwMTUoMSk7MjAxNC8yMDE1KDIpOzIwMTUvMjAxNigxKTsyMDE1LzIwMTYoMik7MjAxNi8yMDE3KDEpOzIwMTYvMjAxNygyKTsyMDE3LzIwMTgoMSk7MjAxNy8yMDE4KDIpOzIwMTgvMjAxOSgxKTsyMDE4LzIwMTkoMik7PjtAPFxlO%2B%2B8neaJgOacieWtpuacn%2B%2B8nTsxOTk5LzIwMDAoMSk7MTk5OS8yMDAwKDIpOzIwMDAvMjAwMSgxKTsyMDAwLzIwMDEoMik7MjAwMS8yMDAyKDEpOzIwMDEvMjAwMigyKTsyMDAyLzIwMDMoMSk7MjAwMi8yMDAzKDIpOzIwMDMvMjAwNCgxKTsyMDAzLzIwMDQoMik7MjAwNC8yMDA1KDEpOzIwMDQvMjAwNSgyKTsyMDA1LzIwMDYoMSk7MjAwNS8yMDA2KDIpOzIwMDYvMjAwNygxKTsyMDA2LzIwMDcoMik7MjAwNy8yMDA4KDEpOzIwMDcvMjAwOCgyKTsyMDA4LzIwMDkoMSk7MjAwOC8yMDA5KDIpOzIwMDkvMjAxMCgxKTsyMDA5LzIwMTAoMik7MjAxMC8yMDExKDEpOzIwMTAvMjAxMSgyKTsyMDExLzIwMTIoMSk7MjAxMS8yMDEyKDIpOzIwMTIvMjAxMygxKTsyMDEyLzIwMTMoMik7MjA5OC8yMDk5KDEpOzIwMTMvMjAxNCgxKTsyMDEzLzIwMTQoMik7MjAxNC8yMDE1KDEpOzIwMTQvMjAxNSgyKTsyMDE1LzIwMTYoMSk7MjAxNS8yMDE2KDIpOzIwMTYvMjAxNygxKTsyMDE2LzIwMTcoMik7MjAxNy8yMDE4KDEpOzIwMTcvMjAxOCgyKTsyMDE4LzIwMTkoMSk7MjAxOC8yMDE5KDIpOz4%2BOz47Oz47dDx0PDt0PGk8Mjk%2BO0A8XGU777yd5omA5pyJ5a2m5bm077ydOzE5OTkvMjAwMDsyMDAwLzIwMDE7MjAwMS8yMDAyOzIwMDIvMjAwMzsyMDAzLzIwMDQ7MjAwNC8yMDA1OzIwMDUvMjAwNjsyMDA2LzIwMDc7MjAwNy8yMDA4OzIwMDgvMjAwOTsyMDA5LzIwMTA7MjAxMC8yMDExOzIwMTEvMjAxMjsyMDEyLzIwMTM7MjAxMy8yMDE0OzIwMTQvMjAxNTsyMDE1LzIwMTY7MjAxNi8yMDE3OzIwMTcvMjAxODsyMDE4LzIwMTk7MjAxOS8yMDIwOzIwMjAvMjAyMTsyMDIxLzIwMjI7MjAyMi8yMDIzOzIwMjMvMjAyNDsyMDI0LzIwMjU7MjA5OC8yMDk5Oz47QDxcZTvvvJ3miYDmnInlrablubTvvJ07MTk5OS8yMDAwOzIwMDAvMjAwMTsyMDAxLzIwMDI7MjAwMi8yMDAzOzIwMDMvMjAwNDsyMDA0LzIwMDU7MjAwNS8yMDA2OzIwMDYvMjAwNzsyMDA3LzIwMDg7MjAwOC8yMDA5OzIwMDkvMjAxMDsyMDEwLzIwMTE7MjAxMS8yMDEyOzIwMTIvMjAxMzsyMDEzLzIwMTQ7MjAxNC8yMDE1OzIwMTUvMjAxNjsyMDE2LzIwMTc7MjAxNy8yMDE4OzIwMTgvMjAxOTsyMDE5LzIwMjA7MjAyMC8yMDIxOzIwMjEvMjAyMjsyMDIyLzIwMjM7MjAyMy8yMDI0OzIwMjQvMjAyNTsyMDk4LzIwOTk7Pj47Pjs7Pjt0PEAwPDs7Ozs7Ozs7Ozs%2BOzs%2BOz4%2BOz4%2BO2w8cmJ0blhxO3JidG5YbjtyYnRuWG47Pj7i0%2FuKe8XkozqfBPprZW0P6I13pg%3D%3D&1=rbtnXq&ddlXq="];
    [req appendString:[NSString stringWithFormat:@"%d",year]];
    [req appendString:@"%2F"];
    [req appendString:[NSString stringWithFormat:@"%d",year+1]];
    [req appendString:@"%28"];
    [req appendString:[NSString stringWithFormat:@"%d",term]];
    [req appendString:@"%29&Button1=%C6%D5%CD%A8%BF%BC%CA%D4%B3%C9%BC%A8%B2%E9%D1%AF"];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[req dataUsingEncoding:enc];
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:33.0) Gecko/20100101 Firefox/33.0" forHTTPHeaderField:@"User-Agent"];
    NSURLSessionDataTask * dataRequesing =[self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        if (connectionError)
        {
            [HUD hide:YES];
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"错误提示"
                                                         message:connectionError.localizedDescription
                                                        delegate:nil
                                               cancelButtonTitle:@"确认"
                                               otherButtonTitles:nil];
            [alt show];
            return;
            
        }
        NSString *strData = [[NSString alloc] initWithData:data encoding:enc];
        NSData *endata = [strData dataUsingEncoding:NSUTF8StringEncoding];
        TFHpple *doc = [[TFHpple alloc] initWithHTMLData:endata];
        NSArray *elements = [doc searchWithXPathQuery:@"//table[@id='DataGrid1']"];
        TFHppleElement *element = [elements objectAtIndex:0];
        scores = [[NSMutableArray alloc]init];
        NSArray *course = [element searchWithXPathQuery:@"//tr"];
        NSArray *arrinfo = [NSArray arrayWithObjects:@"实际学期",@"执行课程名称",@"考试性质",@"成绩",@"学时",@"学分", nil];
        for (TFHppleElement *obj in course) {
            NSArray *scoreinfo = [obj searchWithXPathQuery:@"//td"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            int i =0;
            for (TFHppleElement *obj in scoreinfo) {
                if ([[obj content]isEqualToString:@"实际学期"]) {
                    break;
                }
                [dic setObject:[obj content] forKey:arrinfo[i++]];
            }
            [scores addObject:dic];
        }
        NSRange range1 = [_uinfo rangeOfString:@"("];
        NSRange range2 = [_uinfo rangeOfString:@")"];
        NSString *names = [_uinfo substringWithRange:NSMakeRange(range1.location+1, range2.location-range1.location-1)];
        
        ScoreViewController *lvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Score"];
        lvc.scorearr = scores;
        lvc.username = names;
        [HUD hide:YES afterDelay:2];
        [self.navigationController pushViewController:lvc animated:YES];
    }];
    [dataRequesing resume];
    
}
#pragma mark PickerView&PickerVireDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [yeararr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *startyear = [[yeararr objectAtIndex:row]objectForKey:@"startyear"];
    NSInteger add = [startyear integerValue]+1;
    NSString *termstr = [[yeararr objectAtIndex:row]objectForKey:@"term"];
    return [NSString stringWithFormat:@"%@/%ld(%@)",startyear,(long)add,termstr];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    year = [[[yeararr objectAtIndex:row]objectForKey:@"startyear"]intValue];
    term = [[[yeararr objectAtIndex:row]objectForKey:@"term"]intValue];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] init];
    label.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    return label;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
