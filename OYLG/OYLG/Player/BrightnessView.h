//
//  BrightnessView.h
//  OYLG
//
//  Created by 欧阳娇龙 on 15/7/30.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BrightnessView;
@protocol BrightnessViewDelegate <NSObject>

- (void)changeBrightness:(CGFloat)value;

@end

@interface BrightnessView : UIView

@property (nonatomic, assign) id<BrightnessViewDelegate> delegate;
@property (nonatomic, readonly) CGPoint     startPoint;         // 开始位置
@property (nonatomic, readonly) CGPoint     movePoint;          // 移动位置

@end
