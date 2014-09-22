//
//  NewsStyleYmOnePicCell.h
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsNormalModel;

@interface NewsStyleYmOnePicCell : UITableViewCell
//只显示一张图片的cell样式
//通过新闻对象配置UI
- (void)configUIWithModel:(NewsNormalModel *)model;

@end
