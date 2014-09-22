//
//  UIImageView+ETTools.h
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ETTools)

+ (UIImageView *)ETRoundRectImageView;
- (void)blurry:(float)blu;
- (void)changeToRound;
- (void)changeToRoundRect;
@end
