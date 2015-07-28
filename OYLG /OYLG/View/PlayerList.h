//
//  PlayerList.h
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerList : UIView
@property(nonatomic,strong)UISegmentedControl * seg;
@property(nonatomic,strong)UIScrollView * mainScroll;
@property(nonatomic,strong)UITableView * playerTableView;
@property(nonatomic,strong)UITableView * eventTableView;
@end
