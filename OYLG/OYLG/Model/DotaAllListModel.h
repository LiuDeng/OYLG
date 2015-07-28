//
//  DotaAllList.h
//  布局
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DotaAllListModel : NSObject
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * detail;
@property(nonatomic,strong)NSString * pop;
@property(nonatomic,strong)NSString * youku_id;
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * icon;

+(NSMutableArray *) loadDotaAllList;
@end
