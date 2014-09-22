//
//  UILabel+ETTools.m
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "UILabel+ETTools.h"
#import "DeviceManager.h"
@implementation UILabel (ETTools)

- (void)fixToSystemTitleSize{
    [self fixToSystemTitleSizeWithMaxWidth:320];
}

- (void)fixToSystemSubTitleSize{
    [self fixToSystemSubTitleSizeWithMaxWidth:320];
}

- (void)fixToSystemTitleSizeWithMaxWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size = [self currentSizeWithFont:[DeviceManager systemTextSize] MaxWidth:width];
    self.font = [UIFont systemFontOfSize:[DeviceManager systemTextSize]];
    self.frame = frame;
}

- (void)fixToSystemSubTitleSizeWithMaxWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size = [self currentSizeWithFont:[DeviceManager systemTextSize]-2 MaxWidth:width];
    self.font = [UIFont systemFontOfSize:[DeviceManager systemTextSize]-2];
    self.frame = frame;
}

- (CGSize)currentSizeWithFont:(CGFloat)font{
    return [self currentSizeWithFont:font MaxWidth:320];
}

- (CGSize)currentSizeWithFont:(CGFloat)font MaxWidth:(CGFloat)width{
    CGSize size;
    if (IsIOS7) {
        //得到一个设置字体属性的字典
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil];
        //optinos 前两个参数是匹配换行方式去计算，最后一个参数是匹配字体去计算
        //attributes 传入使用的字体
        //boundingRectWithSize 计算的范围
        size = [self.text boundingRectWithSize:CGSizeMake(width,999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
        
    }else{
        //ios7以前
        size = [self.text sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(width,999) lineBreakMode:NSLineBreakByCharWrapping];
    }
    return size;
}
@end
