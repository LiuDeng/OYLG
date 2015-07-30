//
//  BrightnessView.m
//  OYLG
//
//  Created by 欧阳娇龙 on 15/7/30.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "BrightnessView.h"
#import "OYLG-Prefix.pch"
//float value = [UIScreen mainScreen].brightness;
@interface BrightnessView ()
@end

@implementation BrightnessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView {
    
    self.tag = kBrightViewTag;
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, 50, 150, kScreenWidth - 100);
    
    // 添加手势
    [self p_addGestureRecognizer];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 手指第一次接触到的位置
    UITouch *touch = [touches anyObject];
    _startPoint = [touch locationInView:self.superview];
    DLog(@"Brightness%@", NSStringFromCGPoint(_startPoint));
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // 手指每次接触到的位置
    UITouch *touch = [touches anyObject];
    _movePoint = [touch locationInView:self.superview];
    DLog(@"Brightness%@", NSStringFromCGPoint(_movePoint));
    CGFloat D_value = _startPoint.y - _movePoint.y;
    DLog(@"Brightness%.2f", D_value);
    // 滑动事件
    [self.delegate changeBrightness:D_value];
    
}

- (void)p_addGestureRecognizer {
    
    // 开始滑动
    UITapGestureRecognizer *progressRecognizerTap = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:progressRecognizerTap];
    
}



@end
