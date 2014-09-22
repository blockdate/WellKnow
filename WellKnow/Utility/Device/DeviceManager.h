//
//  DeviceManager.h
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceManager : NSObject

+ (DeviceManager *)device;

+ (CGFloat)screenHeight;
+ (BOOL)isIOS7Device;
+ (NSInteger)deviceVersion;

+ (NSInteger)systemTextSize;
@end
