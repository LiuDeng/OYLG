//
//  DotaVideoURLModel.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DotaVideoURLModel.h"
#import "RequestData.h"

@implementation DotaVideoURLModel


+(NSString *) loadDotaVideoURL:(NSString *)aId  type:(NSString *)type; {
    // 请求数据.
    // 拼接 url 的字符串
    NSString * urlString = [ NSString stringWithFormat:@"http://api.dotaly.com/api/v1/getvideourl?iap=0&ident=F5D9CA17-1E5C-4B19-8727-4C3A51B77596&jb=0&type=%@&vid=%@",type,aId];
    // 获取 URL
    NSString * newString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 请求数据并且解析字典.
    NSDictionary * dataDict = nil;
    if ( (dataDict = [RequestData requestData:newString]) == nil) {
        return nil;
    }
    
    return [dataDict valueForKey:@"url"];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
