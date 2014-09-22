//
//  PhotosView.m
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "PhotosView.h"
#import "UIImageView+WebCache.h"
#import "NewsNormalModel.h"
#import "DeviceManager.h"
@implementation PhotosView{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSArray *_modelArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addScrollView];
        [self addPageControl];
        [self drawBottomLine];
    }
    return self;
}

- (void)addScrollView
{
    CGRect mframe = self.bounds;
    _scrollView=[[UIScrollView alloc]initWithFrame:mframe];
    _scrollView.delegate=self;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
    [self addSubview:_scrollView];
}

- (void)addPageControl
{
    //页码
    CGRect mframe = self.bounds;
    mframe.origin.x = mframe.size.width - 45;
    mframe.origin.y = mframe.size.height - 15;
    mframe.size = CGSizeMake(30, 10);
    _pageControl=[[UIPageControl alloc]initWithFrame:mframe];
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:48.0/255 green:170.0/255 blue:250.0/255 alpha:1];
    _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    [self addSubview:_pageControl];
}

- (void)drawBottomLine
{
    //_pageControl下面的一条细线
    CGRect mframe = self.bounds;
    mframe.origin = CGPointMake(5, self.frame.size.height);
    mframe.size = CGSizeMake(310, 1);
    UILabel *line=[[UILabel alloc]initWithFrame:mframe];
    [line setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
    [self addSubview:line];
}



- (void)setScrollViewPages:(NSInteger)pageCount {
    _scrollView.contentSize=CGSizeMake(320*pageCount, self.frame.size.height);
    [_pageControl setNumberOfPages:pageCount];
}

- (void)addPerImageAt:(NSInteger)i imageUrlName:(NSString *)imageName {
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5+320*i, 10, 310, self.frame.size.height/2+20)];
    [imageView setImageWithURL:[NSURL URLWithString:imageName]];
    [_scrollView addSubview:imageView];
}

- (void)addPerTextAt:(NSInteger)i text:(NSString *)text {
    //标题
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10+320*i, self.frame.size.height/2+10, 300, self.frame.size.height/2)];
    [label setText:text];
    label.font = [UIFont systemFontOfSize:[DeviceManager systemTextSize]-2];
    [label setTextColor:[UIColor grayColor]];
    label.numberOfLines=3;
    [_scrollView addSubview:label];
}

- (void)sendDataArray:(NSArray *)array{
    NSInteger pageCount = [array count];
    [self setScrollViewPages:pageCount];
    _modelArray = [array copy];
    for (NSInteger i=0; i<pageCount; i++) {
        NSDictionary *perDic = _modelArray[i];
        [self addPerImageAt:i imageUrlName:perDic[@"pic"]];
        [self addPerTextAt:i text:perDic[@"alt"]];
    }
}

- (void)setTitleArray:(NSArray *)titleArray andImageUrlArray:(NSArray *)imageArray{
    NSInteger pageCount = titleArray.count;
    if (pageCount != imageArray.count) {
        return;
    }
    for (NSInteger i = 0; i<pageCount; i++) {
        [self addPerImageAt:i imageUrlName:imageArray[i]];
        [self addPerTextAt:i text:titleArray[i]];
    }
}
#pragma mark -scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger pageindex = scrollView.contentOffset.x/320;
    if (_pageControl.numberOfPages>=pageindex) {
        [_pageControl setCurrentPage:pageindex];
    }
}

@end
