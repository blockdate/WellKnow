//
//  UIImageView+ETTools.m
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "UIImageView+ETTools.h"
#import "Tools.h"
@implementation UIImageView (ETTools)

+ (UIImageView *)ETRoundRectImageView{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor clearColor];
    
    [imageView changeToRoundRect];
    return imageView;
}

- (void)changeToRound{
    [self changeRadio:self.frame.size.width/2];
}

- (void)changeToRoundRect{
    [self changeRadio:5];
}

- (void)changeToRoundRectWithColor:(UIColor *)color{
    [self changeRadio:5 color:color];
}

- (void)changeRadio:(CGFloat)r color:(UIColor *)color{
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [color CGColor];
    self.layer.borderWidth = 2;
    self.layer.cornerRadius = r;
}

- (void)changeRadio:(CGFloat)r{
    [self changeRadio:r color:[UIColor clearColor]];
}

- (void)blurry:(float)blu{
    Tools *tool = [[Tools alloc]init];
    if (self.image) {
        self.image = [tool blurryImage:self.image withBlurLevel:blu];
    }
}
@end
