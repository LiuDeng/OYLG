//
//  LOLSomeOneProgramListModel.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "LOLSomeOneProgramListModel.h"

@implementation LOLSomeOneProgramListModel


+(NSMutableArray *) loadLOLSomeOneProgramList:(NSString *)aId {
    NSMutableArray * LOLSomeOneProgramListArray = [NSMutableArray array];
    // 请求数据.
    // 拼接 url 的字符串
    NSString * urlString = [ NSString stringWithFormat:@"http://api.dotaly.com/lol/api/v1/shipin/latest?author=%@&iap=0&ident=408A6C12-3E61-42EE-A6DB-FB776FBB834E&jb=0&limit=50",aId];
    // 获取 URL
    NSString * newString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
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
    for (NSDictionary * d in dataDict[@"videos"]) {
        LOLSomeOneProgramListModel * LOLSomeOneProgramListInfo = [[LOLSomeOneProgramListModel alloc] init];
        [LOLSomeOneProgramListInfo setValuesForKeysWithDictionary:d];
        [LOLSomeOneProgramListArray addObject:LOLSomeOneProgramListInfo];
    }
    
    return LOLSomeOneProgramListArray;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
