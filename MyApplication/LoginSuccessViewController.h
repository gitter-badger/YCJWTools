//
//  LoginSuccessViewController.h
//  MyApplication
//
//  Created by DwightDing on 16/6/10.
//  Copyright © 2016年 Ding Chenguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginSuccessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UIButton *score;
@property (weak, nonatomic) IBOutlet UIButton *classtable;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic) NSString *uinfo;
@property (nonatomic) NSURLSession *session;
@end
