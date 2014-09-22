//
//  NSFileManager+pathMethod.h
//  LimitFreeApp
//
//  Created by  江志磊 on 14-8-27.
//  Copyright (c) 2014年  江 志磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (pathMethod)
//类别方法:判断指定路径下的文件，是否超出了规定的时间
+(BOOL)isTimeOutWithPath:(NSString *)path time:(NSTimeInterval)time;

@end
