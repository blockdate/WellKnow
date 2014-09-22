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

@implementation PhotosView{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSArray *_modelArray;
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

- (void)setScrollViewPages:(NSInteger)pageCount {
    _scrollView.contentSize=CGSizeMake(320*pageCount, 200);
}

- (void)sendDataArray:(NSArray *)array{
    NSInteger pageCount = [array count];
    [self setScrollViewPages:pageCount];
    _modelArray = [array copy];
    for (NSInteger i=0; i<[array[0] count]; i++) {
        NSDictionary *perDic = _modelArray[i];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5+320*i, 10, 310, 100)];
        [imageView setImageWithURL:[NSURL URLWithString:perDic[@"pic"]]];
        //标题
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10+320*i, 100, 300, 100)];
        [label setText:perDic[@"alt"]];
        [label setTextColor:[UIColor grayColor]];
        label.numberOfLines=3;
        [_scrollView addSubview:imageView];
        [_scrollView addSubview:label];
        [_pageControl setNumberOfPages:3];
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
