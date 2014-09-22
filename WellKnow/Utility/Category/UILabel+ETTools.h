//
//  UILabel+ETTools.h
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ETTools)

- (void)fixToSystemTitleSize;
- (void)fixToSystemSubTitleSize;

- (void)fixToSystemTitleSizeWithMaxWidth:(CGFloat)width;

- (void)fixToSystemSubTitleSizeWithMaxWidth:(CGFloat)width;

- (CGSize)currentSizeWithFont:(CGFloat)font MaxWidth:(CGFloat)width;

- (CGSize)currentSizeWithFont:(CGFloat)font;
@end
