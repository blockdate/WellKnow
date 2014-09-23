//
//  WeatherModel.h
//  WellKnow
//
//  Created by block on 14-9-22.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *fengli;
@property (nonatomic, copy) NSString *fengxiang;
@property (nonatomic, copy) NSString *high;
@property (nonatomic, copy) NSString *low;
@property (nonatomic, copy) NSString *type;

@end
