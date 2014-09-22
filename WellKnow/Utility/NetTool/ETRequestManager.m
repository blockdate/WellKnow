//
//  ETRequestManager.m
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "ETRequestManager.h"
#import "ETSettingInfo.h"
#import "NSFileManager+pathMethod.h"
#import "SVProgressHUD.h"
#import "NSString+Hashing.h"
@implementation ETRequestManager{
    NSMutableDictionary *_requestDic;
}

static ETRequestManager *manager;
+ (ETRequestManager *)sharedManager{
    if (nil == manager) {
        manager = [[ETRequestManager alloc]init];
    }
    return manager;
}

- (id)init{
    if (self = [super init]) {
        _requestDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (ETHttpRequest *)requestWithUrlString:(NSString *)urlString requestType:(HttpRequestType)requestType params:(NSDictionary *)params finised:(httpFinisheBlock)finishedBlock failed:(httpFailedBlock)failedBlock{
    return [self requestWithUrlString:urlString requestType:requestType params:params showWaitDialog:YES finised:finishedBlock failed:failedBlock];
}

- (ETHttpRequest *)requestWithUrlString:(NSString *)urlString requestType:(HttpRequestType)requestType params:(NSDictionary *)params showWaitDialog:(BOOL)showDialog finised:(httpFinisheBlock)finishedBlock failed:(httpFailedBlock)failedBlock{
    return [self requestUsingCache:NO TargetWithUrlString:urlString requestType:requestType params:params showWaitDialog:showDialog finised:finishedBlock failed:failedBlock];
}

- (void)cacheRequest:(httpFailedBlock)faile finish:(httpFinisheBlock)finish params:(NSDictionary *)params requestType:(HttpRequestType)requestType urlString:(NSString *)urlString request_p:(ETHttpRequest **)request_p {
    //            尝试直接从本地缓存获取数据
    *request_p = [ETHttpRequest requestWithUrlString:urlString requestType:requestType params:params usingCache:YES finised:finish failed:faile];
}

- (void)normalRequest:(httpFailedBlock)faile finish:(httpFinisheBlock)finish params:(NSDictionary *)params requestType:(HttpRequestType)requestType urlString:(NSString *)urlString request_p:(ETHttpRequest **)request_p ettingInfo:(ETSettingInfo *)ettingInfo {
    //        本地数据已过期，直接获取网络数据
    if ([NSFileManager isTimeOutWithPath:[ETRequestManager filePathForUrl:urlString] time:ettingInfo.cacheEffectTime]) {
        *request_p = [ETHttpRequest requestWithUrlString:urlString requestType:requestType params:params finised:finish failed:faile];
        [_requestDic setObject:*request_p forKey:urlString];
    }else{
        //            本地数据未过期，尝试从本地缓存获取数据
        *request_p = [ETHttpRequest requestWithUrlString:urlString requestType:requestType params:params usingCache:YES finised:finish failed:faile];
    }
}

- (void)dataPrepare:(NSString *)urlString finishedBlock:(httpFinisheBlock)finishedBlock failedBlock:(httpFailedBlock)failedBlock request_p:(ETHttpRequest **)request_p finish_p:(httpFinisheBlock *)finish_p faile_p:(httpFailedBlock *)faile_p {
    *request_p = [_requestDic objectForKey:urlString];
    
    *finish_p = ^(id result){
        [_requestDic removeObjectForKey:urlString];
        [SVProgressHUD dismiss];
        finishedBlock(result);
    };
    
    *faile_p = ^(id result){
        [_requestDic removeObjectForKey:urlString];
        [SVProgressHUD dismiss];
        failedBlock(result);
    };
}

- (ETHttpRequest *)requestUsingCache:(BOOL)cached TargetWithUrlString:(NSString *)urlString requestType:(HttpRequestType)requestType params:(NSDictionary *)params showWaitDialog:(BOOL)showDialog finised:(httpFinisheBlock)finishedBlock failed:(httpFailedBlock)failedBlock{
    
    ETSettingInfo *settingInfo = [ETSettingInfo sharedSettingInfo];
    ETHttpRequest *request;
    httpFinisheBlock finish;
    httpFailedBlock faile;
    
    [self dataPrepare:urlString finishedBlock:finishedBlock failedBlock:failedBlock request_p:&request finish_p:&finish faile_p:&faile];
    
    if (showDialog) {
        [SVProgressHUD showWithStatus:@"数据请求中" maskType:SVProgressHUDMaskTypeClear];
    }
    
    if (nil == request) {
        if (cached) {
            [self cacheRequest:faile finish:finish params:params requestType:requestType urlString:urlString request_p:&request];
        }else{
            [self normalRequest:faile finish:finish params:params requestType:requestType urlString:urlString request_p:&request ettingInfo:settingInfo];
        }
    }
    return request;
}


+ (NSString *)filePathForUrl:(NSString *)urlString{
    NSString *path = [[self filePathForCache] stringByAppendingPathComponent:[urlString MD5Hash]];
    return path;
}

+ (NSString *)filePathForCache{
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/ETCache"];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

+ (void)clearCacheForUrl:(NSString *)str{
    [[NSFileManager defaultManager]removeItemAtPath:[self filePathForUrl:str] error:nil];
}

+ (void)clearCache{
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:[self filePathForCache] error:nil];
}

@end
