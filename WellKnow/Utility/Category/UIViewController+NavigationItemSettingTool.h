//
//  UIViewController+NavigationItemSettingTool.h
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationItemSettingTool)
//设置titleView
- (void)setNavgationBarTitle:(NSString *)title;
//设置Item
- (void)setNavigationItemWithText:(NSString *)title imageName:(NSString *)imageName selector:(SEL)selector onLeft:(BOOL)isLeft;

- (void)addSimpleNavigationBackButton;
@end
