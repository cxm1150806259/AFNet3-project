//
//  tableViewController.h
//  AFNetwork-project
//
//  Created by Xianmin Chen on 2018/8/8.
//  Copyright © 2018年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
//界面中的UITableView控件
@property (weak, nonatomic) IBOutlet UITableView *tableview;
//UITableView中的数据，用一个字符串数组来保存
@property (strong, nonatomic)NSMutableArray *tableDataArr;

@end
