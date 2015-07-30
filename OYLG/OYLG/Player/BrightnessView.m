//
//  BrightnessView.m
//  OYLG
//
//  Created by 欧阳娇龙 on 15/7/30.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "BrightnessView.h"
#import "OYLG-Prefix.pch"

@interface BrightnessView ()
{
    float       systemVolume;   // 系统音量值
    CGPoint     startPoint;     // 开始位置
    CGPoint     movePoint;      // 移动位置
}
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
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 50, 150, kScreenWidth - 100);
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 手指第一次接触到的位置
    UITouch *touch = [touches anyObject];
    startPoint = [touch locationInView:self.superview];
    DLog(@"Brightness%@", NSStringFromCGPoint(startPoint));
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // 手指每次接触到的位置
    UITouch *touch = [touches anyObject];
    movePoint = [touch locationInView:self.superview];
    DLog(@"Brightness%@", NSStringFromCGPoint(movePoint));
    CGFloat D_value = startPoint.y - movePoint.y;
    DLog(@"Brightness%.2f", D_value);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
