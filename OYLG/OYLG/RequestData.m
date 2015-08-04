//
//  RequestData.m
//  OYLG
//
//  Created by 李志强 on 15/7/30.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "RequestData.h"
#import <UIKit/UIKit.h>

@implementation RequestData

+(NSDictionary *)requestData:(NSString *)aurl
{
    // 判断当前网络状态是否能够请求数据
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if ([[ud valueForKey:@"NetWorkStatus"] isEqualToString:@"NotReachable"]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测到您当前没有可用网络,请检查网络连接." delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
        return nil;
    }
    
    // 1.转成 URL
    NSURL * url = [[NSURL alloc]initWithString:aurl];
    
    // 2.创建请求对象
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    // 3.创建 响应 和 错误
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    // 4.开始请求获取响应,建立连接.同步请求.
    NSData * data =
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // 解析字典 json
    NSDictionary * dataDict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
    
    return dataDict;
}

@end
