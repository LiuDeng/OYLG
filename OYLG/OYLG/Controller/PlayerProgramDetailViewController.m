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
#import "AppDelegate.h"

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

    self.UpdateTime.text = _detailData.date;
}
- (IBAction)flvAction:(id)sender {
    // 由数据模型取请求数据.返回 URL.
    // 数据模型根据传入的 flv 和 _detailData 的 id 一起去请求一个 url.
    NSString * url = [DotaVideoURLModel loadDotaVideoURL:_detailData.id type:@"flv"];
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
    // 将 URL 传入播放器界面.
    PlayerViewController * player = [[PlayerViewController alloc] init];
    player.URLString = url;
    
    //找到入口类
    player.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    //通过入口类的ViewController调用present方法
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    
  
    [appDelegate.window.rootViewController presentViewController:player animated:YES completion:nil];
    // push 播放器
//    [self presentViewController:player animated:YES completion:nil];
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
