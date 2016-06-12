//
//  ScoreViewController.m
//  MyApplication
//
//  Created by DwightDing on 16/6/11.
//  Copyright © 2016年 Ding Chenguang. All rights reserved.
//

#import "ScoreViewController.h"
#import "ScoreTableViewCell.h"

@interface ScoreViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float allscore;
    float ave;
}
@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma 界面设置
- (void) initview{
    self.title = @"成绩查询";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    allscore = 0;
    ave = 0;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
}

#pragma UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.scorearr count]-1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scorecell"];
    if(nil == cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ScoreTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.classname.text = [[_scorearr objectAtIndex:indexPath.row+1] objectForKey:@"执行课程名称"];
    cell.score.text  = [[_scorearr objectAtIndex:indexPath.row+1] objectForKey:@"成绩"];
    cell.point.text  = [[_scorearr objectAtIndex:indexPath.row+1] objectForKey:@"学分"];
    if ([cell.score.text isEqualToString:@"优秀"]) {
        allscore +=95 * [cell.point.text floatValue];
        ave += [cell.point.text floatValue];
        cell.evalue.text = @"优秀👍";
    }else if ([cell.score.text isEqualToString:@"良好"]) {
        allscore +=85 * [cell.point.text floatValue];
        ave += [cell.point.text floatValue];
        cell.evalue.text = @"良好👏";
    }else if ([cell.score.text isEqualToString:@"中等"]) {
        allscore +=75 * [cell.point.text floatValue];
        ave += [cell.point.text floatValue];
        cell.evalue.text = @"中等💪";
    }else if ([cell.score.text isEqualToString:@"及格"]) {
        allscore +=60 * [cell.point.text floatValue];
        ave += [cell.point.text floatValue];
        cell.evalue.text = @"及格🙏";
    }else{
        allscore += [cell.score.text floatValue] * [cell.point.text floatValue];
        ave += [cell.point.text floatValue];
        if ([cell.score.text floatValue]>=90) {
            cell.evalue.text = @"优秀👍";
        }else if ([cell.score.text floatValue]>=80) {
            cell.evalue.text = @"良好👏";
        }else if ([cell.score.text floatValue]>=70) {
            cell.evalue.text = @"中等💪";
        }else if ([cell.score.text floatValue]>=60) {
            cell.evalue.text = @"及格🙏";
        }else{
            cell.evalue.text = @"不及格😂";
        }
    }
    
    tableView.rowHeight = cell.frame.size.height;
    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title;
    title =[NSString stringWithFormat:@"亲爱的 %@ 你本学期绩点：%.3f",self.username,allscore?(allscore/ave-50)/10:0];
    return title;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *term = [[_scorearr objectAtIndex:indexPath.row+1] objectForKey:@"实际学期"];
    NSString *name = [[_scorearr objectAtIndex:indexPath.row+1] objectForKey:@"执行课程名称"];
    NSString *proper = [[_scorearr objectAtIndex:indexPath.row+1] objectForKey:@"考试性质"];
    NSString *score = [[_scorearr objectAtIndex:indexPath.row+1] objectForKey:@"成绩"];
    NSString *time = [[_scorearr objectAtIndex:indexPath.row+1] objectForKey:@"学时"];
     NSString *sscore = [[_scorearr objectAtIndex:indexPath.row+1] objectForKey:@"学分"];
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"详情"
                                                 message:[NSString stringWithFormat:@"实际学期：%@\n执行课程名称：%@\n考试性质：%@\n成绩：%@\n学时：%@\n学分：%@",term,name,proper,score,time,sscore]
                                                delegate:nil
                                       cancelButtonTitle:@"确认"
                                       otherButtonTitles:nil];
    [alt show];
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
