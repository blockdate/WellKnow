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
#import "ComedyCell.h"
#import "UIImageView+WebCache.h"

@interface TechnologyViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation TechnologyViewController

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
    _dataArray=[[NSMutableArray alloc]init];
    //tableView
    CGFloat height=[UIScreen mainScreen].bounds.size.height-150;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 150, 320, height) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    //httpRequest
    [[ETRequestManager sharedManager]requestWithUrlString:@"http://api.sina.cn/sinago/list.json?channel=news_tech" requestType:HttpRequestTypeGET params:nil showWaitDialog:YES finised:^(id result) {
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

#pragma mark -四个分类 (24小时、昨天、前天、一周)
- (void)createCate{
    NSArray *labelArray=@[@"最新",@"昨天",@"前天"];
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
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(5, 148, 310, 1)];
    line.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:line];
    [self.view addSubview:bgImageView];
}

- (void)btnClicked:(UIButton *)btn{
    if (btn.tag==100) {
        [[ETRequestManager sharedManager]requestWithUrlString:@"http://api.sina.cn/sinago/list.json?channel=news_tech" requestType:HttpRequestTypeGET params:nil showWaitDialog:YES finised:^(id result) {
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
        [_dataArray removeAllObjects];
        [[ETRequestManager sharedManager]requestWithUrlString:@"http://api.sina.cn/sinago/list.json?channel=local_beijing" requestType:HttpRequestTypeGET params:nil showWaitDialog:YES finised:^(id result) {
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
        [_dataArray removeAllObjects];
        [[ETRequestManager sharedManager]requestWithUrlString:@"http://api.sina.cn/sinago/list.json?channel=news_auto" requestType:HttpRequestTypeGET params:nil showWaitDialog:YES finised:^(id result) {
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
    if (section==0) {
        return 1;
    }
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
#pragma mark -tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section==0) {
        ComedyCell *tech=[tableView dequeueReusableCellWithIdentifier:@"ComedyCell"];
        if (tech==nil) {
            tech=[[[NSBundle mainBundle]loadNibNamed:@"ComedyCell" owner:self options:nil]lastObject];
        }
        NewsNormalModel *model=_dataArray.lastObject;
        [tech.picImageView setImageWithURL:[NSURL URLWithString:model.pic]];
        [tech.titleLabel setText:model.title];
        [tech.introLabel setText:model.intro];
        [tech.commentLabel setText:[NSString stringWithFormat:@"%@",[model.comment_count_info objectForKey:@"total"]]];
        if ([model.category isEqualToString:@"video"]) {
            [tech.cateGroyImageView setImage:[UIImage imageNamed:@"video"]];
            [tech.cateGoryLabel setText:@"视频"];
            [tech.cateGoryLabel setTextColor:[UIColor colorWithRed:35.0/255 green:120.0/255 blue:250.0/255 alpha:1]];
        }else if ([model.category isEqualToString:@"subject"]){
            [tech.cateGroyImageView setImage:[UIImage imageNamed:@"subject"]];
            [tech.cateGoryLabel setText:@"专题"];
            [tech.cateGoryLabel setTextColor:[UIColor redColor]];
        }else{
            [tech.cateGroyImageView setImage:[UIImage imageNamed:@" "]];
            [tech.cateGoryLabel setText:@" "];
        }
        cell=tech;
    }else{
        ComedyCell *tech1=[tableView dequeueReusableCellWithIdentifier:@"ComedyCell"];
        if (tech1==nil) {
            tech1=[[[NSBundle mainBundle]loadNibNamed:@"ComedyCell" owner:self options:nil]lastObject];
        }
        NewsNormalModel *model=_dataArray[indexPath.row];
        [tech1.picImageView setImageWithURL:[NSURL URLWithString:model.pic]];
        [tech1.titleLabel setText:model.title];
        [tech1.introLabel setText:model.intro];
        [tech1.commentLabel setText:[NSString stringWithFormat:@"%@",[model.comment_count_info objectForKey:@"total"]]];
        if ([model.category isEqualToString:@"video"]) {
            [tech1.cateGroyImageView setImage:[UIImage imageNamed:@"video"]];
            [tech1.cateGoryLabel setText:@"视频"];
            [tech1.cateGoryLabel setTextColor:[UIColor colorWithRed:35.0/255 green:120.0/255 blue:250.0/255 alpha:1]];
        }else if ([model.category isEqualToString:@"subject"]){
            [tech1.cateGroyImageView setImage:[UIImage imageNamed:@"subject"]];
            [tech1.cateGoryLabel setText:@"专题"];
            [tech1.cateGoryLabel setTextColor:[UIColor redColor]];
        }else{
            [tech1.cateGroyImageView setImage:[UIImage imageNamed:@" "]];
            [tech1.cateGoryLabel setText:@" "];
        }

        cell=tech1;
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
