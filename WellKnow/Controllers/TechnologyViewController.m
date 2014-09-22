//
//  TechnologyViewController.m
//  WellKnow
//
//  Created by qianfeng on 14-9-22.
//  Copyright (c) 2014年 Block. All rights reserved.
//科技页面

#import "TechnologyViewController.h"
#import "ETRequestManager.h"
#import "NewsNormalModel.h"

@interface TechnologyViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation TechnologyViewController
#define firstUrlString @"http://api.sina.cn/sinago/list.json?channel=news_tech"
#define secondUrlString @"http://api.sina.cn/sinago/list.json?channel=local_beijing"
#define thirdUrlString @"http://api.sina.cn/sinago/list.json?channel=news_tech"

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
    self.view.backgroundColor=[UIColor whiteColor];
    [self addSimpleNavigationBackButton];
    [self setNavgationBarTitle:@"科技"];
    [self createCate];//四个分类
    //tableView
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 145, 320, height) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

#pragma mark -四个分类 (24小时、昨天、前天、一周)
- (void)createCate{
    NSArray *labelArray=@[@"24小时",@"昨天",@"前天"];
    NSArray *buttonBgArray=@[@"hour.png",@"tomorrow.png",@"aftertomorrow.png"];
    UIImageView *bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 68, 320, 80)];
    bgImageView.image=[UIImage imageNamed:@"cateBg"];
    bgImageView.userInteractionEnabled=YES;
    for (NSInteger i=0; i<labelArray.count; i++) {
        //button
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setFrame:CGRectMake(30+32*i+80*i,20, 32, 32)];
        [btn setBackgroundImage:[UIImage imageNamed:buttonBgArray[i]] forState:UIControlStateNormal];
        [btn setTag:100+i];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:btn];
        //label
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(27+40*i+76*i, 54, 50, 20)];
        [label setText:labelArray[i]];
        label.font=[UIFont systemFontOfSize:13];
        [label setTextColor:[UIColor colorWithWhite:0.4 alpha:1]];
        [bgImageView addSubview:label];
    }
    //细线
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(5, 143, 310, 1)];
    line.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:line];
    [self.view addSubview:bgImageView];
}

- (void)btnClicked:(UIButton *)btn{
    if (btn.tag==100) {
        [[ETRequestManager sharedManager]requestWithUrlString:firstUrlString requestType:HttpRequestTypeGET params:nil showWaitDialog:YES finised:^(id result) {
            NSDictionary *dic=[(NSDictionary *)result objectForKey:@"data"];
            NSArray *list=dic[@"list"];
            for (NSDictionary *perDic in list) {
                NewsNormalModel *model=[[NewsNormalModel alloc]init];
                [model setValuesForKeysWithDictionary:perDic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        } failed:^(id result) {
        }];
    }else if (btn.tag==101){
        [[ETRequestManager sharedManager]requestWithUrlString:secondUrlString requestType:HttpRequestTypeGET params:nil showWaitDialog:YES finised:^(id result) {
            NSDictionary *dic=[(NSDictionary *)result objectForKey:@"data"];
            NSArray *list=dic[@"list"];
            for (NSDictionary *perDic in list) {
                NewsNormalModel *model=[[NewsNormalModel alloc]init];
                [model setValuesForKeysWithDictionary:perDic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        } failed:^(id result) {
        }];
    }else{
        [[ETRequestManager sharedManager]requestWithUrlString:thirdUrlString requestType:HttpRequestTypeGET params:nil showWaitDialog:YES finised:^(id result) {
            NSDictionary *dic=[(NSDictionary *)result objectForKey:@"data"];
            NSArray *list=dic[@"list"];
            for (NSDictionary *perDic in list) {
                NewsNormalModel *model=[[NewsNormalModel alloc]init];
                [model setValuesForKeysWithDictionary:perDic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        } failed:^(id result) {
        }];
    }
}

#pragma mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
#pragma mark -tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
