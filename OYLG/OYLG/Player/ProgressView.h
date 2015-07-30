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

//- (void)adjustProgress:(UISwipeGestureRecognizerDirection)direction;
- (void)adjustProgress:(ProgressView *)view direction:(UISwipeGestureRecognizerDirection)direction;

@end

@interface ProgressView : UIView

@property (nonatomic, assign) id<ProgressViewDelegate> delegate;
@property (nonatomic, readonly) CGPoint     startPoint;         // 开始位置
@property (nonatomic, readonly) CGPoint     movePoint;          // 移动位置

@end
