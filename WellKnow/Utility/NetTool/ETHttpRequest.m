//
//  ETHttpRequest.m
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "ETHttpRequest.h"
#import "AFHTTPRequestOperationManager.h"
#import "ETRequestManager.h"

@implementation ETHttpRequest{
    NSString *_requestString;
}


+ (ETHttpRequest *)requestWithUrlString:(NSString *)urlString requestType:(HttpRequestType)requestType params:(NSDictionary *)params finised:(httpFinisheBlock)finishedBlock failed:(httpFailedBlock)failedBlock{
    return [self requestWithUrlString:urlString requestType:requestType params:params usingCache:NO finised:finishedBlock failed:failedBlock];
}

+ (ETHttpRequest *)requestWithUrlString:(NSString *)urlString requestType:(HttpRequestType)requestType params:(NSDictionary *)params usingCache:(BOOL)cached finised:(httpFinisheBlock)finishedBlock failed:(httpFailedBlock)failedBlock{
    ETHttpRequest *request = [[ETHttpRequest alloc]init];
//    使用缓存策略
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (cached) {
        if ([fm  fileExistsAtPath:[ETRequestManager filePathForUrl:urlString]]) {
            NSData *data = [NSData dataWithContentsOfFile:[ETRequestManager filePathForUrl:urlString]];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            finishedBlock(dic);
            return request;
        }
    }
    
    if (HttpRequestTypeGET == requestType) {
        [request getWithUrlString:urlString params:params finished:finishedBlock failed:failedBlock];
    }else{
        [request postWithUrlString:urlString params:params finished:finishedBlock failed:failedBlock];
    }
    
    return request;
}



- (void)getWithUrlString:(NSString *)urlString params:(NSDictionary *)params finished:(httpFinisheBlock)finish failed:(httpFailedBlock)failed{
    _requestString = urlString;
    [[AFHTTPRequestOperationManager manager]GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self writeToCache:responseObject];
        finish(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failed(error);
    }];
}

- (void)postWithUrlString:(NSString *)urlString params:(NSDictionary *)params finished:(httpFinisheBlock)finish failed:(httpFailedBlock)failed{
    [[AFHTTPRequestOperationManager manager]POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self writeToCache:responseObject];
        finish(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failed(error);
    }];
}

- (void)writeToCache:(id)obj{
    NSData *data ;
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        data = [str dataUsingEncoding:NSUTF8StringEncoding];
    }else {
        data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    
    [data writeToFile:[ETRequestManager filePathForUrl:_requestString] atomically:YES];
}


@end
