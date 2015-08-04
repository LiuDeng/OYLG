//
//  BarrageView.m
//  OYLG
//
//  Created by 欧阳娇龙 on 15/8/3.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "BarrageView.h"
#import "OYLG-Prefix.pch"

@implementation BarrageView

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
    self.frame = CGRectMake(0, 50, kScreenHeight, 25);
    _barrageLabel = [[UILabel alloc] init];
    _barrageLabel.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    _barrageLabel.backgroundColor = kBackbroundColorAlpha;
    _barrageLabel.textColor = [UIColor whiteColor];
    _barrageLabel.font = [UIFont fontWithName:nil size:15];
    [self addSubview:_barrageLabel];
    [_barrageLabel addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    self.userInteractionEnabled = YES;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    DLog(@"barrageLabel");
    CAKeyframeAnimation *key2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    self.layer.anchorPoint = CGPointMake(0, 0);
    key2.duration = 15.0f;
    CGFloat arcY = (arc4random() % 3 + 1) * 20;
    DLog(@"%.2f", arcY);
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth, arcY)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(-kScreenWidth - _barrageLabel.frame.size.width - 1000 , arcY)];
    key2.values = @[v1, v2];
    [self.layer addAnimation:key2 forKey:@"key2"];
    
}

@end
