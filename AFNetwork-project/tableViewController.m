//
//  tableViewController.m
//  AFNetwork-project
//
//  Created by Xianmin Chen on 2018/8/8.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "tableViewController.h"

@interface tableViewController ()

@end

@implementation tableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.title  = @"我的表格";
}

#pragma mark 载入一些数据，用于显示在UITableView上
-(void)loadData{
    //初始化数组
    self.tableDataArr = [NSMutableArray array];
    //加入20个字符串到数组中
    for(int i = 0;i <20;i++){
        [self.tableDataArr addObject:[NSString stringWithFormat:@"table item%i",i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 实现UITableViewDataSource中的两个方法
#pragma mark 该方法返回UITableView中的item个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableDataArr count];
}

#pragma mark 该方法返回UITableView中每一个单元格，在这里处理每一个单元格中该显示什么数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    //从队列中取出单元格
    UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //为单元格的label设置数据
    cell.textLabel.text = [self.tableDataArr objectAtIndex:indexPath.row];
    return cell;
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
