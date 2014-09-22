//
//  YMImageAndLabelTool.m
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "YMImageAndLabelTool.h"
#import "UIImageView+ETTools.h"
#import "DeviceManager.h"
@implementation YMImageAndLabelTool

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _picImageView = [UIImageView ETRoundRectImageView];
        _picImageView.frame = CGRectMake(2, 2, 136, 86);

        UIImageView *border = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 90)];
        
        [self addSubview:_picImageView];
        border.image = [UIImage imageNamed:@"border9"];
        
        _titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 67, 135, 21)];
        _titleLabel1.backgroundColor = [UIColor blackColor];
        [_titleLabel1 setAlpha:0.6];
        
        _titleLabel1.font = [UIFont systemFontOfSize:([DeviceManager systemTextSize]-2)];
        [_titleLabel1 setTextColor:[UIColor whiteColor]];
        _titleLabel1.textAlignment = UITextAlignmentCenter;
        [self addSubview:_titleLabel1];
        [self addSubview:border];

    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
