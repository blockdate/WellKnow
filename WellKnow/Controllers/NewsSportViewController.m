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
#import "NewsDetailViewController.h"

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
    //_urlString = @"http://192.168.88.8/JudgeOnline-new/api.php?uid=8198&pid=3780&page=1";
    //_urlString = @"http://192.168.88.8/JudgeOnline-new/api.php?uid=8198&pid=3780&page=1";
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
        CGFloat hight = [l currentSizeWithFont:13 MaxWidth:280].height + 182+10;
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
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        NewsStyleYmOnePicCell *oneCell = [_tableView dequeueReusableCellWithIdentifier:@"One"];
        if (oneCell == nil) {
            oneCell = [[NewsStyleYmOnePicCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"One"];
        }
        NewsNormalModel *model = [_dataArray objectAtIndex:indexPath.row];
        
        [oneCell configUIWithModel:model];
        cell = oneCell;
    } else
        
        if (indexPath.row == 1) {
            if (_dataArray.count>5) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (int i = 0; i<4; i++) {
                    NewsNormalModel *model = [_dataArray objectAtIndex:i+1];
                    [array addObject:model];
                }
                NewsStyleYmFourPicCell *fourCell = [_tableView dequeueReusableCellWithIdentifier:@"Four"];
                if (fourCell == nil) {
                    fourCell = [[NewsStyleYmFourPicCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Four"];
                    fourCell.delegate = self;
                }
                [fourCell configCell:array];
                cell = fourCell;
            }
        }
        else
        {
            //一般的cell显示
            NewsStyleYmNormalCell *normalCell = [_tableView dequeueReusableCellWithIdentifier:@"Normal"];
            if (normalCell == nil) {
                normalCell = [[NewsStyleYmNormalCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Normal"];
            }
            NewsNormalModel *model = [_dataArray objectAtIndex:indexPath.row+3];
            [normalCell configCell:model];
            cell = normalCell;
        }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"index.row %d",indexPath.row);
    if (indexPath.row != 1) {
        NewsNormalModel *model ;
        if (indexPath.row == 0) {
            model = [_dataArray objectAtIndex:indexPath.row];
        }
        else{
            model = [_dataArray objectAtIndex:indexPath.row + 3];
        }
        [self sendModel:model];
    }
}
#pragma mark Four delegate

- (void)sendModel:(NewsNormalModel *)model{
    NewsDetailViewController *detail = [[NewsDetailViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
