//
//  MKPersonInfo.h
//  AFNetwork-project
//
//  Created by Xianmin Chen on 2018/8/2.
//  Copyright © 2018年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKPersonInfo : NSObject
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *personId;
@property (strong, nonatomic) NSString *telePhone;
@property (strong, nonatomic) NSString *balance;
@property (strong, nonatomic) NSString *personTypeId;
@property (strong, nonatomic) NSString *tokenLimitDate;
@property (strong, nonatomic) NSString *personAccount;
@property (strong, nonatomic) NSString *applyDeviceId;
@end
@interface NSDictionary (returnPersonInfo)
-(MKPersonInfo *) returnPersonInfo;
@end
