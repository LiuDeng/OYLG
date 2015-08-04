//
//  LOLAllListModel.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "LOLAllListModel.h"
#import "OYLG-Prefix.pch"
#import "RequestData.h"

@implementation LOLAllListModel


+(NSMutableArray *) loadLOLAllList {
    NSMutableArray * LOLAllListInfoArray = [NSMutableArray array];
    // 请求数据.
    // 获取 URL
    NSString * newString = [kLOLAllListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 请求数据并且解析字典.
    NSDictionary * dataDict = nil;
    if ( (dataDict = [RequestData requestData:newString]) == nil) {
        return nil;
    }
    
    // 创建 model 模型.
    for (NSDictionary * d in dataDict[@"authors"]) {
        LOLAllListModel * LOLAllListInfo = [[LOLAllListModel alloc] init];
        [LOLAllListInfo setValuesForKeysWithDictionary:d];
        [LOLAllListInfoArray addObject:LOLAllListInfo];
    }
    
    return LOLAllListInfoArray;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
