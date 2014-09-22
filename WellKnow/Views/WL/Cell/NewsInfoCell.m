//
//  NewsInfoCell.m
//  WellKnow
//
//  Created by block on 14-9-22.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "NewsInfoCell.h"

@implementation NewsInfoCell

- (void)awakeFromNib
{
    _backGroundView.backgroundColor = [UIColor lightGrayColor];
    [_customImageView changeToRoundRectWithColor:[UIColor whiteColor]];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected) {
        _backGroundView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    }else{
        _backGroundView.backgroundColor = [UIColor whiteColor] ;
            _backGroundView.alpha = 1;
    }
}

@end
