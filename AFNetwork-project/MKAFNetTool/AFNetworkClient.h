//
//  AFNetworkClient.h
//  AFNetwork-project
//
//  Created by Xianmin Chen on 2018/8/1.
//  Copyright © 2018年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "GlobalAppDefines.h"

#ifdef DEBUG
#   define TBJHttpLog(fmt, ...)            NSLog((fmt), ##__VA_ARGS__);
#else
#   define TBJHttpLog(...)
#endif

#define kBaseUrl @"http://japi.waterever.cn:8099/"
typedef NS_ENUM(NSInteger, MKServiceStatus) {
    kTBJServiceStatusNormal = 0,                            // 正常返回
    kTBJServiceStatusDataEmpty = 1,                         // 接口数据为空
    kTBJServiceStatusJSONDataError = 2,                     // 接口数据JSON格式错误
    kTBJServiceStatusOther                                  // 其他错误
};

typedef void(^HttpSuccessBlock)(NSURLSessionDataTask *task,NSDictionary *requestBodyInfo);
typedef void(^HttpFailureBlock)(MKServiceStatus serviceCode, NSURLSessionDataTask *requestOP, NSError *error);
typedef void(^HttpDownloadProgressBlock)(CGFloat progress);
typedef void(^HttpUploadProgressBlock)(CGFloat progress);
typedef void(^HttpSuccessBlock2)(id json);
typedef void(^HttpFailureBlock2)(NSError *error);


typedef NS_ENUM(NSUInteger, HTTPMethod) {
    
    HTTPMethodGET,
    HTTPMethodPOST,
    HTTPMethodPUT,
    HTTPMethodPATCH,
    HTTPMethodDELETE,
};

@interface AFNetworkClient : NSObject

/**
 get网络请求
 
 @param path url地址
 @param params url参数 NSDictionary类型
 @param success 请求成功 返回NSDictionary或NSArray
 @param failure 请求失败 返回NSError
 */
+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;

/**
 post网络请求
 
 @param path url地址
 @param params url参数 NSDictionary类型
 @param success 请求成功 返回NSDictionary或NSArray
 @param failure 请求失败 返回NSError
 */
+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;

/**
 下载文件
 
 @param path url路径
 @param success 下载成功
 @param failure 下载失败
 @param progress 下载进度
 */
+ (void)downloadWithPath:(NSString *)path
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
                progress:(HttpDownloadProgressBlock)progress;

/**
 上传图片
 
 @param path url地址
 @param image UIImage对象
 @param thumbName imagekey
 @param params 上传参数
 @param success 上传成功
 @param failure 上传失败
 @param progress 上传进度
 */
+ (void)uploadImageWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)thumbName
                      image:(UIImage *)image
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress;

@end
