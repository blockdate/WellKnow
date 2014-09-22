//
//  ETHttpRequest.h
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HttpRequestType) {
    HttpRequestTypeGET,
    HttpRequestTypePost
};

typedef void(^httpFinisheBlock)(id result);
typedef void(^httpFailedBlock)(id result);

@interface ETHttpRequest : NSObject

//默认直接访问网络，不采取缓存
+ (ETHttpRequest *)requestWithUrlString:(NSString *)urlString requestType:(HttpRequestType)requestType params:(NSDictionary *)params finised:(httpFinisheBlock)finishedBlock failed:(httpFailedBlock)failedBlock ;

//是否使用缓存策略，采用时，若存在缓存则不访问网络
+ (ETHttpRequest *)requestWithUrlString:(NSString *)urlString requestType:(HttpRequestType)requestType params:(NSDictionary *)params usingCache:(BOOL)cached finised:(httpFinisheBlock)finishedBlock failed:(httpFailedBlock)failedBlock ;

@end
