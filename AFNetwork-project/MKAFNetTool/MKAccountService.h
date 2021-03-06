//
//  MKAccountService.h
//  AFNetwork-project
//
//  Created by Xianmin Chen on 2018/8/1.
//  Copyright © 2018年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkClient.h"
@class MKPersonInfo;
@interface MKAccountService : NSObject
@property(nonatomic, strong) AFNetworkClient *client;

+ (instancetype)sharedService;
#pragma mark --获取验证码
-(void)getCode:(NSString *)phone codeID:(NSString *)code_type_id success:(void (^)(NSString *code,NSString *msg,NSString *status))success failure:(void (^)(MKServiceStatus serviceCode, NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark --登录
-(void)login:(NSString *)phone pass:(NSString *)password success:(void (^)(NSString *code,NSString *msg,NSString *status,MKPersonInfo *personInfo))success failure:(void (^)(MKServiceStatus serviceCode, NSURLSessionDataTask *task, NSError *error))failure;
@end
