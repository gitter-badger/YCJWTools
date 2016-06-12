//
//  ScoreTableViewCell.h
//  MyApplication
//
//  Created by DwightDing on 16/6/11.
//  Copyright © 2016年 Ding Chenguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *classname;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *point;
@property (weak, nonatomic) IBOutlet UILabel *evalue;

@end
