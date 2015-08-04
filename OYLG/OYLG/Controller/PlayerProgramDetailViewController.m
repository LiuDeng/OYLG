//
//  PlayProgramDetailViewController.m
//  布局
//
//  Created by 欧阳娇龙 on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "PlayerProgramDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "DotaVideoURLModel.h"
#import "PlayerViewController.h"
#import "DownLoadTaskRegist.h"
#import "OYLG-Prefix.pch"
#import <AVOSCloud/AVOSCloud.h>

@interface PlayerProgramDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation PlayerProgramDetailViewController

#pragma mark ==== 视图已出现
- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoTitle.text = _detailData.title;
    self.videoTitle.numberOfLines =0;
    
    [self.thumImage sd_setImageWithURL: [NSURL URLWithString:_detailData.thumb] placeholderImage:[UIImage imageNamed:@"0"]];

    self.Dtime.text = _detailData.time;
    self.Dtime.textAlignment = NSTextAlignmentCenter;

    self.UpdateTime.text = _detailData.date1;
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"下载" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    // 评论- tableView 代理
    self.commentsTableView.delegate = self;
    self.commentsTableView.dataSource = self;
    // tableView 注册
    [self.commentsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"comments"];
    // 获取点赞数:
    [self getPraise];

}
#pragma mark ==== Navigation点击事件
-(void)leftAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//navigation 右button点击方法-- 下载
-(void)rightAction:(UIBarButtonItem *)sender {
    // 将这个 url 添加到下载列表.
    NSString * url = [DotaVideoURLModel loadDotaVideoURL:_detailData.id type:@"flv"];
    if (url == nil ) {
        return;
    }
    // 在下载功能中增加一个 url 下载任务.
    // 将这个页面的 _detailData 和 url 入库.
    DownLoadTaskRegist * downLoadTask = [[DownLoadTaskRegist alloc] init];
    [downLoadTask addDownLoadTask:url info:_detailData withType:@"Dota"];
    
}
#pragma mark ==== Button点击事件
// 点赞
- (IBAction)thumbButtonAction:(id)sender {
    DLog(@"点赞");
    // 当前用户
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 允许用户使用应用
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // 用户评论表 Comment Praise
    // 用户 时间 视频的 id.(XMTI5MjIyMTM2OA==),这种东西.
    AVQuery *query = [AVQuery queryWithClassName:@"Praise"];
    [query whereKey:@"videoID" equalTo:self.detailData.id];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count != 0) {
            // 找到了这条记录.
            NSLog(@"找到该条记录,更新其点赞数.");
            ((AVObject *)objects[0]).fetchWhenSave = YES;
            [objects[0] incrementKey:@"upvotes"];
            [objects[0] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                // 这时候 post.upvotes 的值会是最新的
            }];
        } else {
            // 没有找到该条记录.
            NSLog(@"没有找到该条记录,重新生成一个");
            AVObject * praise = [AVObject objectWithClassName:@"Praise"];
            [praise setObject:[NSNumber numberWithInt:0] forKey:@"upvotes"]; //初始值为 0
            [praise setObject:self.detailData.id forKey:@"videoID"];
            [praise saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                // 增加点赞的人数
                [praise incrementKey:@"upvotes"];
                [praise saveInBackground];
            }];
        }
    }];
    
    [self getPraise];
    
}
// 收藏
- (IBAction)collectionButtonAction:(id)sender {
    
    DLog(@"收藏");

    
    
}
// 标清
- (IBAction)flvAction:(id)sender {
    // 由数据模型取请求数据.返回 URL.
    // 数据模型根据传入的 flv 和 _detailData 的 id 一起去请求一个 url.
    NSString * url = [DotaVideoURLModel loadDotaVideoURL:_detailData.id type:@"flv"];
    if (url == nil ) {
        return;
    }
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"WWANPlayAbility"] isEqualToString:@"NO"] && [[[NSUserDefaults standardUserDefaults] valueForKey:@"NetWorkStatus"] isEqualToString:@"ReachableViaWWAN"] ) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不允许在2g/3g/4g网络下观看视频,请到'我的->设置'中修改" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
    // 将 URL 传入播放器界面.
    PlayerViewController * player = [[PlayerViewController alloc] init];
    player.URLString = url;
    
    // push 播放器
    [self presentViewController:player animated:YES completion:nil];
}
// 高清
- (IBAction)mp4Action:(id)sender {
    // 由数据模型取请求数据.返回 URL.
    // 数据模型根据传入的 flv 和 _detailData 的 id 一起去请求一个 url.
    NSString * url = [DotaVideoURLModel loadDotaVideoURL:_detailData.id type:@"mp4"];
    if (url == nil ) {
        return;
    }
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"WWANPlayAbility"] isEqualToString:@"NO"] && [[[NSUserDefaults standardUserDefaults] valueForKey:@"NetWorkStatus"] isEqualToString:@"ReachableViaWWAN"] ) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不允许在2g/3g/4g网络下观看视频,请到'我的->设置'中修改" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
    // 将 URL 传入播放器界面.
    PlayerViewController * player = [[PlayerViewController alloc] init];
    player.URLString = url;
    
    // push 播放器
    [self presentViewController:player animated:YES completion:nil];
}
// 超清
- (IBAction)HDAction:(id)sender {
    // 由数据模型取请求数据.返回 URL.
    // 数据模型根据传入的 flv 和 _detailData 的 id 一起去请求一个 url.
    NSString * url = [DotaVideoURLModel loadDotaVideoURL:_detailData.id type:@"hd2"];
    if (url == nil ) {
        return;
    }
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"WWANPlayAbility"] isEqualToString:@"NO"] && [[[NSUserDefaults standardUserDefaults] valueForKey:@"NetWorkStatus"] isEqualToString:@"ReachableViaWWAN"] ) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不允许在2g/3g/4g网络下观看视频,请到'我的->设置'中修改" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
    // 将 URL 传入播放器界面.
    PlayerViewController * player = [[PlayerViewController alloc] init];
    player.URLString = url;
    
    // push 播放器
    [self presentViewController:player animated:YES completion:nil];
}
// 评论
- (IBAction)commentsAction:(id)sender {
    DLog(@"我要评论~~~");
    
    
}
#pragma mark ==== 私有方法
// 点赞
-(void)getPraise
{
    // 获取点赞数.
    AVQuery *query = [AVQuery queryWithClassName:@"Praise"];
    [query whereKey:@"videoID" equalTo:self.detailData.id];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count != 0) {
            // 找到了这条记录.
            NSLog(@"找到该条记录,从 button 上更新.");
            
            [self.thumbButton setTitle:[NSString stringWithFormat:@"%@",[objects[0] valueForKey:@"upvotes"]] forState:(UIControlStateNormal)];
        } else {
            // 没有找到该条记录.
            NSLog(@"没有找到该条记录,点赞数赋值为0");
            [self.thumbButton setTitle:@"0" forState:(UIControlStateNormal)];
        }
    }];
}


#pragma mark ==== tableView代理方法
// 多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
// 返回Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comments" forIndexPath:indexPath];
    
    cell.textLabel.text = @"test";
    return cell;
}

#pragma mark ==== 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
