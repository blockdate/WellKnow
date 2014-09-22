//
//  ETUserInfo.m
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "ETUserInfo.h"

@implementation ETUserInfo

static ETUserInfo *sharedInfo;
+ (ETUserInfo *)sharedUserInfo{
    if (nil == sharedInfo) {
        sharedInfo = [[ETUserInfo alloc]init];
    }
    return sharedInfo;
}

- (id)init{
    if (self = [super init]) {
        sharedInfo = self;
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *settingDic = [defaults valueForKey:@"setting"];
        if (settingDic) {
            
        }else{
            
        }
    }
    return self;
}

- (void)save{
}

@end
