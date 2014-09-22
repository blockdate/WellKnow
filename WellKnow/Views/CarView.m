//
//  CarView.m
//  WellKnow
//
//  Created by qianfeng on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "CarView.h"
#import "UIImageView+WebCache.h"
#import "NewsNormalModel.h"

@implementation CarView{
    UIImageView *_imageView;
    UILabel *_titleLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
- (void)sendEventArray:(NSArray *)array{
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 130)];
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 60, 260, 100)];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    NewsNormalModel *model= [array objectAtIndex:0];
    [_imageView setImageWithURL:[NSURL URLWithString:model.pic]];
    [_titleLabel setText:model.title];
    [_imageView addSubview:_titleLabel];
    [self addSubview:_imageView];
}

@end
