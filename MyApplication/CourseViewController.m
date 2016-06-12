//
//  CourseViewController.m
//  MyApplication
//
//  Created by DwightDing on 16/6/12.
//  Copyright © 2016年 Ding Chenguang. All rights reserved.
//

#import "CourseViewController.h"
#import "ClassTableViewCell.h"
@interface CourseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *week;
}
@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学期课表";
    week = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<7; i++) {
        NSMutableArray *day = [[NSMutableArray alloc]init];
        [week addObject:day];
    }
    for (NSDictionary *dic in  _coursearr) {
        NSString *XQ = [dic objectForKey:@"上课星期"];
        if(![XQ isEqualToString:@""])
        {
             [[week objectAtIndex:XQ.intValue-1]addObject:dic];
        }else{
             [[week objectAtIndex:0]addObject:dic];
        }
       

    }
    NSLog(@"");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [week count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[week objectAtIndex:section]count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"classcell"];
    if(nil == cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClassTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];

    }
    cell.classname.text = [[[week objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"课程"];
     cell.time.text = [[[week objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"时间地点"];
     cell.place.text = [[[week objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"地点"];
     cell.teacher.text = [[[week objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"老师"];
    tableView.rowHeight = cell.frame.size.height;
    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title;
    switch (section) {
        case 0:
            title = @"星期一";
            break;
        case 1:
            title = @"星期二";
            break;
        case 2:
            title = @"星期三";
            break;
        case 3:
            title = @"星期四";
            break;
        case 4:
            title = @"星期五";
            break;
        case 5:
            title = @"星期六";
            break;
        case 6:
            title = @"星期日";
            break;
        default:
            break;
    }
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]  animated:YES];
    
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
