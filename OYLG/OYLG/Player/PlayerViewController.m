//
//  PlayerViewController.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "PlayerViewController.h"
#import "OYLG-Prefix.pch"
#import "BrightnessView.h"
#import "ProgressView.h"
#import "BarrageView.h"


@interface PlayerViewController () <ProgressViewDelegate, BrightnessViewDelegate, BarrageViewDelegate>
{
    ProgressView    *progressView;
    BrightnessView  *brightnessView;
    BarrageView     *barrageView;
}


@end

@implementation PlayerViewController

#pragma mark - 控制器视图方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    // 手势 亮度--进度--音量
    // 亮度
    brightnessView = [[BrightnessView alloc] init];
    [self.view addSubview:brightnessView];
    [self.view insertSubview:brightnessView aboveSubview:self.moviePlayer.view];
    brightnessView.delegate = self;
    
    // 快退--音量
    progressView = [[ProgressView alloc] init];
    [self.view addSubview:progressView];
    [self.view insertSubview:progressView aboveSubview:self.moviePlayer.view];
    progressView.delegate = self;
    
    // 弹幕
    barrageView = [[BarrageView alloc] init];
    [self.view addSubview:barrageView];
    [self.view insertSubview:barrageView aboveSubview:progressView];
    barrageView.delegate = self;
    
    // 播放
    [self.moviePlayer play];
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(changeText:) userInfo:nil repeats:YES];
    
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

#pragma mark - 手势代理方法
// 轻拍
- (void)tapAction {
    if (self.moviePlayer.playbackState == MPMoviePlaybackStatePaused) {
        [self.moviePlayer play];
        
    } else {
        [self.moviePlayer pause];
    }
}
// 进度
- (void)changeProgress:(ProgressView *)view {
    CGFloat max = view.frame.size.width;
    // 获取偏移值得到偏移比例
    CGFloat d_gapX = (view.movePoint.x - view.startPoint.x);
    CGFloat d_gapY = (view.movePoint.y - view.startPoint.y);
    if (fabs(d_gapY) < fabs(d_gapX)) {
        if (_moviePlayer.duration ) {
            // 修改播放时间
            CGFloat addTime = d_gapX / max * 0.5 *_moviePlayer.duration;
            _moviePlayer.currentPlaybackTime += addTime;
            DLog(@"视频总长 : %.2f", _moviePlayer.duration);
            DLog(@"百分比 : %.2f", addTime / _moviePlayer.duration );
            DLog(@"addTime : %.2f", addTime);
        } else {
            if (d_gapX > 0) {
                // 快进三十秒
                _moviePlayer.currentPlaybackTime += 30.0f;
            } else {
                // 快退三十秒
                _moviePlayer.currentPlaybackTime -= 30.0f;
            }
            DLog(@"30'S");
        }
    }
    if (_moviePlayer.currentPlaybackTime <= 0) {
        _moviePlayer.currentPlaybackTime = 0;
    } else if (_moviePlayer.currentPlaybackTime > _moviePlayer.duration){
        _moviePlayer.currentPlaybackTime = _moviePlayer.duration;
    }
    
}

// 音量
- (void)adjustVolume:(ProgressView *)view direction:(UISwipeGestureRecognizerDirection)direction {
    
    CGFloat d_gapY = view.startPoint.y - view.movePoint.y;
    
    if (direction == UISwipeGestureRecognizerDirectionUp || direction ==UISwipeGestureRecognizerDirectionDown) {
        float volume = [[MPMusicPlayerController applicationMusicPlayer] volume];
        float newVolume = volume;
        if (d_gapY == 0) {
            
        } else if (d_gapY > 0) {
            newVolume += 0.1;
            DLog(@"调节音量+");
            
        } else if (d_gapY < 0) {
            newVolume -= 0.1;
            DLog(@"调节音量-");
        }
        if (newVolume < 0) {
            newVolume = 0;
        } else if (newVolume > 1.0) {
            newVolume = 1.0;
        }
        [[MPMusicPlayerController applicationMusicPlayer] setVolume:newVolume];
    }
}
  // 用swip加手势调节音量,每次手势只能是一个方向,还会滑动不被识别;
// 亮度
- (void)changeBrightness:(CGFloat)value {
    DLog(@"========%.2f", value);
    // 增加值
    CGFloat addValue = (int)value / 200.0;
    DLog(@"addValue%.2f", addValue);
    if (addValue > 0) {
        // 当前屏幕亮度
        float value = [UIScreen mainScreen].brightness + addValue;
        DLog(@"亮度:%.2f", [UIScreen mainScreen].brightness);
        // 设置系统屏幕的亮度值
        [[UIScreen mainScreen] setBrightness:value];
        float value1 = [UIScreen mainScreen].brightness;
        DLog(@"亮度++:%.2f", value1);
    } else {
        // 当前屏幕亮度
        float value = [UIScreen mainScreen].brightness + addValue;
        DLog(@"亮度:%.2f", [UIScreen mainScreen].brightness);
        // 设置系统屏幕的亮度值
        [[UIScreen mainScreen] setBrightness:value];
        float value1 = [UIScreen mainScreen].brightness;
        DLog(@"亮度--:%.2f", value1);
    }
    
}
- (void)sonViewTouchDownPoint: (CGPoint)touchPoint from:(id)sender {

}
- (void)changeText:(id)sender {
    barrageView.barrageLabel.text = [NSString stringWithFormat:@"%f",self.moviePlayer.currentPlaybackTime];
    CGRect laberRect = [barrageView.barrageLabel.text boundingRectWithSize:CGSizeMake(1000, 25) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]} context:nil];
    DLog(@"labelWidth%.2f", laberRect.size.width);
    barrageView.barrageLabel.frame = CGRectMake(0, 0, laberRect.size.width, barrageView.frame.size.height);
        DLog(@"text : %@", barrageView.barrageLabel.text);
}

@end
