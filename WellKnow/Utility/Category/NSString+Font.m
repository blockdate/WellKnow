//
//  NSString+Font.m
//  WellKnow
//
//  Created by block on 14-9-22.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "NSString+Font.h"

@implementation NSString (Font)

- (CGSize)sizeToFont:(CGFloat)font WithWidth:(CGFloat)width{
    CGSize size;
    if (IsIOS7) {
        //得到一个设置字体属性的字典
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil];
        //optinos 前两个参数是匹配换行方式去计算，最后一个参数是匹配字体去计算
        //attributes 传入使用的字体
        //boundingRectWithSize 计算的范围
        size = [self boundingRectWithSize:CGSizeMake(width,999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
        
    }else{
        //ios7以前
        size = [self sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(width,999) lineBreakMode:NSLineBreakByCharWrapping];
    }
    return size;
}

@end
