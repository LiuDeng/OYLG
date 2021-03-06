//
//  LOLSomeOneListTableViewController.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "LOLSomeOneListTableViewController.h"
#import "LOLSomeOneProgramListModel.h"
#import "PlayerProgramDetailViewController.h"
#import "PlayerlListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "OYLG-Prefix.pch"
#import "PullTableView.h"

@interface LOLSomeOneListTableViewController ()<PullTableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataArray;

// 小菊花
@property (nonatomic,retain) MBProgressHUD * hud;

// 上拉加载数据
@property(nonatomic,strong)PullTableView * pullTableView;

@end

@implementation LOLSomeOneListTableViewController

#pragma mark ==== 视图出现前
-(void)loadView {
    // navigation View 原点
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // 替换tableView
    self.pullTableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 20 - 44 - 49)];
    self.tableView = _pullTableView;
    
    //=================================
    // 设置tableView出现时的背景图 (为了解决页面跳转是出现卡顿现象)
    backgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, - 64, kScreenWidth, kScreenHeight)];
    backgroundImgView.image = [UIImage imageNamed:@"lol2.jpg"];
    UIView *alphView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    alphView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [backgroundImgView addSubview:alphView];
    self.tableView.backgroundView = backgroundImgView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //=================================
}
// 视图将要出现
- (void)viewDidAppear:(BOOL)animated {
    
    // 移除tableView.bacbroundView图显示navigation.View.backgroundView
    self.pullTableView.backgroundView = nil;
    
    // 设置
    self.tableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //=================================

    
    // 界面出现之后,加载数据,菊花已经飞起.
    if (_dataArray != nil) {
        return;
    }
    [self loadData:_aId];
    [_hud removeFromSuperview];
}
#pragma mark ==== 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册 cell 之类的东西.
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayerlListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    // 重写左按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonAction:)];
    
    // 下拉刷新
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(RefreshAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    
    [self p_setupProgressHud];
    
    
    
    self.pullTableView.dataSource = self;
    self.pullTableView.delegate = self;
    self.pullTableView.pullDelegate = self;
    self.pullTableView.pullArrowImage = [UIImage imageNamed:@"whiteArrow@2x"];
    self.pullTableView.pullBackgroundColor = [UIColor clearColor];
    self.pullTableView.pullTextColor = [UIColor whiteColor];
    
}
#pragma mark ==== 数据加载与刷新
// 创建小菊花方法.
- (void)p_setupProgressHud {
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}
// 加载数据
-(void)loadData:(NSString *)aId {
    _dataArray = [LOLSomeOneProgramListModel loadLOLSomeOneProgramList:aId];
    [self.tableView reloadData];
}
// 下拉刷新处理方法.
-(void)RefreshAction:(id)sender {
    [self loadData:_aId];
    [self.refreshControl endRefreshing];
}
#pragma mark ==== 上拉 代理方法
// 加载跟多数据
- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView {
    self.pullTableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-20 - 44 -49);
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}
// @selector方法
- (void)loadMoreDataToTable {
    static NSInteger offset = 50;
    NSMutableArray * tmp = [LOLSomeOneProgramListModel loadLOLSomeOneProgramListMoreData:_aId index:offset];
    [_dataArray addObjectsFromArray:tmp];
    [self.pullTableView reloadData];
    offset += 50;
    self.pullTableView.pullTableIsLoadingMore = NO;
}
// 刷新页面
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView {
    self.pullTableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 20 - 44 - 49);
    
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}
// @selector方法
- (void)refreshTable {
    [self loadData:_aId];
    self.pullTableView.pullLastRefreshDate = [NSDate date];
    self.pullTableView.pullTableIsRefreshing = NO;
}
#pragma mark ==== 点击事件
// 实现 navigation 返回按钮
-(void) leftBarButtonAction:(UIBarButtonItem * )sender {
    if ([_aId isEqualToString:@"hot"] || [_aId isEqualToString:@"all"]) {
        self.block();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ==== tableview 的代理方法
// 多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
// 返回Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerlListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"    forIndexPath:indexPath];
    
    [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:[_dataArray[indexPath.row] thumb]] placeholderImage:[UIImage imageNamed:@"0"]];
    cell.nameLabel.text = [_dataArray[indexPath.row] title];
    cell.nameLabel.numberOfLines = 0;
    
    cell.detailLabel.text = [_dataArray[indexPath.row] date1];
    cell.videoTimeLabel.alpha = 0.8;
    cell.videoTimeLabel.text = [_dataArray[indexPath.row] time];
    
    // cell选中时的样式
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor blackColor];
    cell.selectedBackgroundView.alpha = 0.8;
    
    //去掉每个cell之间的分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
}
// 选中 cell 的动作.
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerProgramDetailViewController * detailVC = [[PlayerProgramDetailViewController alloc] init];
    detailVC.detailData = _dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}
// Cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
#pragma mark ==== 内存警告
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

@end
