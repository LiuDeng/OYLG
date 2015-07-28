//
//  DotaVideoURLModel.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DotaVideoURLModel.h"

@implementation DotaVideoURLModel


+(NSString *) loadDotaVideoURL:(NSString *)aId  type:(NSString *)type; {
    // 请求数据.
    // 拼接 url 的字符串
    NSString * urlString = [ NSString stringWithFormat:@"http://api.dotaly.com/api/v1/getvideourl?iap=0&ident=F5D9CA17-1E5C-4B19-8727-4C3A51B77596&jb=0&type=%@&vid=%@",type,aId];
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
    
    return [dataDict valueForKey:@"url"];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
