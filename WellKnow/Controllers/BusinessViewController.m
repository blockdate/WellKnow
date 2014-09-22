//
//  BusinessViewController.m
//  WellKnow
//
//  Created by qianfeng on 14-9-22.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "BusinessViewController.h"

@interface BusinessViewController ()

@end

@implementation BusinessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)setUrl{
    self.urlString = @"http://api.sina.cn/sinago/list.json?channel=news_finance";
}
- (void)configNavBar{
    [self setNavgationBarTitle:@"体育"];
    [self addSimpleNavigationBackButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
