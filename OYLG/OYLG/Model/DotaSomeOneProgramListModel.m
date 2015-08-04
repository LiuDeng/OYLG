//
//  DotaSomeOneProgramListModel.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DotaSomeOneProgramListModel.h"
#import "RequestData.h"

@implementation DotaSomeOneProgramListModel


+(NSMutableArray *) loadDotaSomeOneProgramList:(NSString *)aId {
    NSMutableArray * dotaSomeOneProgramListArray = [NSMutableArray array];
    // 请求数据.
    // 拼接 url 的字符串
    NSString * urlString = [ NSString stringWithFormat:@"http://api.dotaly.com/api/v1/shipin/latest?author=%@&iap=0&ident=F5D9CA17-1E5C-4B19-8727-4C3A51B77596&jb=0&limit=50",aId];
    // 获取 URL
    NSString * newString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 请求数据并且解析字典.
    NSDictionary * dataDict = nil;
    if ( (dataDict = [RequestData requestData:newString]) == nil) {
        return nil;
    }
    
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
    
    // 请求数据并且解析字典.
    NSDictionary * dataDict = nil;
    if ( (dataDict = [RequestData requestData:newString]) == nil) {
        return nil;
    }
    
    // 创建 model 模型.
    for (NSDictionary * d in dataDict[@"videos"]) {
        DotaSomeOneProgramListModel * dotaSomeOneProgramListInfo = [[DotaSomeOneProgramListModel alloc] init];
        [dotaSomeOneProgramListInfo setValuesForKeysWithDictionary:d];
        [dotaSomeOneProgramListArray addObject:dotaSomeOneProgramListInfo];
    }
    
    return dotaSomeOneProgramListArray;
}

//==========10.1
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"date"]) {
        _date1 = value;
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
