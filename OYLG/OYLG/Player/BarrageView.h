//
//  BarrageView.h
//  OYLG
//
//  Created by 欧阳娇龙 on 15/8/3.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BarrageViewDelegate <NSObject>



@end

@interface BarrageView : UIView

@property (nonatomic, strong)UILabel    *barrageLabel;

@property (nonatomic, assign)id<BarrageViewDelegate> delegate;
@end
