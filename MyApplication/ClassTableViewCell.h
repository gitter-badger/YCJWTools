//
//  ClassTableViewCell.h
//  MyApplication
//
//  Created by DwightDing on 16/6/12.
//  Copyright © 2016年 Ding Chenguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *classname;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *place;

@property (weak, nonatomic) IBOutlet UILabel *teacher;
@end
