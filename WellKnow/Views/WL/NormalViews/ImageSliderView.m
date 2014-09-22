//
//  ImageSliderView.m
//  WellKnow
//
//  Created by block on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "ImageSliderView.h"
#import "UIButton+WebCache.h"
@implementation ImageSliderView{
    UIScrollView *_scrollView;
}

- (void)initScrollView {
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
}

- (id)init{
    if (self = [super init]) {
        [self initScrollView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setScrollFrame:(CGRect)frame {
    _scrollView.frame = frame;
}

- (id)initWithWithFrame:(CGRect)frame TextArray:(NSArray *)textArray imageArray:(NSArray *)imageArray{
    return [self initWithFrame:frame TextArray:textArray imageArray:imageArray imageType:ImageTypeUrlSource];
}

- (void)setScrollViewPageCount:(NSInteger)pageNumber {
    [_scrollView setContentSize:CGSizeMake(320*pageNumber, _scrollView.frame.size.height)];
}

- (id)initWithFrame:(CGRect)frame TextArray:(NSArray *)textArray imageArray:(NSArray *)imageArray imageType:(ImageType)imagetype{
    if (self = [self init]) {
        if (textArray.count != imageArray.count) {
            return self;;
        }
        [self setScrollFrame:frame];
        [self setScrollViewPageCount:textArray.count];
        for (NSInteger i = 0; i<imageArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            frame.origin.x = 320*i;
            btn.frame = frame;
            if (ImageTypeUrlSource == imagetype) {
                [btn setImageWithURL:imageArray[i] forState:UIControlStateNormal];
            }else if(ImageTypeLocalSource == imagetype){
                [btn setImage:[UIImage imageWithContentsOfFile:imageArray[i]] forState:UIControlStateNormal];
            }else if(ImageTypeBundleSource == imagetype){
                [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            }
            [_scrollView addSubview:btn];
        }
    }
    return self;
}

@end
