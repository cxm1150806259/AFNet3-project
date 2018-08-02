//
//  AFNetworkClient.m
//  AFNetwork-project
//
//  Created by Xianmin Chen on 2018/8/1.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "AFNetworkClient.h"

#define kBaseUrl   @"http://japi.waterever.cn:8099/"

@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
@end

@implementation AFHttpClient
+(instancetype)sharedClient
{
    static AFHttpClient *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:configuration];
        // 接收参数类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/gif", nil];
        // 设置超时时间,默认60
        manager.requestSerializer.timeoutInterval = 15;
        // 安全策略
        manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    return manager;
}

@end
@implementation AFNetworkClient
+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    
    // 获取完整的url路径
    NSString *url = [kBaseUrl stringByAppendingPathComponent:path];
    
    [[AFHttpClient sharedClient] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary * responseData) {
        NSLog(@"%@", responseData);
        success(responseData);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) {
            TBJHttpLog(@"\n===================================\
                       \npath: %@\nparams: %@\
                       \n\U0001F621\U0001F621\U0001F621\U0001F621\U0001F621: %@\
                       \n===================================",
                       task.currentRequest.URL, (params ?: @""), [error localizedDescription]);
            MKHandleBlock(failure,kTBJServiceStatusJSONDataError,nil);
        }
        
        
    }];
}

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    
    // 获取完整的url路径
    NSString *url = [kBaseUrl stringByAppendingPathComponent:path];
    
    [[AFHttpClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask *task,NSDictionary * responseData) {
        NSLog(@"%@", responseData);
        success(responseData);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) {
            TBJHttpLog(@"\n===================================\
                       \npath: %@\nparams: %@\
                       \n\U0001F621\U0001F621\U0001F621\U0001F621\U0001F621: %@\
                       \n===================================",
                       task.currentRequest.URL, (params ?: @""), [error localizedDescription]);
            MKHandleBlock(failure,kTBJServiceStatusJSONDataError,nil);
        }
        
        
    }];
}

+ (void)downloadWithPath:(NSString *)path success:(HttpSuccessBlock2)success failure:(HttpFailureBlock2)failure progress:(HttpDownloadProgressBlock)progress {
    
    // 获取完整的url路径
    NSString *url = [kBaseUrl stringByAppendingPathComponent:path];
    
    // 下载
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        // 获取沙盒cache路径
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
//            MKHandleBlock(failure,filePath,error,response);
        } else {
            success(filePath.path);
//            MKHandleBlock(success,filePath.path,error);
        }
        
    }];
    
    [downloadTask resume];
}

+ (void)uploadImageWithPath:(NSString *)path params:(NSDictionary *)params thumbName:(NSString *)thumbName image:(UIImage *)image success:(HttpSuccessBlock2)success failure:(HttpFailureBlock2)failure progress:(HttpUploadProgressBlock)progress {
    
    // 获取完整的url路径
    NSString *url = [kBaseUrl stringByAppendingPathComponent:path];
    
    NSData *data = UIImagePNGRepresentation(image);
    
    [[AFHttpClient sharedClient] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:thumbName fileName:@"01.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}


@end
