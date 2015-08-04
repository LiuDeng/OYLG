//
//  RootTabBarViewController.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "DotaAllListViewController.h"
#import "LOLAllListViewController.h"
#import "DownLoadTableViewController.h"
#import "SettingsTableViewController.h"
#import "OYLG-Prefix.pch"
#import "Reachability.h"
#import "DataBaseTool.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController
#pragma mark ==== 网络状态
// 程序一开始,登记当前网络状态.
-(void) checkNetWork
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    // 程序第一次执行默认不允许 wwan 网络播放视频.
    if ([[ud valueForKey:@"WWANPlayAbility"] isEqualToString:@""]) {
        [ud setValue:@"NO" forKey:@"WWANPlayAbility"];
    }
    // 检查网络状态并登记
    Reachability * ability = [Reachability reachabilityForInternetConnection];
    
    if (ability.currentReachabilityStatus == ReachableViaWiFi) {
        NSLog(@"ReachableViaWiFi");
        [ud setValue:@"ReachableViaWiFi" forKey:@"NetWorkStatus"];
        [ud synchronize];
    }else if (ability.currentReachabilityStatus == ReachableViaWWAN){
        NSLog(@"ReachableViaWWAN");
        [ud setValue:@"ReachableViaWWAN" forKey:@"NetWorkStatus"];
        [ud synchronize];
    }else {
        NSLog(@"NotReachable");
        [ud setValue:@"NotReachable" forKey:@"NetWorkStatus"];
        [ud synchronize];
    }
    
    // 网络状态改变之后的通知及事件.
    [ability startNotifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NetworkStatusChanged:) name:kReachabilityChangedNotification object:ability];
}
// 网络状态改变的处理事件
-(void) NetworkStatusChanged:(NSNotification *) sender {
    Reachability * ability = [sender object];
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if (ability.currentReachabilityStatus == ReachableViaWiFi) {
        [ud setValue:@"ReachableViaWiFi" forKey:@"NetWorkStatus"];
        [ud synchronize];
    }else if (ability.currentReachabilityStatus == ReachableViaWWAN){
        [ud setValue:@"ReachableViaWWAN" forKey:@"NetWorkStatus"];
        [ud synchronize];
        // 查看当前是否允许 3g网络 播放
        // 这里添加代码
    }else {
        [ud setValue:@"NotReachable" forKey:@"NetWorkStatus"];
        [ud synchronize];
        // 如果播放中断网.
        // 在这里添加代码.
    }
}
#pragma mark ==== 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];

    // 注册当前网络状态
    [self checkNetWork];
    
    // navigationBar 颜色
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:kBackbroundColorAlpha];

    // DOTA界面
    DotaAllListViewController * DotaPlayerListVC = [[DotaAllListViewController alloc] init];
    UINavigationController * DotaPlayerListNC = [[UINavigationController alloc] initWithRootViewController:DotaPlayerListVC];
    

    // LOL的界面.
    LOLAllListViewController * LOLPlayerListVC = [[LOLAllListViewController alloc] init];
    UINavigationController * LOLPlayerListNC = [[UINavigationController alloc] initWithRootViewController:LOLPlayerListVC];
    
    // 下载页面.
    DownLoadTableViewController * downLoadVC =[[DownLoadTableViewController alloc] init];
    UINavigationController * downLoadNC = [[UINavigationController alloc] initWithRootViewController:downLoadVC];
    
    //设置界面
    SettingsTableViewController *settingsVC = [[SettingsTableViewController alloc]init];
    UINavigationController *settingsNC = [[UINavigationController alloc]initWithRootViewController:settingsVC];
    
    self.viewControllers =@[DotaPlayerListNC,LOLPlayerListNC,downLoadNC,settingsNC];


    DotaPlayerListNC.tabBarItem.title = @"DOTA";
    LOLPlayerListNC.tabBarItem.title = @"LOL";
    downLoadNC.tabBarItem.title = @"缓存";
    settingsNC.tabBarItem.title = @"设置";

    
    [self initDataBase];
}
#pragma mark ==== 设备旋转方向
// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return NO;
}
// 支持屏幕方向
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
// 默认屏幕旋转
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark ==== 数据库
// 初始化数据库
-(void)initDataBase
{
    NSString * DocumentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString * dataBasePath = [DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
    DataBaseTool * db = [DataBaseTool shareDataBase];
    [db connectDB:dataBasePath];
//    [db execDDLSql:@"drop table DownLoadTaskTable"];
    [db execDDLSql:@"create table if not exists DownLoadTaskTable  (\
                                                sid integer primary key autoincrement not null, \
                                                thumb text,\
                                                author text,\
                                                title text,\
                                                time text,\
                                                date1 text,\
                                                id text,\
                                                url text,\
     status text,\
     totalFile integer,\
     curFileIndex integer,\
     offset interger)"];
    
    [db disconnectDB];
}
#pragma mark ==== 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
