//
//  MKPersonInfo.m
//  AFNetwork-project
//
//  Created by Xianmin Chen on 2018/8/2.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "MKPersonInfo.h"

@implementation MKPersonInfo

@end
@implementation NSDictionary (returnPersonInfo)
-(MKPersonInfo *) returnPersonInfo
{
    MKPersonInfo *personInfo = [[MKPersonInfo alloc] init];
    
    [personInfo setStatus:[self valueForKey:@"status"]];
    [personInfo setToken:[self valueForKey:@"token"]];
    [personInfo setPersonId:[self valueForKey:@"telePhone"]];
    [personInfo setBalance:[self valueForKey:@"balance"]];
    [personInfo setPersonTypeId:[self valueForKey:@"personTypeId"]];
    [personInfo setTokenLimitDate:[self valueForKey:@"tokenLimitDate"]];
    [personInfo setPersonAccount:[self valueForKey:@"personAccount"]];
    [personInfo setApplyDeviceId:[self valueForKey:@"applyDevicedId"]];
    return personInfo;
}
@end
