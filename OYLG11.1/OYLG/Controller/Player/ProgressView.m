//
//  ProgressView.m
//  OYLG
//
//  Created by 欧阳娇龙 on 15/7/30.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "ProgressView.h"
#import "OYLG-Prefix.pch"
#import "PlayerViewController.h"

@interface ProgressView ()

@end

@implementation ProgressView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView {
    
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(150, 50, kScreenHeight - 150, kScreenWidth - 100);
    // 添加手势
    [self p_addGestureRecognizer];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 手指第一次接触到的位置
    UITouch *touch = [touches anyObject];
    _startPoint = [touch locationInView:self.superview];
    DLog(@"Progress开始%@", NSStringFromCGPoint(_startPoint));
    
    UITouch * touchTap = [touches anyObject];
    CGPoint touchPoint = [touchTap locationInView:self];
    [self.delegate sonViewTouchDownPoint: touchPoint from:self];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // 手指每次接触到的位置
    UITouch *touch = [touches anyObject];
    _movePoint = [touch locationInView:self.superview];
    DLog(@"Progress移动%@", NSStringFromCGPoint(_movePoint));
    [self.delegate changeProgress:self];
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    DLog(@"touch结束");
}

- (void)p_addGestureRecognizer {
    
//    // 轻拍1弹出菜单
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//    tap.numberOfTapsRequired = 1;
//    [self addGestureRecognizer:tap];
    
    // 轻拍2暂停/播放
    UITapGestureRecognizer *progressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(progressTapAction:)];
    progressTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:progressTap];
    
    // 向上滑动--音量+
    UISwipeGestureRecognizer *volumRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self     action:@selector(volumActionUp:)];
    volumRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:volumRecognizerUp];
    
    // 向下滑动--音量-
    UISwipeGestureRecognizer *volumRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(volumActionDown:)];
    volumRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:volumRecognizerDown];
    
}

#pragma mark -- 手势响应方法
- (void)volumActionUp:(UISwipeGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(adjustVolume:direction:)]) {
        [self.delegate adjustVolume:self direction:(UISwipeGestureRecognizerDirectionUp)];
        DLog(@"^%lu", (unsigned long)sender.direction);
    }
}
- (void)volumActionDown:(UISwipeGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(adjustVolume:direction:)]) {
        [self.delegate adjustVolume:self direction:(UISwipeGestureRecognizerDirectionDown)];
        DLog(@";%lu", (unsigned long)sender.direction);
    }
}
- (void)progressTapAction:(UITapGestureRecognizer *)sender {
    [self.delegate tapAction];
    DLog(@"Tap2");
}
//- (void)tapAction:(UITapGestureRecognizer *)sender {
//    [self.delegate tapOneAction];
//    DLog(@"Tap2");
//}


@end
