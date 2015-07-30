//
//  ProgressView.h
//  OYLG
//
//  Created by 欧阳娇龙 on 15/7/30.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProgressViewDelegate <NSObject>

- (void)adjustProgress:(UISwipeGestureRecognizerDirection)direction;

@end

@interface ProgressView : UIView


@property (nonatomic, assign) id<ProgressViewDelegate> delegate;

@end
