//
//  UIButton+ETTools.m
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "UIButton+ETTools.h"

@implementation UIButton (ETTools)

+ (UIButton *)ETRoundRectButton{
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [btn changeToRoundRect];
    return btn;
}


- (void)changeToRound{
    [self changeRadio:self.frame.size.width/2];
}

- (void)changeToRoundRect{
    [self changeRadio:5];
}


- (void)changeRadio:(CGFloat)r{
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = r;
}
@end
