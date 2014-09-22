//
//  ETSettingInfo.h
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETSettingInfo : NSObject

@property (nonatomic, assign) BOOL usingNightModel;
@property (nonatomic, assign) BOOL loadingImageOnlyWifi;
@property (nonatomic, assign) NSInteger textSize;
@property (nonatomic, assign) NSTimeInterval cacheEffectTime;

+ (ETSettingInfo *)sharedSettingInfo;
- (void)save;
@end
