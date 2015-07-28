//
//  DotaSomeOneProgramListModel.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DotaSomeOneProgramListModel.h"

@implementation DotaSomeOneProgramListModel


+(NSMutableArray *) loadDotaSomeOneProgramList:(NSString *)aId {
    NSMutableArray * dotaSomeOneProgramListArray = [NSMutableArray array];
    // 请求数据.
    // 拼接 url 的字符串
    NSString * urlString = [ NSString stringWithFormat:@"http://api.dotaly.com/api/v1/shipin/latest?author=%@&iap=0&ident=F5D9CA17-1E5C-4B19-8727-4C3A51B77596&jb=0&limit=50",aId];
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
        DotaSomeOneProgramListModel * dotaSomeOneProgramListInfo = [[DotaSomeOneProgramListModel alloc] init];
        [dotaSomeOneProgramListInfo setValuesForKeysWithDictionary:d];
        [dotaSomeOneProgramListArray addObject:dotaSomeOneProgramListInfo];
    }
    
    return dotaSomeOneProgramListArray;
}


+(NSMutableArray *) loadDotaSomeOneProgramListMoreData:(NSString *)aId index:(NSInteger) index
{
    NSMutableArray * dotaSomeOneProgramListArray = [NSMutableArray array];
    // 请求数据.
    // 拼接 url 的字符串
    NSString * urlString = [ NSString stringWithFormat:@"http://api.dotaly.com/api/v1/shipin/latest?author=%@&iap=0&ident=D0C9716C-247F-4B2D-BEFC-F586482D2A01&jb=0&limit=50&offset=%ld",aId,index];
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
        DotaSomeOneProgramListModel * dotaSomeOneProgramListInfo = [[DotaSomeOneProgramListModel alloc] init];
        [dotaSomeOneProgramListInfo setValuesForKeysWithDictionary:d];
        [dotaSomeOneProgramListArray addObject:dotaSomeOneProgramListInfo];
    }
    
    return dotaSomeOneProgramListArray;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
