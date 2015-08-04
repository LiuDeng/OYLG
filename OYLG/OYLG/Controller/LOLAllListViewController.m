//
//  LOLAllListViewController.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "LOLAllListViewController.h"
#import "PlayerList.h"
#import "OYLG-Prefix.pch"
#import "LOLAllListModel.h"
#import "LOLSomeOneListTableViewController.h"
#import "PlayerlListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

@interface LOLAllListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)PlayerList * rv;
@property(nonatomic,strong)NSMutableArray * dataArray;

// 下拉刷新.
@property (nonatomic, strong) UIRefreshControl* playerRefreshControl;
@property (nonatomic, strong) UIRefreshControl* eventRefreshControl;

// 小菊花
@property (nonatomic,retain) MBProgressHUD * hud;
@end

@implementation LOLAllListViewController

#pragma mark ==== 视图出现前
-(void)loadView {
    // 替换根视图
    self.rv = [[PlayerList alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _rv;
    //=================================
    // 设置navigation的背景图
    backgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kNavigationFrame.size.height)];
    backgroundImgView.image = [UIImage imageNamed:@"lol2.jpg"];
    UIView *alphView = [[UIView alloc] initWithFrame:kScreenFrame];
    alphView.backgroundColor = kBackbroundColorAlpha;
    [backgroundImgView addSubview:alphView];
    [self.navigationController.view addSubview:backgroundImgView];
    [self.navigationController.view sendSubviewToBack:backgroundImgView];
    //=================================
}
// 视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    
    if (self.rv.mainScroll.contentOffset.x == 0) {
        self.rv.seg.selectedSegmentIndex = 0;
    } else {
        self.rv.seg.selectedSegmentIndex = 1;
    }
    
}
// 视图已经出现
-(void) viewDidAppear:(BOOL)animated
{
    // 加载数据.
    if (_dataArray != nil) {
        return;
    }
    [self loadData];
    [_hud removeFromSuperview];
}

#pragma mark ==== 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 在navigationItem加上segementcontrol
    self.navigationItem.titleView = self.rv.seg;
    [self.rv.seg addTarget:self action:@selector(segAction:) forControlEvents:(UIControlEventValueChanged)];
    
    // 设置navigation原点
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // 将这两个 tableview 的代理都设置成自己.
    self.rv.playerTableView.dataSource = self;
    self.rv.playerTableView.delegate = self;
    self.rv.eventTableView.dataSource = self;
    self.rv.eventTableView.delegate = self;
    
    // 注册
    [self.rv.playerTableView registerNib:[UINib nibWithNibName:@"PlayerlListTableViewCell" bundle:nil] forCellReuseIdentifier:@"player"];
    [self.rv.eventTableView registerNib:[UINib nibWithNibName:@"PlayerlListTableViewCell" bundle:nil] forCellReuseIdentifier:@"event"];
    
    // 下拉刷新.
    self.playerRefreshControl = [[UIRefreshControl alloc]  init];
    [_playerRefreshControl addTarget:self action:@selector(playerRefreshAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.rv.playerTableView addSubview:_playerRefreshControl];
    
    self.eventRefreshControl = [[UIRefreshControl alloc] init];
    [_eventRefreshControl addTarget:self action:@selector(eventRefreshAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.rv.eventTableView addSubview:_eventRefreshControl];
    
    [self p_setupProgressHud];
}
#pragma mark ==== 刷新数据
// 加载数据重新布局.
-(void)loadData {
    self.dataArray = [LOLAllListModel loadLOLAllList];
    [self.rv.playerTableView reloadData];
    [self.rv.eventTableView reloadData];
}
// 刷新 所有解说.
-(void)playerRefreshAction:(id)sender
{
    [self loadData];
    [_playerRefreshControl endRefreshing];
}
// 刷新 热门
-(void)eventRefreshAction:(id)sender
{
    [self loadData];
    [_eventRefreshControl endRefreshing];
}
// 小菊花.
- (void)p_setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}
#pragma mark ==== 点击事件
// 选中 segment 的动作.
-(void)segAction:(UISegmentedControl * )sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.rv.mainScroll.contentOffset = CGPointMake(kScreenWidth * sender.selectedSegmentIndex, 0);
    }];
}
#pragma mark ==== tableview 的代理方法
// 返回每组有多少行.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 119) {
        return _dataArray.count - 2;
    }else {
        if (_dataArray.count == 0) {
            return 0;
        }
        return 2;
    }
}
// 返回 cell.
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 119) {
        PlayerlListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"player"];
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:[_dataArray[indexPath.row+2] icon]] placeholderImage:[UIImage imageNamed:@"0"]];
        cell.nameLabel.text = [_dataArray[indexPath.row+2] name];
        cell.detailLabel.text = [_dataArray[indexPath.row+2] detail];
        
        cell.userImageView.layer.cornerRadius = 10;
        cell.userImageView.layer.masksToBounds = YES;
        
        // cell选中时的样式
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor blackColor];
        cell.selectedBackgroundView.alpha = 0.8;
        
        return cell;
    }else {
        PlayerlListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"event"];
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:[_dataArray[indexPath.row] icon]] placeholderImage:[UIImage imageNamed:@"0"]];
        cell.nameLabel.text = [_dataArray[indexPath.row] name];
        cell.detailLabel.text = [_dataArray[indexPath.row] detail];
        
        // cell选中时的样式
        cell.userImageView.layer.cornerRadius = 10;
        cell.userImageView.layer.masksToBounds = YES;
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor blackColor];
        cell.selectedBackgroundView.alpha = 0.8;
        
        return cell;
    }
}
// 选中 cell 的方法.
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOLSomeOneListTableViewController * playerProgramListVC = [[LOLSomeOneListTableViewController alloc] init];
    
    if (tableView.tag == 119) {
        playerProgramListVC.aId = [_dataArray[indexPath.row+2] id];
        
    }else {
        playerProgramListVC.aId = [_dataArray[indexPath.row] id];
        playerProgramListVC.block = ^(){
            _rv.seg.selectedSegmentIndex = 1;
            _rv.mainScroll.contentOffset = CGPointMake(kScreenWidth, 0);
        };
    }
    
    [self.navigationController pushViewController:playerProgramListVC animated:YES];
}
// Cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
#pragma mark ==== 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
