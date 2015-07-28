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


@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    // navigationBar 颜色
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
   
    
    
    // DOTA界面
    DotaAllListViewController * DotaPlayerListVC = [[DotaAllListViewController alloc] init];
    UINavigationController * DotaPlayerListNC = [[UINavigationController alloc] initWithRootViewController:DotaPlayerListVC];
    

    // LOL的界面.
    LOLAllListViewController * LOLPlayerListVC = [[LOLAllListViewController alloc] init];
    UINavigationController * LOLPlayerListNC = [[UINavigationController alloc] initWithRootViewController:LOLPlayerListVC];
    
    
    self.viewControllers =@[DotaPlayerListNC,LOLPlayerListNC];

    DotaPlayerListNC.tabBarItem.title = @"DOTA";
    LOLPlayerListNC.tabBarItem.title = @"LOL";
}

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
