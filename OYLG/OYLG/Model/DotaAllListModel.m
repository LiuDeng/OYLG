//
//  DotaAllList.m
//  布局
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "DotaAllListModel.h"
#import "OYLG-Prefix.pch"
#import "RequestData.h"

@implementation DotaAllListModel

+(NSMutableArray *) loadDotaAllList {
    NSMutableArray * dotaAllListInfoArray = [NSMutableArray array];
    // 请求数据.
    // 获取 URL
    NSString * newString = [kDotaAllListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 请求数据并且解析字典.
    NSDictionary * dataDict = nil;
    if ( (dataDict = [RequestData requestData:newString]) == nil) {
        return nil;
    }
    
    // 创建 model 模型.
    for (NSDictionary * d in dataDict[@"authors"]) {
        DotaAllListModel * dotaAllListInfo = [[DotaAllListModel alloc] init];
        [dotaAllListInfo setValuesForKeysWithDictionary:d];
        [dotaAllListInfoArray addObject:dotaAllListInfo];
    }
    
    return dotaAllListInfoArray;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
