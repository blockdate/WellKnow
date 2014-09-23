//
//  NewsDetailViewController.m
//  WellKnow
//
//  Created by qianfeng on 14-9-22.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "DeviceManager.h"
#import "SVProgressHUD.h"
@interface NewsDetailViewController ()
{
    UIWebView *_webView;
}
@end

@implementation NewsDetailViewController

- (id)initWithModel:(NewsNormalModel *)model{
    if (self = [super init]) {
        _newsModel = [[NewsNormalModel alloc] init];
        _newsModel = model;
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}

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

    [self configUI];
}

- (void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSimpleNavigationBackButtonWithaction:@selector(navigationBackButtonClick)];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, [DeviceManager screenHeight])];
    NSURL *url = [NSURL URLWithString:_newsModel.link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
}
#pragma  mark - webView delegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"加载中……" ];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismissWithError:@"加载失败" afterDelay:1.5];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismissWithSuccess:@"加载成功" afterDelay:0.5];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationBackButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [SVProgressHUD dismiss];
}

@end
