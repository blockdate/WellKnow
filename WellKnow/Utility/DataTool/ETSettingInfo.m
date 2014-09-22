//
//  ETSettingInfo.m
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "ETSettingInfo.h"

@implementation ETSettingInfo

static ETSettingInfo *sharedInfo;
+ (ETSettingInfo *)sharedSettingInfo{
    if (nil == sharedInfo) {
        sharedInfo = [[ETSettingInfo alloc]init];
    }
    return sharedInfo;
}

- (id)init{
    if (self = [super init]) {
        sharedInfo = self;
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *settingDic = [defaults valueForKey:@"setting"];
        if (settingDic) {
            sharedInfo.usingNightModel = [settingDic[@"usingNightModel"] boolValue];
            sharedInfo.loadingImageOnlyWifi = [settingDic[@"loadingImageOnlyWifi"] boolValue];
            sharedInfo.textSize = [settingDic[@"textSize"] integerValue];
            sharedInfo.cacheEffectTime = [settingDic[@"cacheEffectTime"]floatValue];
        }else{
            sharedInfo.usingNightModel = NO;
            sharedInfo.loadingImageOnlyWifi = NO;
            sharedInfo.textSize = 15;
            sharedInfo.cacheEffectTime = 60*60.0;
            [self save];
        }
    }
    return self;
}

- (void)save{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = @{@"usingNightModel":[NSNumber numberWithBool:self.usingNightModel],
                          @"loadingImageOnlyWifi":[NSNumber numberWithBool:self.loadingImageOnlyWifi],
                          @"textSize":[NSNumber numberWithBool:self.textSize],
                          @"cacheEffectTime":[NSNumber numberWithFloat:self.cacheEffectTime]};
    [defaults setObject:dic forKey:@"setting"];
    [defaults synchronize];
}
@end
