//
//  DotaAllList.m
//  布局
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "DotaAllListModel.h"
#import "OYLG-Prefix.pch"

@implementation DotaAllListModel

+(NSMutableArray *) loadDotaAllList {
    NSMutableArray * dotaAllListInfoArray = [NSMutableArray array];
    // 请求数据.
    // 获取 URL
    NSString * newString = [kDotaAllListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 2.转成 URL
    NSURL * url = [[NSURL alloc]initWithString:newString];
    
    // 3.创建请求对象
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    // 4.创建 响应 和 错误
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    // 5.开始请求获取响应,建立连接.同步请求.
    NSData * data =
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // 解析字典 json
    NSDictionary * dataDict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
    
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
