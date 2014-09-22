//
//  SliderImageTableViewCell.h
//  WellKnow
//
//  Created by block on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherModel;
@interface WeatherInfoCell : UITableViewCell

- (void)setWeatherInfo:(WeatherModel *)model;

//- (void)setTitleArray:(NSArray *)titleArray andImageUrlArray:(NSArray *)imageArray;

@end
