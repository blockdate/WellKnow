//
//  NewsInfoCell.h
//  WellKnow
//
//  Created by block on 14-9-22.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backGroundView;

@property (weak, nonatomic) IBOutlet UIImageView *customImageView;
@property (weak, nonatomic) IBOutlet UILabel *customTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *customDetailLabel;

@end
