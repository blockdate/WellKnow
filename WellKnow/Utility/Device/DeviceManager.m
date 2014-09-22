//
//  DeviceManager.m
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "DeviceManager.h"
#import "ETSettingInfo.h"


@implementation DeviceManager

DeviceManager *deviceManager;
+ (DeviceManager *)device{
    if (nil == deviceManager) {
        deviceManager = [[DeviceManager alloc]init];
    }
    return deviceManager;
}

+ (BOOL)isIOS7Device{
    return IsIOS7;
}

+ (CGFloat)screenHeight{
    return [UIScreen mainScreen].applicationFrame.size.height+20;
}

+ (NSInteger)deviceVersion{
    return [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue];
}

+ (NSInteger)systemTextSize{
    ETSettingInfo *settingInfo = [ETSettingInfo sharedSettingInfo];
    return settingInfo.textSize-2;
}

@end
