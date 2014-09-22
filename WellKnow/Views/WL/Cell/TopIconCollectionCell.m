//
//  TopIconCollectionCell.m
//  WellKnow
//
//  Created by block on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "TopIconCollectionCell.h"
@interface TopIconCollectionCell(){
    id _target;
    SEL _selector;
}
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *iconButtonArray;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *iconTitleLabelArray;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundView;

@end
@implementation TopIconCollectionCell

- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    for (UIButton *btn in _iconButtonArray) {
        [btn changeToRound];
    }
    [_backGroundView changeToRoundRect];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIconImageArray:(NSArray *)array{
    for (NSInteger i = 0; i<8; i++) {
        UIButton *btn = _iconButtonArray[i];
        [btn setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        [btn addTarget:_target action:_selector forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addTarget:(id)target Selector:(SEL)selector{
    _target = target;
    _selector = selector;
}

- (void)setIconTitleArrat:(NSArray *)array{
    
}

@end
