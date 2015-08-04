//
//  ProgressView.h
//  OYLG
//
//  Created by 欧阳娇龙 on 15/7/30.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProgressView;
@protocol ProgressViewDelegate <NSObject>

- (void)adjustVolume:(ProgressView *)view direction:(UISwipeGestureRecognizerDirection)direction;
- (void)changeProgress:(ProgressView *)view;
- (void)tapAction;
- (void)sonViewTouchDownPoint: (CGPoint)touchPoint from:(id)sender;
@end

@interface ProgressView : UIView

@property (nonatomic, assign) id<ProgressViewDelegate> delegate;
@property (nonatomic, readonly) CGPoint     startPoint;         // 开始位置
@property (nonatomic, readonly) CGPoint     movePoint;          // 移动位置

@end
