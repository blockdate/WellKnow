//
//  NewsSportViewController.m
//  WellKnow
//
//  Created by qianfeng on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "NewsSportViewController.h"
#import "DeviceManager.h"

#import "NewsNormalModel.h"
#import "NewsStyleYmFourPicCell.h"
#import "NewsStyleYmOnePicCell.h"
#import "ETRequestManager.h"
#import "NewsStyleYmNormalCell.h"
#import "UILabel+ETTools.h"
#import "UIViewController+NavigationItemSettingTool.h"
#import "DeviceManager.h"
@interface NewsSportViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;

}
@end

@implementation NewsSportViewController

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
    
    [self configNavBar];

    _dataArray = [[NSMutableArray alloc]  init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [DeviceManager screenHeight])];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    [self setUrl];
    [self loadData];
}
- (void)setUrl{
    _urlString = @"http://api.sina.cn/sinago/list.json?channel=news_sports";
}
- (void)configNavBar{
    [self setNavgationBarTitle:@"体育"];
    [self addSimpleNavigationBackButton];
}

- (void)loadData{
    
    [[ETRequestManager sharedManager] requestWithUrlString:_urlString requestType:(HttpRequestTypeGET) params:nil showWaitDialog:YES finised:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        NSDictionary *modelDic = [dic objectForKey:@"data"];
        NSArray *array = [modelDic objectForKey:@"list"];
        
        for (NSDictionary *modelDict in array) {
            NewsNormalModel *model = [[NewsNormalModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDict];
            if(model.pic.length == 0||model.title.length == 0 ||model.intro.length == 0){
            }else{
                [_dataArray addObject:model];
            }
        }
        [_tableView reloadData];
        
    } failed:^(id result) {
        ETLog(@"error");
    }];
}

#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger i = indexPath.row;
    if (i == 0) {
        NewsNormalModel *model = [_dataArray objectAtIndex:0];
        UILabel *l = [[UILabel alloc] init];
        l.text = model.intro;
        CGFloat hight = [l currentSizeWithFont:13 MaxWidth:280].height + 182;
        return hight;
    }
    else
        if(i ==1){
            return 230;
        }
        else{
            return 74;
        }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count-3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NewsStyleYmOnePicCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"One"];
        if (cell == nil) {
            cell = [[NewsStyleYmOnePicCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"One"];
        }
        NewsNormalModel *model = [_dataArray objectAtIndex:indexPath.row];
        
        [cell configUIWithModel:model];
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        if (_dataArray.count>5) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 0; i<4; i++) {
                NewsNormalModel *model = [_dataArray objectAtIndex:i+1];
                [array addObject:model];
            }
            

            NewsStyleYmFourPicCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Four"];
            if (cell == nil) {
                cell = [[NewsStyleYmFourPicCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Four"];
                cell.delegate = self;
            }
            [cell configCell:array];
            cell.userInteractionEnabled = NO;
            return cell;
            
        }
    }
    
    //一般的cell显示
    NewsStyleYmNormalCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Normal"];
    if (cell == nil) {
        cell = [[NewsStyleYmNormalCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Normal"];
    }
    NewsNormalModel *model = [_dataArray objectAtIndex:indexPath.row+3];
    
    [cell configCell:model];
    
    return cell;
    
    
}
#pragma mark Four delegate

- (void)sendModel:(NewsNormalModel *)model{
    NSLog(@"model title %@",model.title);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
