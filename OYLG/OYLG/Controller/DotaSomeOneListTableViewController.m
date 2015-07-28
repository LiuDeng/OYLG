//
//  PlayerProgramListTableViewController.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DotaSomeOneListTableViewController.h"
#import "DotaSomeOneProgramListModel.h"
#import "PlayerProgramDetailViewController.h"
#import "PlayerlListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "OYLG-Prefix.pch"
#import "MBProgressHUD.h"
#import "PullTableView.h"

@interface DotaSomeOneListTableViewController ()<PullTableViewDelegate>
@property(nonatomic,strong)NSMutableArray * dataArray;

// 小菊花
@property (nonatomic,retain) MBProgressHUD * hud;

// 上拉加载数据
@property(nonatomic,strong)PullTableView * pullTableView;
@end

@implementation DotaSomeOneListTableViewController

-(void)loadView
{
    self.pullTableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-20 - 44 -49)];
    self.tableView = _pullTableView;
}

- (void)viewDidAppear:(BOOL)animated {
    //=================================
    // 移除界面
    if ([self.view.subviews[0] tag] == 300) {
        [self.view.subviews[0] removeFromSuperview];
    }

    // Dota界面背景图
    UIImageView *backgroudImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backgroudImg.image = [UIImage imageNamed:@"background"];
    UIView *alphView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    alphView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [backgroudImg addSubview:alphView];
    [self.navigationController.view addSubview:backgroudImg];
    [self.navigationController.view sendSubviewToBack:backgroudImg];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    
    // 界面出现之后,加载数据,菊花已经飞起.
    [self loadData:_aId];
    [_hud removeFromSuperview];
    //=================================
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 注册 cell 之类的东西.
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayerlListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    // 重写左按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonAction:)];
    
    [self p_setupProgressHud];
    
    self.pullTableView.dataSource = self;
    self.pullTableView.delegate = self;
    self.pullTableView.pullDelegate = self;
    self.pullTableView.pullArrowImage = [UIImage imageNamed:@"whiteArrow@2x"];
    self.pullTableView.pullBackgroundColor = [UIColor clearColor];
    self.pullTableView.pullTextColor = [UIColor whiteColor];
}

#pragma mark创建小菊花
- (void)p_setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}


#pragma mark请求数据并且刷新 cell.
-(void)loadData:(NSString *)aId
{
    _dataArray = [DotaSomeOneProgramListModel loadDotaSomeOneProgramList:aId];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

#pragma mark tableview的代理方法.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerlListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"    forIndexPath:indexPath];
    
    [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:[_dataArray[indexPath.row] thumb]] placeholderImage:[UIImage imageNamed:@"0"]];
    cell.nameLabel.text = [_dataArray[indexPath.row] title];
    cell.nameLabel.numberOfLines = 0;
    
    cell.detailLabel.text = [_dataArray[indexPath.row] date];

    // cell选中时的样式
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor blackColor];
    cell.selectedBackgroundView.alpha = 0.8;

    return cell;
}

// 选中 cell 的动作.
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerProgramDetailViewController * detailVC = [[PlayerProgramDetailViewController alloc] init];
    detailVC.detailData = _dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

// 实现返回按钮
-(void) leftBarButtonAction:(UIBarButtonItem * )sender
{
    if ([_aId isEqualToString:@"hot"] || [_aId isEqualToString:@"all"]) {
        self.block();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark开始上拉加载数据的代理方法.
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
     self.pullTableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 20 - 44 - 49);
    
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}
- (void)refreshTable
{
    [self loadData:_aId];
    self.pullTableView.pullLastRefreshDate = [NSDate date];
    self.pullTableView.pullTableIsRefreshing = NO;
}

// 上拉加载数据.
- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    self.pullTableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-20 - 44 -49);
    [self loadData:_aId];
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}

- (void)loadMoreDataToTable
{
    static NSInteger offset = 50;
    NSMutableArray * tmp = [DotaSomeOneProgramListModel loadDotaSomeOneProgramListMoreData:_aId index:offset];
    [_dataArray addObjectsFromArray:tmp];
    [self.pullTableView reloadData];
    offset += 50;
    self.pullTableView.pullTableIsLoadingMore = NO;
}

@end
