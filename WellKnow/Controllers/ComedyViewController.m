//
//  FunnyViewController.m
//  WellKnow
//
//  Created by qianfeng on 14-9-21.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "ComedyViewController.h"
#import "NewsNormalModel.h"
#import "UIImageView+WebCache.h"
#import "ETRequestManager.h"
#import "ComedyCell.h"
#import "ComedyOtherCell.h"


@interface ComedyViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;

}
@end

@implementation ComedyViewController
#define ComedyUrlString @"http://api.sina.cn/sinago/list.json?channel=news_funny"

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
    [self setNavgationBarTitle:@"搞笑"];
    [self addSimpleNavigationBackButton];
    [self prepareData];
    [self prepareTableView];
    [self loadData];//数据请求
}

- (void)prepareData
{
    _dataArray=[[NSMutableArray alloc]init];
}

- (void)prepareTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, [DeviceManager screenHeight]) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

#pragma mark -httpRequest
- (void)loadData{
    [[ETRequestManager sharedManager]requestWithUrlString:ComedyUrlString requestType:HttpRequestTypeGET params:nil showWaitDialog:YES finised:^(id result) {
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
#pragma mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsNormalModel *model=_dataArray[indexPath.row];
    if ([model.category isEqualToString:@"hdpic"]) {
        return 125;
    }
    return 80;
}
#pragma mark -tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    NewsNormalModel *model=_dataArray[indexPath.row];
    if ([model.category isEqualToString:@"hdpic"]){
        ComedyOtherCell *comedyCell=[tableView dequeueReusableCellWithIdentifier:@"ComedyOtherCell"];
        if (comedyCell==nil) {
            comedyCell=[[[NSBundle mainBundle]loadNibNamed:@"ComedyOtherCell" owner:self options:nil]lastObject];
        }
        [comedyCell.introLabel setText:model.long_title];
        [comedyCell.commentLabel setText:[NSString stringWithFormat:@"%@",[model.comment_count_info objectForKey:@"qreply"]]];
        [comedyCell.totalLabel setText:[NSString stringWithFormat:@"%@",[model.comment_count_info objectForKey:@"total"]]];
        NSArray *list=model.pics[@"list"];
        [comedyCell.picOneImageView setImageWithURL:[NSURL URLWithString:[list[0] objectForKey:@"pic"]]];
        [comedyCell.picTwoImageView setImageWithURL:[NSURL URLWithString:[list[1] objectForKey:@"pic"]]];
        [comedyCell.picThreeImageView setImageWithURL:[NSURL URLWithString:[list[2] objectForKey:@"pic"]]];
        cell=comedyCell;
    }else {
        ComedyCell *comedyCell=[tableView dequeueReusableCellWithIdentifier:@"ComedyCell"];
        if (comedyCell==nil) {
            comedyCell=[[[NSBundle mainBundle]loadNibNamed:@"ComedyCell" owner:self options:nil]lastObject];
        }
        
        [comedyCell.picImageView setImageWithURL:[NSURL URLWithString:model.pic]];
        [comedyCell.titleLabel setText:model.title];
        [comedyCell.introLabel setText:model.intro];
        [comedyCell.commentLabel setText:[NSString stringWithFormat:@"%@", [model.comment_count_info objectForKey:@"total"]]];
        if ([model.category isEqualToString:@"video"]) {
            [comedyCell.cateGroyImageView setImage:[UIImage imageNamed:@"video"]];
            [comedyCell.cateGoryLabel setText:@"视频"];
            [comedyCell.cateGoryLabel setTextColor:[UIColor colorWithRed:35.0/255 green:120.0/255 blue:250.0/255 alpha:1]];
        }else if ([model.category isEqualToString:@"subject"]){
            [comedyCell.cateGroyImageView setImage:[UIImage imageNamed:@"subject"]];
            [comedyCell.cateGoryLabel setText:@"专题"];
            [comedyCell.cateGoryLabel setTextColor:[UIColor redColor]];
        }else{
            [comedyCell.cateGroyImageView setImage:[UIImage imageNamed:@" "]];
            [comedyCell.cateGoryLabel setText:@" "];
        }
        cell=comedyCell;
    }
    return cell;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
