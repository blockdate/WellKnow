//
//  TopIconCollectionCell.h
//  WellKnow
//
//  Created by block on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopIconCollectionCell : UITableViewCell

- (void)setIconImageArray:(NSArray *)array;
- (void)setIconTitleArrat:(NSArray *)array;
- (void)addTarget:(id)target Selector:(SEL)selector;
@end
