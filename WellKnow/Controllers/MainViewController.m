//
//  ViewController.m
//  WellKnow
//
//  Created by block on 14-9-19.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "MainViewController.h"
#import "photosViewController.h"
#import "ETRequestManager.h"
#import "TopIconCollectionCell.h"
#import "SliderImageTableViewCell.h"
@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
}

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareData];
    [self prepareUI];
    [self loadData];
}

- (void)prepareData{
    _dataArray = [NSMutableArray alloc];
}

- (void)loadData{
    
}

- (void)prepareUI{
    [self prepareNavItems];
    [self prepareTableView];
}

- (void)prepareNavItems{
    [self setNavgationBarTitle:@"首页"];
}

- (void)registerNibForTableView:(NSString *)st {
    UINib *nib = [UINib nibWithNibName:st bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:st];
}

- (void)prepareTableView{
    if (IsIOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, [UIScreen mainScreen].applicationFrame.size.height-64+20) style:UITableViewStyleGrouped];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableView];
    [self registerNibForTableView:@"TopIconCollectionCell"];
    [self registerNibForTableView:@"SliderImageTableViewCell"];
}

#pragma mark -
#pragma mark 点击事件
//顶部九宫格按钮点击
- (void)topIconClick:(UIButton *)sender{
    NSInteger index = sender.tag-100;
    NSString *controllerName = [self getTopIconDestControllerArray][index];
    UIViewController *vc = [[NSClassFromString(controllerName)alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
//    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return 5;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (0 == section) {
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return 150;
    }else if(1 == indexPath.section){
        return 90;
    }
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    if (0 == indexPath.section) {
        TopIconCollectionCell *mcell = [tableView dequeueReusableCellWithIdentifier:@"TopIconCollectionCell" forIndexPath:indexPath];
        [mcell addTarget:self Selector:@selector(topIconClick:)];
        [mcell setIconImageArray:[self getTopIconNameArray]];
        cell = mcell;
    }else if(1 == indexPath.section){
        SliderImageTableViewCell *mcell = [tableView dequeueReusableCellWithIdentifier:@"SliderImageTableViewCell" forIndexPath:indexPath];
        cell = mcell;
    }
    
    return cell;
}
#pragma mark -
#pragma mark private method
- (NSArray *)getTopIconNameArray{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"categorys" ofType:@"plist"]];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [resultArray addObject:dic[@"iconName"]];
    }
    return resultArray;
}

- (NSArray *)getTopIconDestControllerArray{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"categorys" ofType:@"plist"]];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [resultArray addObject:dic[@"controllerName"]];
    }
    return resultArray;
}
@end
