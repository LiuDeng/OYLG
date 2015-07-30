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
    
    self.tag = kProgressViewTag;
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(150, 50, kScreenHeight - 150, kScreenWidth - 100);
    // 添加手势
    [self p_addGestureRecognizer];
    
   
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 手指第一次接触到的位置
    UITouch *touch = [touches anyObject];
    _startPoint = [touch locationInView:self.superview];
    DLog(@"Progress%@", NSStringFromCGPoint(_startPoint));
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // 手指每次接触到的位置
    UITouch *touch = [touches anyObject];
    _movePoint = [touch locationInView:self.superview];
    DLog(@"Progress%@", NSStringFromCGPoint(_movePoint));
    float gapYValue = _startPoint.y - _movePoint.y;
    DLog(@"Progress%.2f", gapYValue);
    
}

- (void)p_addGestureRecognizer {
    // 向左滑动--快退
    UISwipeGestureRecognizer *progressRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(progressActionLeft:)];
    progressRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:progressRecognizerLeft];
    // 向右滑动--快进
    UISwipeGestureRecognizer *progressRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(progressActionRight:)];
    progressRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:progressRecognizerRight];
    
    // 向上滑动--音量+
    UISwipeGestureRecognizer *volumRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self     action:@selector(progressActionUp:)];
    volumRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:volumRecognizerUp];
    
    // 向下滑动--音量-
    UISwipeGestureRecognizer *volumRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(progressActionDown:)];
    volumRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:volumRecognizerDown];
    

}
#pragma mark -- 手势响应方法
- (void)progressActionLeft:(UISwipeGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(adjustProgress:direction:)]) {
        [self.delegate adjustProgress:self direction:(UISwipeGestureRecognizerDirectionLeft)];
        DLog(@"<--%lu", (unsigned long)sender.direction);
    }
    
}
- (void)progressActionRight:(UISwipeGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(adjustProgress:direction:)]) {
    [self.delegate adjustProgress:self direction:(UISwipeGestureRecognizerDirectionRight)];
    DLog(@"-->%lu", (unsigned long)sender.direction);
    }
}
- (void)progressActionUp:(UISwipeGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(adjustProgress:direction:)]) {
        [self.delegate adjustProgress:self direction:(UISwipeGestureRecognizerDirectionUp)];
        DLog(@"^%lu", (unsigned long)sender.direction);
    }
}
- (void)progressActionDown:(UISwipeGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(adjustProgress:direction:)]) {
        [self.delegate adjustProgress:self direction:(UISwipeGestureRecognizerDirectionDown)];
        DLog(@";%lu", (unsigned long)sender.direction);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
