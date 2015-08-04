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

@interface PlayerProgramDetailViewController ()

@end

@implementation PlayerProgramDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoTitle.text = _detailData.title;
    self.videoTitle.numberOfLines =0;
    
    [self.thumImage sd_setImageWithURL: [NSURL URLWithString:_detailData.thumb] placeholderImage:[UIImage imageNamed:@"0"]];

    self.Dtime.text = _detailData.time;
    self.Dtime.textAlignment = NSTextAlignmentCenter;

    self.UpdateTime.text = _detailData.date1;
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}

-(void)leftAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

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
- (IBAction)downLoadAction:(id)sender {
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
