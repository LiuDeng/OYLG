//
//  LOLAllListModel.h
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LOLAllListModel : NSObject
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * detail;
@property(nonatomic,strong)NSString * pop;
@property(nonatomic,strong)NSString * youku_id;
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * icon;

+(NSMutableArray *) loadLOLAllList;
@end
