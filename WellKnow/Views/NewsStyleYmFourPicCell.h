//
//  NewsStyleYmFourPicCell.h
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsNormalModel;
@protocol FourPicDelegate <NSObject>
//将点中的新闻对象返回
- (void)sendModel:(NewsNormalModel *)model;

@end

@interface NewsStyleYmFourPicCell : UITableViewCell

- (void)configCell:(NSArray *)dataArray;

@property (nonatomic,weak) id<FourPicDelegate> delegate;

@end
