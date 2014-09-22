//
//  ImageSliderView.h
//  WellKnow
//
//  Created by block on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageType) {
    ImageTypeUrlSource,
    ImageTypeLocalSource,
    ImageTypeBundleSource
};

@interface ImageSliderView : UIView<UIScrollViewDelegate>

- (id)initWithWithFrame:(CGRect)frame TextArray:(NSArray *)textArray imageArray:(NSArray *)imageArray;

- (id)initWithFrame:(CGRect)frame TextArray:(NSArray *)textArray imageArray:(NSArray *)imageArray imageType:(ImageType)imagetype;
@end
