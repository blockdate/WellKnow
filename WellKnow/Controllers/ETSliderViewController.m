//
//  ETSliderViewController.m
//  WellKnow
//
//  Created by block on 14-9-22.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "ETSliderViewController.h"
#import "MainViewController.h"
#import "LeftSliderViewController.h"
@interface ETSliderViewController ()

@end

@implementation ETSliderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavgationBarTitle:@"悦读"];
    
    _speedf = 0.5;
    
    leftControl = [[LeftSliderViewController alloc]init];;
    mainControl = [[MainViewController alloc]init];;
    righControl = nil;
    
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [imgview setImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:imgview];
    
    //滑动手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [mainControl.view addGestureRecognizer:pan];
    
    
    //单击手势
    _sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
    [_sideslipTapGes setNumberOfTapsRequired:1];
    
    [mainControl.view addGestureRecognizer:_sideslipTapGes];
    
    leftControl.view.hidden = YES;
    righControl.view.hidden = YES;
    
    [self.view addSubview:leftControl.view];
    [self.view addSubview:righControl.view];
    
    [self.view addSubview:mainControl.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    
    CGPoint point = [rec translationInView:self.view];
    
    scalef = (point.x*_speedf+scalef);
    
    //根据视图位置判断是左滑还是右边滑动
    if (rec.view.frame.origin.x>=0){
        
        rec.view.center = CGPointMake(rec.view.center.x + point.x*_speedf,rec.view.center.y);
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1-scalef/1000,1-scalef/1000);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
        righControl.view.hidden = YES;
        leftControl.view.hidden = NO;
        
    }
//    else
//    {
//        rec.view.center = CGPointMake(rec.view.center.x + point.x*_speedf,rec.view.center.y);
//        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1+scalef/1000,1+scalef/1000);
//        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
//        
//        
//        righControl.view.hidden = NO;
//        leftControl.view.hidden = YES;
//    }
    
    
    
    //手势结束后修正位置
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (scalef>140*_speedf){
            [self showLeftView];
        }
//        else if (scalef<-140*_speedf) {
//            [self showRighView];        }
        else
        {
            [self showMainView];
            scalef = 0;
        }
    }
    
}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        [UIView commitAnimations];
        scalef = 0;
        
    }
    
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

//显示左视图
-(void)showLeftView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
    mainControl.view.center = CGPointMake(340,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
    
}

//显示右视图
-(void)showRighView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
    mainControl.view.center = CGPointMake(-60,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

@end
