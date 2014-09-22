//
//  SliderImageTableViewCell.m
//  WellKnow
//
//  Created by block on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "SliderImageTableViewCell.h"
@interface SliderImageTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *backGroundView;

@end

@implementation SliderImageTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    [_backGroundView changeToRoundRect];
    [_backGroundView setBackgroundColor:[UIColor whiteColor]];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
