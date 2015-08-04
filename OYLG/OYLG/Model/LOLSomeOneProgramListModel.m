//
//  LOLSomeOneProgramListModel.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "LOLSomeOneProgramListModel.h"
#import "RequestData.h"

@implementation LOLSomeOneProgramListModel

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"date"]) {
        self.date1 = value;
    }
}


+(NSMutableArray *) loadLOLSomeOneProgramList:(NSString *)aId {
    NSMutableArray * LOLSomeOneProgramListArray = [NSMutableArray array];
    // 请求数据.
    // 拼接 url 的字符串
    NSString * urlString = [ NSString stringWithFormat:@"http://api.dotaly.com/lol/api/v1/shipin/latest?author=%@&iap=0&ident=408A6C12-3E61-42EE-A6DB-FB776FBB834E&jb=0&limit=50",aId];
    // 获取 URL
    NSString * newString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 请求数据并且解析字典.
    NSDictionary * dataDict = nil;
    if ( (dataDict = [RequestData requestData:newString]) == nil) {
        return nil;
    }
    
    // 创建 model 模型.
    for (NSDictionary * d in dataDict[@"videos"]) {
        LOLSomeOneProgramListModel * LOLSomeOneProgramListInfo = [[LOLSomeOneProgramListModel alloc] init];
        [LOLSomeOneProgramListInfo setValuesForKeysWithDictionary:d];
        [LOLSomeOneProgramListArray addObject:LOLSomeOneProgramListInfo];
    }
    
    return LOLSomeOneProgramListArray;
}

//下拉请求更多数据
+(NSMutableArray *) loadLOLSomeOneProgramListMoreData:(NSString *)aId index:(NSInteger) index
{
    NSMutableArray * lolSomeOneProgramListArray = [NSMutableArray array];
    // 请求数据.
    // 拼接 url 的字符串
    NSString * urlString = [ NSString stringWithFormat:@"http://api.dotaly.com/lol/api/v1/shipin/latest?author=%@&iap=0&ident=AA6B8F86-AAAB-44DE-B8F7-69C16725AA77&jb=0&limit=50&offset=%ld",aId,index];
    // 获取 URL
    NSString * newString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 请求数据并且解析字典.
    NSDictionary * dataDict = nil;
    if ( (dataDict = [RequestData requestData:newString]) == nil) {
        return nil;
    }
    
    // 创建 model 模型.
    for (NSDictionary * d in dataDict[@"videos"]) {
        LOLSomeOneProgramListModel * lolSomeOneProgramListInfo = [[LOLSomeOneProgramListModel alloc] init];
        [lolSomeOneProgramListInfo setValuesForKeysWithDictionary:d];
        [lolSomeOneProgramListArray addObject:lolSomeOneProgramListInfo];
    }
    
    return lolSomeOneProgramListArray;
}




-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
