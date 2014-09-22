//
//  UIViewController+NavigationItemSettingTool.m
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "UIViewController+NavigationItemSettingTool.h"

@implementation UIViewController (NavigationItemSettingTool)

//设置titleView
- (void)setNavgationBarTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,40)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Arial" size:22];
    self.navigationItem.titleView = label;
}
//设置Item
- (void)setNavigationItemWithText:(NSString *)title imageName:(NSString *)imageName selector:(SEL)selector onLeft:(BOOL)isLeft{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0,0,40,40)];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    if (isLeft == YES) {
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        item2.width = -15;
        self.navigationItem.leftBarButtonItems = @[item2,item];
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)addSimpleNavigationBackButton{
    [self setNavigationItemWithText:@"" imageName:@"returnBtn.png" selector:@selector(navigationBackButtonClicked:) onLeft:YES];
}

- (void)navigationBackButtonClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
