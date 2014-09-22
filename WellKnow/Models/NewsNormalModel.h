//
//  NewsNormalModel.h
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsNormalModel : NSObject

/**
 id : "704-90691-hdpic"
 title : "网曝锋菲再复合 谢霆锋王菲寓所拥吻"
 long_title : "网曝锋菲再复合 谢霆锋王菲寓所拥吻"
 source : "新浪"
 link : "http://photo.sina.cn/album?ch=4&sid=704&aid=90691&fromsinago=1"
 pic : "http://r3.sinaimg.cn/2/2014/0920/28/d/79498225/auto.jpg"
 intro : "新浪娱乐讯 9月20日，网曝峰菲再度复合，谢霆锋夜宿王菲寓所，两人洗手羹汤，热情拥吻。"
 pubDate : 1411177510
 comments : "slidenews-album-704-90691_1_yl
 category : "hdpic"
 is_focus : true
 pics
 total : 5
 comment : 134
 comment_count_info
 qreply : 1035 回复
 total : 1272
 show : 134
 */

//新闻id
@property (nonatomic ,copy) NSString *id;
//新闻标题
@property (nonatomic ,copy) NSString *title;
//长标题
@property (nonatomic ,copy) NSString *long_title;
//新闻来源
@property (nonatomic ,copy) NSString *source;
//详情链接地址
@property (nonatomic ,copy) NSString *link;
//显示图片
@property (nonatomic ,copy) NSString *pic;
@property (nonatomic,copy) NSDictionary *pics;
@property (nonatomic,copy) NSString *total;
//描述信息
@property (nonatomic ,copy) NSString *intro;
//发布日期时间戳
@property (nonatomic ,strong) NSNumber *pubDate;
//类别
@property (nonatomic ,copy) NSString *category;
//是否在头部显示（新闻页面最靠上的ScrollView中显示）
@property (nonatomic ,assign) BOOL is_focus;
//评论信息
@property (nonatomic ,strong) NSDictionary *comment_count_info;
//当前时间
- (NSString *)currectTime;
//评论回复信息（回复个数）
- (NSString *)qreply;

@end
