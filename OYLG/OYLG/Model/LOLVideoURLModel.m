//
//  LOLVideoURLModel.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "LOLVideoURLModel.h"
#import "RequestData.h"

@implementation LOLVideoURLModel

+(NSString *) loadLOLVideoURL:(NSString *)aId  type:(NSString *)type; {
    // 请求数据.
    // 拼接 url 的字符串
    NSString * urlString = [ NSString stringWithFormat:@"http://api.dotaly.com/lol/api/v1/getvideourl?iap=0&ident=408A6C12-3E61-42EE-A6DB-FB776FBB834E&jb=0&type=%@&vid=%@",type,aId];
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
