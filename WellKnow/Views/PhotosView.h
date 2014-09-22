//
//  PhotosView.h
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosView : UIView <UIScrollViewDelegate>

- (void)sendDataArray:(NSArray *)array;
- (void)setTitleArray:(NSArray *)titleArray andImageUrlArray:(NSArray *)imageArray;
@end
