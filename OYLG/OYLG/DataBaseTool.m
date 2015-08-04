//
//  DataBaseTool.m
//  UIlesson19_数据库
//
//  Created by 李志强 on 15/7/14.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DataBaseTool.h"


static DataBaseTool * dbHandle = nil;

@implementation DataBaseTool

static sqlite3 *db = nil;

+(instancetype) shareDataBase
{
    if (dbHandle == nil) {
        dbHandle = [[DataBaseTool alloc] init];
    }
    return dbHandle;
}

-(int)connectDB:(NSString *)filePath
{
    if (db != nil) {
        return 1;
    }
    int result = sqlite3_open(filePath.UTF8String, &db);
    if (result == SQLITE_OK) {
        return 0;
    }
    else
    {
        return -1;
    }
}

-(int)disconnectDB
{
    int result = sqlite3_close(db);
    if (result != SQLITE_OK) {
        return -1;
    }
    db = nil;
    return 0;
}

-(int)execDDLSql:(NSString *)sql
{
    char * errmsg = NULL;
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errmsg);
    if (result == SQLITE_OK) {
        return 0 ;
    }
    else
    {
        NSLog(@"%s",errmsg); // 这里应该是写日志的. mypantone
        return -1;
    }
}

-(int)execDMLSql:(NSString *)sql
{
    char * errmsg = NULL;
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errmsg);
    if (result == SQLITE_OK) {
        return 0 ;
    }
    else
    {
        NSLog(@"%s",errmsg); // 这里应该是写日志的. mypantone
        // rollback;
        return -1;
    }
}

-(int)sqlCount:(NSString *)sql
{
    sqlite3_stmt * stmt = nil;
    
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    int count = -1;
    
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            count = sqlite3_column_int(stmt, 0);
        }
    }
    sqlite3_finalize(stmt);
    return count;
}

-(NSString *)sqlFieldText:(NSString *)sql
{
    sqlite3_stmt * stmt = nil;
    
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    NSString * string = nil;
    
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            string = [NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 0)];
        }
    }
    sqlite3_finalize(stmt);
    return string;
}

-(NSInteger)sqlFieldInt:(NSString *)sql
{
    sqlite3_stmt * stmt = nil;
    
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    NSInteger i = -1;
    
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            i = sqlite3_column_int(stmt, 0);
        }
    }
    sqlite3_finalize(stmt);
    return i;
}

-(NSMutableArray *)selectString:(NSString *)sql
{
    NSMutableArray *array = nil;
    sqlite3_stmt * stmt = nil;
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        array = [[NSMutableArray alloc] init];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString * string = [NSString string];
            string = [NSString stringWithUTF8String:(const char * )sqlite3_column_text(stmt, 0)];
            
            [array addObject:string];
        }
    }
    sqlite3_finalize(stmt);
    return array;
}


@end
