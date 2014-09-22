//
//  NewsStyleYmFourPicCell.m
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "NewsStyleYmFourPicCell.h"
#import "NewsNormalModel.h"
#import "UIImageView+ETTools.h"
#import "YMImageAndLabelTool.h"
#import "UIImageView+WebCache.h"
@implementation NewsStyleYmFourPicCell
{
    YMImageAndLabelTool *_customView1;
    YMImageAndLabelTool *_customView2;
    YMImageAndLabelTool *_customView3;
    YMImageAndLabelTool *_customView4;
    
    NSMutableArray *_viewArray;
    NSMutableArray *_dataArray;
    
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _customView1 = [[YMImageAndLabelTool alloc] initWithFrame:CGRectMake(20, 20, 130, 80)];
        _customView1.tag = 100;
        _customView2 = [[YMImageAndLabelTool alloc] initWithFrame:CGRectMake(170, 20, 130, 80)];
        _customView2.tag = 101;

        _customView3 = [[YMImageAndLabelTool alloc] initWithFrame:CGRectMake(20, 120, 130, 80)];
        _customView3.tag = 102;
        _customView3.backgroundColor = [UIColor blackColor];
        
        _customView4 = [[YMImageAndLabelTool alloc] initWithFrame:CGRectMake(170, 120, 130, 80)];
        _customView4.tag = 103;
        
        UIView *view = self.contentView;

        [view addSubview:_customView1];
        [view addSubview:_customView2];
        [view addSubview:_customView3];
        [view addSubview:_customView4];

//        [self.contentView addSubview:_customView1];
//        [self.contentView addSubview:_customView2];
//        [self.contentView addSubview:_customView3];
//        [self.contentView addSubview:_customView4];
//
        
    }
    return self;
}

- (void)configCell:(NSArray *)dataArray{
    _dataArray = [[NSMutableArray alloc] initWithArray:dataArray];
    for (int i = 0; i<4; i++) {
        NewsNormalModel *model = [_dataArray objectAtIndex:i];
        YMImageAndLabelTool *customView = (YMImageAndLabelTool *)[self.contentView.subviews objectAtIndex:i];
        [customView.titleLabel setText:model.title];
        [customView.picImageView setImageWithURL:[NSURL URLWithString:model.pic] ];
        customView.userInteractionEnabled = YES;
        customView.tag = 200 + 0;
    }
}




- (void)addgestureTOView:(UIView *)view{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    //将手势添加到视图上
    tap.numberOfTapsRequired =1;
    tap.delegate =self;
    [view addGestureRecognizer:tap];
}

- (void)tapGesture:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    NSInteger i = view.tag - 200;
    NewsNormalModel *model = [_dataArray objectAtIndex:i];
    [_delegate sendModel:model];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
