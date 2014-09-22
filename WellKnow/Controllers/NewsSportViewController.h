//
//  NewsSportViewController.h
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsStyleYmFourPicCell.h"
@interface NewsSportViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,FourPicDelegate>
@property (nonatomic,weak) NSString *urlString;

- (void)setUrl;
- (void)configNavBar;
@end
