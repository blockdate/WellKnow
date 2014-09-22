//
//  SliderImageTableViewCell.m
//  WellKnow
//
//  Created by block on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "WeatherInfoCell.h"
#import "ImageSliderView.h"
#import "WeatherModel.h"
@interface WeatherInfoCell(){
    WeatherModel *_weatherModel;
}
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windyLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLevelLabel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundView;

@end

@implementation WeatherInfoCell

- (void)awakeFromNib
{
    // Initialization code
    [_backGroundView changeToRoundRect];
    [_backGroundView setBackgroundColor:[UIColor whiteColor]];
    self.backgroundColor = [UIColor clearColor];
    [_loadingIndicator startAnimating];
    [self hideAllViews:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)hideAllViews:(BOOL)hide {
    for (UIView *view in self.contentView.subviews) {
        view.hidden = hide;
    }
    _backGroundView.hidden = NO;
    _loadingIndicator.hidden = !hide;
}

- (void)setWeatherInfo:(WeatherModel *)model{
    
    [self hideAllViews:YES];
    
    if (model && [model isKindOfClass:[WeatherModel class]]) {
        [self hideAllViews:NO];
        _minTemperatureLabel.text = [[model.low componentsSeparatedByString:@" "] lastObject];
        _maxTemperatureLabel.text = [[model.high componentsSeparatedByString:@" "] lastObject];
        _windyLabel.text = model.fengxiang;
        _windLevelLabel.text = model.fengli;
        [_windLevelLabel fixToSystemSubTitleSize];
        _weekdayLabel.text = model.date;
        [_weekdayLabel fixToSystemTitleSize];
        [self f];
    }
}

- (void)f{
    NSMutableArray *imageArray = [NSMutableArray array];
//    for (NSInteger i = 7; i<=8; i++) {
    for (NSInteger i = 14; i<=17; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"w%ld",i]];
        [imageArray addObject:image];
    }
    [_weatherImage setAnimationImages:imageArray];
    [_weatherImage setAnimationDuration:.7];
    [_weatherImage startAnimating];
}

@end
