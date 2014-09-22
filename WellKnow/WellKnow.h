//
//  WellKnow.h
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#ifndef WellKnow_WellKnow_h
#define WellKnow_WellKnow_h

#import "UIButton+ETTools.h"
#import "UIImageView+ETTools.h"
#import "UILabel+ETTools.h"
#import "UIViewController+NavigationItemSettingTool.h"
#import "NSString+Font.h"
#import "DeviceManager.h"
#define Debug 0
#if DEBUG
#define ETLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#else
#define ETLog(fmt, ...)
#endif

#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#define CGRECT_NO_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?20:0)), (w), (h))
#define CGRECT_HAVE_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?64:0)), (w), (h))

#define commentThemColor [UIColor colorWithPatternImage:[UIImage imageNamed:@"sports"]

#endif
