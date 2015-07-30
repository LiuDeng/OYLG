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
{
    
    CGFloat     gapYValue;       // Y轴的位移
    CGPoint     startPoint;      // 开始位置
    CGPoint     movePoint;       // 移动位置
    PlayerViewController *pVC;
}

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
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(150, 50, 270, kScreenWidth - 100);
    
    [self p_addGestureRecognizer];
    
   
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 手指第一次接触到的位置
    UITouch *touch = [touches anyObject];
    startPoint = [touch locationInView:self.superview];
    DLog(@"Progress%@", NSStringFromCGPoint(startPoint));
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // 手指每次接触到的位置
    UITouch *touch = [touches anyObject];
    movePoint = [touch locationInView:self.superview];
    DLog(@"Progress%@", NSStringFromCGPoint(movePoint));
    gapYValue = startPoint.y - movePoint.y;
    DLog(@"Progress%.2f", gapYValue);
    
}

- (void)p_addGestureRecognizer {
    // 向左边开始滑动
    UISwipeGestureRecognizer *progressRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(progressActionLeft:)];
    progressRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:progressRecognizerLeft];
    // 向右边开始滑动
    UISwipeGestureRecognizer *progressRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(progressActionRight:)];
    progressRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:progressRecognizerRight];

}
- (void)progressActionLeft:(UISwipeGestureRecognizer *)sender {
    [self.delegate adjustProgress:sender.direction];
    DLog(@"<--%lu", (unsigned long)sender.direction);
}
- (void)progressActionRight:(UISwipeGestureRecognizer *)sender {
    [self.delegate adjustProgress:sender.direction];
    DLog(@"-->%lu", (unsigned long)sender.direction);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
