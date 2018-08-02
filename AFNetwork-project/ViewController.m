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
    
    //获取验证码
//    [[MKAccountService sharedService] getCode:@"15058499375" codeID:@"1" success:^(NSString *code, NSString *msg, NSString *status) {
//        if (code == 0) {
//            NSLog(@"发送成功");
//        }
//        else{
//            NSLog(@"%@",msg);
//        }
//    } failure:^(MKServiceStatus serviceCode, NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"发送失败");
//    }];
    
    //登录
//    [[MKAccountService sharedService] login:@"15058499375" pass:@"f379eaf3c831b04de153469d1bec345e" success:^(NSString *code, NSString *msg, NSString *status, MKPersonInfo *personInfo) {
//        if (code == 0) {
//            NSLog(@"%@",msg);
//        }else{
//            NSLog(@"code is not 0,msg is %@",msg);
//        }
//    } failure:^(MKServiceStatus serviceCode, NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"发送失败");
//    }];
    
    
    int val = 10;
    __block  void (^blk)(void) = ^{ printf("val = %d\n",val);};
    val = 2;
    blk();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
