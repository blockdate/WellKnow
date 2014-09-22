//
//  photosViewController.m
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "photosViewController.h"
#import "NewsNormalModel.h"
#import "PhotosView.h"
#import "ETRequestManager.h"
#import "UIImageView+WebCache.h"
#import "PhotosListCell.h"
@interface photosViewController (){
    UITableView *_tableView;
    NSMutableArray *_dataArray;//顶部scrollView数据源
    NSMutableArray *_listDataArray;//顶部下方
    PhotosView *_photosView;
}

@end

@implementation photosViewController
#define kUrlString @"http://api.sina.cn/sinago/list.json?channel=hdpic_toutiao"

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
    [self addSimpleNavigationBackButton];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setNavgationBarTitle:@"图片"];//标题
    _dataArray=[[NSMutableArray alloc]init];
    _listDataArray =[[NSMutableArray alloc]init];
    _photosView=[[PhotosView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    //tableView
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,height) style:UITableViewStylePlain];
    _tableView.tableHeaderView=_photosView;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    [self loadData];//网络请求
}
#pragma mark -httpRequest
- (void)loadData{
    [[ETRequestManager sharedManager]requestWithUrlString:kUrlString requestType:HttpRequestTypeGET params:nil showWaitDialog:YES finised:^(id result) {
        //[result clearCaches];
        NSDictionary *dic=[(NSDictionary *)result objectForKey:@"data"];
        NSArray *list=dic[@"list"];
        for (NSDictionary *perDic in list) {
            NewsNormalModel *model=[[NewsNormalModel alloc]init];
            [model setValuesForKeysWithDictionary:perDic];
            if (model.is_focus) { //顶部
                [_dataArray addObject:[model.pics objectForKey:@"list"]];
                [_photosView sendDataArray:_dataArray[0]];
            }
            [_listDataArray addObject:model];//列表
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
    return _listDataArray.count/2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

#pragma mark -tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotosListCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"PhotosListCell"];
    if (listCell==nil) {
        listCell=[[[NSBundle mainBundle]loadNibNamed:@"PhotosListCell" owner:self options:nil]lastObject];
    }
    NewsNormalModel *model1=_listDataArray[indexPath.row*2];
    NewsNormalModel *model2=_listDataArray[indexPath.row*2+1];
    [listCell.titleLabelOne setText:model1.title];
    [listCell.titleLabelOne fixToSystemSubTitleSizeWithMaxWidth:100];
    [listCell.titleLabelTwo setText:model2.title];
    [listCell.titleLabelTwo fixToSystemSubTitleSizeWithMaxWidth:100];
    [listCell.ImageViewOne setImageWithURL:[NSURL URLWithString:model1.pic]];
    [listCell.ImageViewTwo setImageWithURL:[NSURL URLWithString:model2.pic]];
    return listCell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
