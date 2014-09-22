//
//  NewsDetailViewController.h
//  WellKnow
//
//  Created by qianfeng on 14-9-22.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsNormalModel.h"
@interface NewsDetailViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic ,strong) NewsNormalModel *newsModel;
- (id)initWithModel:(NewsNormalModel *)model;
@end
