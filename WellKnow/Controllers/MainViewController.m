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
#import "NewsNormalModel.h"
#import "DeviceManager.h"
#import "NewsInfoCell.h"
#import "UIImageView+WebCache.h"
#import "NewsDetailViewController.h"
@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_bottomTableDataArray;
    NSMutableArray *_middleDataArray;
    UITableView *_tableView;
}

@end

static NSString * const kRequestUrlString = @"http://api.sina.cn/sinago/list.json?channel=news_toutiao";

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareData];
    [self prepareUI];
    [self loadData];
}

- (void)prepareData{
    _bottomTableDataArray = [[NSMutableArray alloc]init];
    _middleDataArray = [[NSMutableArray alloc]init];
}

- (void)analyzeResult:(id)result {
    NSDictionary *dic = (NSDictionary *)[result objectForKey:@"data"];
    NSArray *listArray = dic[@"list"];
    for (NSDictionary *perDic in listArray) {
        NewsNormalModel *model = [[NewsNormalModel alloc]init];
        [model setValuesForKeysWithDictionary:perDic];
        if ([perDic valueForKey:@"is_focus"]) {
            [_middleDataArray addObject:model];
        }else{
            [_bottomTableDataArray addObject:model];
        }
    }
    [_tableView reloadData];
}

- (void)loadData{
    [[ETRequestManager sharedManager]requestUsingCache:YES TargetWithUrlString:kRequestUrlString requestType:HttpRequestTypeGET params:nil showWaitDialog:YES finised:^(id result) {
        [self performSelectorOnMainThread:@selector(analyzeResult:) withObject:result waitUntilDone:NO];
    } failed:^(id result) {
        
    }];
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
//    _tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableView];
    [self registerNibForTableView:@"TopIconCollectionCell"];
    [self registerNibForTableView:@"SliderImageTableViewCell"];
    [self registerNibForTableView:@"NewsInfoCell"];
}

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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return 1;
    }else if(1 == section){
        return 1;
    }else{
        return _bottomTableDataArray.count;
    }
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
    NewsNormalModel *model = _bottomTableDataArray[indexPath.row];
    CGSize size = [model.intro sizeToFont:[DeviceManager systemTextSize]-2 WithWidth:200];
    return 70-45+size.height>70?70-45+size.height:70;
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
    }else{
        NewsNormalModel *model = _bottomTableDataArray[indexPath.row];
        NewsInfoCell *mcell = [tableView dequeueReusableCellWithIdentifier:@"NewsInfoCell" forIndexPath:indexPath];
        [mcell.customImageView setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"error"]];
        
        mcell.customTitleLabel.text = model.title;
        [mcell.customTitleLabel fixToSystemTitleSizeWithMaxWidth:240];
        
        mcell.customDetailLabel.text = model.intro;
        [mcell.customDetailLabel fixToSystemSubTitleSizeWithMaxWidth:220];
        cell = mcell;
    }
    
    return cell;
}

#pragma mark - Table view delegate
#pragma mark 单元行被选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (2 == indexPath.section) {
        NewsDetailViewController *vc = [[NewsDetailViewController alloc]initWithModel:_bottomTableDataArray[indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //    取消反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
