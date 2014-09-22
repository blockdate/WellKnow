//
//  CarViewController.m
//  WellKnow
//
//  Created by qianfeng on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "CarViewController.h"
#import "ETRequestManager.h"
#import "CarView.h"
#import "CarCell.h"
#import "NewsNormalModel.h"
#import "UIImageView+WebCache.h"

@interface CarViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_headDataArray;//顶部图片
    NSMutableArray *_listDataArray;//列表
    CarView *_carView;
}
@end

@implementation CarViewController
#define CarUrlString @"http://api.sina.cn/sinago/list.json?channel=news_auto"

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
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CarBg"]];
    
    //数据源
    _headDataArray=[[NSMutableArray alloc]init];
    _listDataArray=[[NSMutableArray alloc]init];
    _carView=[[CarView alloc]initWithFrame:CGRectMake(0, 0, 300, 130)];
    
    //tableView
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(8, 3, 300, height) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor colorWithWhite:0.9 alpha:0];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableHeaderView=_carView;
    [self.view addSubview:_tableView];
    
    [self loadData];//数据请求
}
#pragma mark -httpRequest
- (void)loadData{
    [[ETRequestManager sharedManager]requestWithUrlString:CarUrlString requestType:HttpRequestTypeGET params:nil showWaitDialog:YES finised:^(id result) {
        NSDictionary *dic=[(NSDictionary *)result objectForKey:@"data"];
        NSArray *list=dic[@"list"];
        for (NSDictionary *perDic in list) {
            NewsNormalModel *model=[[NewsNormalModel alloc]init];
            [model setValuesForKeysWithDictionary:perDic];
            if (model.is_focus) { //顶部
                [_headDataArray addObject:model];
                [_carView sendEventArray:_headDataArray];
            }
            [_listDataArray addObject:model];//列表
        }
        [_tableView reloadData];
    } failed:^(id result) {
    }];
}
#pragma mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _listDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}
#pragma mark -tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarCell *carCell=[tableView dequeueReusableCellWithIdentifier:@"CarCell"];
    if (carCell==nil) {
        carCell=[[[NSBundle mainBundle]loadNibNamed:@"CarCell" owner:self options:nil]lastObject];
    }
    NewsNormalModel *model=_listDataArray[indexPath.section];
    [carCell.picImageView setImageWithURL:[NSURL URLWithString:model.pic]];
    [carCell.pubDateLabel setText:[NSString stringWithFormat:@"%@发布",model.currectTime]];
    [carCell.titleLabel setText:model.title];
    [carCell.longTitleLabel setText:model.long_title];
    return carCell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
