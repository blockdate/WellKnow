//
//  NewsNormalModel.m
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "NewsNormalModel.h"
#import "WMString-Utilities.h"

@implementation NewsNormalModel

- (NSString *)currectTime{
    if (_pubDate) {
        NSDate *dat = [NSDate dateWithTimeInterval:[_pubDate floatValue] sinceDate:[NSDate dateWithTimeIntervalSince1970:0]];
        NSString *dataString = [NSString stringWithFormat:@"%@",dat];
        return [NSString stringFromCurrent:dataString];
    }
    return @"";
}

- (NSString *)qreply{
    NSNumber *qreplyNum = [_comment_count_info objectForKey:@"qreply"];
    return [qreplyNum stringValue];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end
