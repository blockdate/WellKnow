//
//  NewsStyleYmNormalCell.m
//  WellKnow
//
//  Created by qianfeng on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "NewsStyleYmNormalCell.h"
#import "UILabel+ETTools.h"
#import "UIImageView+WebCache.h"
#import "DeviceManager.h"

@implementation NewsStyleYmNormalCell
{
    UIImageView *_newImage ;
    UILabel *_titlelabel;
    UILabel *_detail;
    UIImageView *_iconImage;
    UILabel *_iconText;
    UIImageView *_borderImageView;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _newImage = [[UIImageView alloc] initWithFrame:CGRectMake(240, 10, 70, 60)];
        [self.contentView addSubview: _newImage];
        
        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 210, 21)];
        [self.contentView addSubview:_titlelabel];
        
        _detail = [[UILabel alloc] initWithFrame:CGRectMake(20, 34, 210, 21)];
         _detail.font = [UIFont systemFontOfSize:[DeviceManager systemTextSize]-2];
        [_detail setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:_detail];
        
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 58, 10 , 10)];
        [self.contentView addSubview:_iconImage];

        _iconText = [[UILabel alloc] initWithFrame:CGRectMake(33, 58, 50, 10)];
        _iconText.font = [UIFont systemFontOfSize:9];
        _iconText.textColor = [UIColor blueColor];
        [self.contentView addSubview:_iconText];
        
        _borderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border9"]];
        [_borderImageView setFrame:CGRectMake(240, 10, 70, 60)];
        [self.contentView addSubview:_borderImageView];
        
    }
    return self;
}

- (void)configCell:(NewsNormalModel *)model{


    [_newImage setImageWithURL:[NSURL URLWithString:model.pic]];
    _titlelabel.text = model.title;
  //  [_titlelabel fixToSystemTitleSizeWithMaxWidth:230];
    _detail.text = model.intro;
    [_detail fixToSystemSubTitleSizeWithMaxWidth:230];
    if ([model.category isEqualToString:@"video"]) {
        _iconImage.image = [UIImage imageNamed:@"video"];
        _iconText.text = @"视频";
        [_iconText setTintColor:[UIColor blueColor]];
        _iconText.hidden = NO;
        _iconImage.hidden = NO;
    }else if ([model.category isEqualToString:@"subject"]) {
        _iconImage.image = [UIImage imageNamed:@"subject"];
        _iconText.text = @"专题";
        [_iconText setTintColor:[UIColor blueColor]];
        _iconText.hidden = NO;
        _iconImage.hidden = NO;
    }else {

        _iconText.hidden = YES;
        _iconImage.hidden = YES;
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
