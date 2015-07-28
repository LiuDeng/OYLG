//
//  PlayerProgramListTableViewController.h
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^popToSuperView)();

@interface DotaSomeOneListTableViewController : UITableViewController
@property(nonatomic,strong)NSString * aId;
@property(nonatomic,copy)popToSuperView block;
@end
