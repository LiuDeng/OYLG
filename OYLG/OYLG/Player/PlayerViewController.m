//
//  PlayerViewController.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "PlayerViewController.h"
#import "OYLG-Prefix.pch"
#import "VolumeView.h"
#import "BrightnessView.h"
#import "ProgressView.h"

@interface PlayerViewController () <ProgressViewDelegate>
{
    ProgressView    *progressView;
}


@end

@implementation PlayerViewController

#pragma mark - 控制器视图方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    // 手势 音量--亮度--进度
    
    // 音量
    VolumeView *vV = [[VolumeView alloc] init];
    [self.view addSubview:vV];
    [self.view insertSubview:vV aboveSubview:self.moviePlayer.view];
    
    // 亮度
    BrightnessView *bV = [[BrightnessView alloc] init];
    [self.view addSubview:bV];
    [self.view insertSubview:bV aboveSubview:self.moviePlayer.view];
    
    // 快退
    progressView = [[ProgressView alloc] init];
    [self.view addSubview:progressView];
    [self.view insertSubview:bV aboveSubview:self.moviePlayer.view];
    progressView.delegate = self;
        
    // 播放
    [self.moviePlayer play];
    
    // 添加通知
    [self addNotification];
}

-(void)dealloc {
    // 移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 私有方法
-(NSURL *)getFileUrl {
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"1" ofType:@"MOV"];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSString * urlStr = _URLString;
    
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    urlStr = [urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer {
    if (!_moviePlayer) {
        NSURL *url=[self getNetworkUrl];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
//====================10.1
        // 播放器样式
        [_moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification {
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification {
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            [self.moviePlayer stop];
            
            break;
        default:
            NSLog(@"播放状态:%ld" ,self.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 屏幕旋转
//==================== 10.1
// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return YES;
}
// 支持屏幕方向
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeRight;
}
// 默认屏幕旋转
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

#pragma mark - 手势状态


#pragma mark - 手势代理方法
- (void)adjustProgress:(UISwipeGestureRecognizerDirection)direction {
    // 调节视频进度
    if (direction == UISwipeGestureRecognizerDirectionLeft) {
        DLog(@"调节视频进度快退");
        
    } else if (direction == UISwipeGestureRecognizerDirectionRight) {
        DLog(@"调节视频进度快进");
        self.moviePlayer.initialPlaybackTime += 30.0f;
    }
}


@end
