//
//  ViewController.m
//  AFNetwork-project
//
//  Created by Xianmin Chen on 2018/8/1.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "ViewController.h"
#import "MKAccountService.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[MKAccountService sharedService] getCode:@"15058499375" codeID:@"1" success:^(NSString *code, NSString *msg, NSString *status) {
        if (code == 0) {
            NSLog(@"发送成功");
        }
    } failure:^(MKServiceStatus serviceCode, NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"发送失败");
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
