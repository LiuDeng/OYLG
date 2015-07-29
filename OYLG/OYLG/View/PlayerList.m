//
//  PlayerList.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "PlayerList.h"
#import "OYLG-Prefix.pch"

@implementation PlayerList

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_set];
    }
    return self;
}

-(void) p_set {
    
    // UIScrollView
    self.mainScroll = [[UIScrollView alloc] init];
    _mainScroll.backgroundColor = [UIColor clearColor];
    _mainScroll.showsVerticalScrollIndicator = YES;
    _mainScroll.contentSize = CGSizeMake(CGRectGetHeight(_mainScroll.frame), 2 * kScreenWidth);
    _mainScroll.scrollEnabled = NO;
    _mainScroll.pagingEnabled = YES;
    [self addSubview:_mainScroll];
    
    
    // UISegmentedControl
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"视频", @"赛事"]];
    _seg.frame = CGRectMake(0, 0, kScreenWidth,30);
    self.seg.selectedSegmentIndex = 0;
    self.seg.tintColor = [UIColor blueColor];
    
    
    // playerTableView
    self.playerTableView = [[UITableView alloc] init];
    _playerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mainScroll addSubview:_playerTableView];
    //======================
    // 背景色
    _playerTableView.backgroundColor = [UIColor clearColor];
    _playerTableView.showsVerticalScrollIndicator = YES;
    _playerTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //======================
    _playerTableView.contentOffset = CGPointMake(0, 0);
    _playerTableView.tag = 119;
    
    
    // eventTableView
    self.eventTableView = [[UITableView alloc] init];
    //======================
    // 背景色
    _eventTableView.backgroundColor = [UIColor clearColor];
    [_mainScroll addSubview:_eventTableView];
    _eventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _eventTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //======================
    _eventTableView.contentOffset = CGPointMake(kScreenWidth, 0);
    _eventTableView.tag = 120;
    
    
}
- (void)layoutSubviews {
    self.seg.selectedSegmentIndex = 0;
    _mainScroll.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-20 - 44 - 49);
    _playerTableView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.mainScroll.frame));
    _eventTableView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, CGRectGetHeight(self.mainScroll.frame));

}
@end
