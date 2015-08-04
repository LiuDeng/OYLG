//
//  DownLoadTask.m
//  OYLG
//
//  Created by 李志强 on 15/7/31.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DownLoadTaskRegist.h"
#import "DotaSomeOneProgramListModel.h"
#import "LOLSomeOneProgramListModel.h"


@implementation DownLoadTaskRegist
-(void) addDownLoadTask:(NSString *)aURL info:(id)aInfo withType:(NSString *)aType
{
    NSString * DocumentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString * dataBasePath = [DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
    DataBaseTool * db = [DataBaseTool shareDataBase];
    [db connectDB:dataBasePath];
    
    int cnt = [db sqlCount:[NSString stringWithFormat:@"select count(*) from DownLoadTaskTable where url = '%@'",aURL]];
    if (cnt != 0) {
        return ; // 已经在列表中了,这里用 UIalert 改写.
    }
    
    if ([aType isEqualToString:@"Dota"]) {
        DotaSomeOneProgramListModel * info = (DotaSomeOneProgramListModel *)aInfo;
        [db execDMLSql:[NSString stringWithFormat:@"insert into DownLoadTaskTable(thumb,author,title,time,date1,id,url,status) values('%@','%@','%@','%@','%@','%@','%@','%@')", info.thumb,info.author,info.title,info.time,info.date1,info.id,aURL,@"NO"]];
    }else if ([aType isEqualToString:@"LOL"])
    {
        LOLSomeOneProgramListModel * info = (LOLSomeOneProgramListModel *)aInfo;
        [db execDMLSql:[NSString stringWithFormat:@"insert into DownLoadTaskTable(thumb,author,title,time,date1,id,url,status)  values('%@','%@','%@','%@','%@','%@','%@','%@')", info.thumb,info.author,info.title,info.time,info.date1,info.id,aURL,@"NO"]];
    }
    [db disconnectDB];
}
@end
