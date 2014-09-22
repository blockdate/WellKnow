//
//  NewsStyleYmOnePicCell.m
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "NewsStyleYmOnePicCell.h"
#import "NewsNormalModel.h"
#import "ETSettingInfo.h"
#import "UILabel+ETTools.h"
#import "DeviceManager.h"
#import "UIImageView+WebCache.h"

@implementation NewsStyleYmOnePicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configUIWithModel:(NewsNormalModel *)model{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 20)];
    titleLabel.text = model.title;
    //    [titleLabel fixToSystemTitleSize];
    [self.contentView addSubview:titleLabel];
    
    UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, 280, 140)];
    [picImageView setImageWithURL:[NSURL URLWithString:model.pic]];
    [self.contentView addSubview:picImageView];
    
    UILabel *infoLabel =  [[UILabel alloc] init];
    [infoLabel setTextColor:[UIColor grayColor]];
    infoLabel.font = [UIFont systemFontOfSize:[DeviceManager systemTextSize]-3];
    infoLabel.frame = CGRectMake(20, 182, 280,  0);
    infoLabel.text = model.intro;
    infoLabel.numberOfLines = 0;
    [infoLabel fixToSystemSubTitleSizeWithMaxWidth:280];
    [self.contentView addSubview:infoLabel];
//    
//    UIImageView  *_borderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border9"]];
//    [_borderImageView setFrame:CGRectMake(20, 40 , 280, 140)];
//    [self.contentView addSubview:_borderImageView];
}


@end
