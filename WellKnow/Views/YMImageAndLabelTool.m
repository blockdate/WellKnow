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
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 67, 135, 21)];
        _titleLabel.backgroundColor = [UIColor blackColor];
        [_titleLabel setAlpha:0.6];
        
        _titleLabel.font = [UIFont systemFontOfSize:([DeviceManager systemTextSize]-2)];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_titleLabel];
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
