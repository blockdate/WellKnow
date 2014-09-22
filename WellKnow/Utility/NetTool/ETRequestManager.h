//
//  ETRequestManager.h
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETHttpRequest.h"



@interface ETRequestManager : NSObject

+ (ETRequestManager *)sharedManager;
//请求网络使用默认策略，判断缓存时间
- (ETHttpRequest *)requestWithUrlString:(NSString *)urlString requestType:(HttpRequestType)requestType params:(NSDictionary *)params finised:(httpFinisheBlock)finishedBlock failed:(httpFailedBlock)failedBlock;

//可设置请求网络使用缓存策略，使用缓存策略时有缓存绝不使用网络
- (ETHttpRequest *)requestWithUrlString:(NSString *)urlString requestType:(HttpRequestType)requestType params:(NSDictionary *)params showWaitDialog:(BOOL)showDialog finised:(httpFinisheBlock)finishedBlock failed:(httpFailedBlock)failedBlock;

- (ETHttpRequest *)requestUsingCache:(BOOL)cached TargetWithUrlString:(NSString *)urlString requestType:(HttpRequestType)requestType params:(NSDictionary *)params showWaitDialog:(BOOL)showDialog finised:(httpFinisheBlock)finishedBlock failed:(httpFailedBlock)failedBlock;

//获取指定url缓存目录
+ (NSString *)filePathForUrl:(NSString *)urlString;
//获取网络缓存路径
+ (NSString *)filePathForCache;
//清除指定目录下的缓存
+ (void)clearCacheForUrl:(NSString *)str;
//清空缓存
+ (void)clearCache;
@end
