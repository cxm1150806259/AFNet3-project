//
//  MKAccountService.m
//  AFNetwork-project
//
//  Created by Xianmin Chen on 2018/8/1.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "MKAccountService.h"
#import "GlobalAppDefines.h"
@implementation MKAccountService
+(instancetype)sharedService
{
    static MKAccountService *accountService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        accountService = [[MKAccountService alloc] init];
        
    });
    return accountService;
}

#pragma mark --获取验证码
-(void)getCode:(NSString *)phone codeID:(NSString *)code_type_id success:(void (^)(NSString *code,NSString *msg,NSString *status))success failure:(void (^)(MKServiceStatus serviceCode, NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:code_type_id forKey:@"code_type_id"];
    
    [AFNetworkClient postWithPath:@"tools/2.0/get_mobile_code" params:params success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary *requestBodyInfo) {
        MKHandleBlock(success,[requestBodyInfo objectForKey:@"code"],[requestBodyInfo objectForKey:@"msg"],[requestBodyInfo objectForKey:@"status"]);
    } failure:^(MKServiceStatus serviceCode, NSURLSessionDataTask *task, NSError *error) {
        MKHandleBlock(failure,serviceCode,task,error);
    }];
}
@end
