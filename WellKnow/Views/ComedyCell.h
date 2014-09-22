//
//  ComedyCell.h
//  WellKnow
//
//  Created by qianfeng on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComedyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cateGroyImageView;

@property (weak, nonatomic) IBOutlet UILabel *cateGoryLabel;

@end
