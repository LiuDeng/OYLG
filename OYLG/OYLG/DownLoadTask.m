//
//  DownLoadTask.m
//  OYLG
//
//  Created by 李志强 on 15/8/1.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DownLoadTask.h"
#import "Md5.h"

@interface DownLoadTask ()
@property(nonatomic,strong)NSURLConnection  * conn; // 连接对象.
@property(nonatomic,strong)NSFileHandle * fileHandle; // 也是单例,文件句柄.
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * fileName;
@property(nonatomic,strong)NSString * filePath;
@end

@implementation DownLoadTask

-(void)getm3u8File:(NSString *)aURL
{
    self.url = aURL;
    // 生成 aURL 文件名称
    self.fileName = [NSString stringWithFormat:@"%@.m3u8",[Md5 md5:_url]];

    // 文件存放路径
    NSString * CachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",CachePath);
    self.filePath = [CachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/OLDm3u8/%@",_fileName]];
    
    // 创建这个文件
    NSFileManager * fm = [NSFileManager defaultManager];
    [fm createDirectoryAtPath:[CachePath stringByAppendingPathComponent:@"/OLDm3u8/"] withIntermediateDirectories:NO attributes:nil error:nil];
    [fm createFileAtPath:_filePath contents:nil attributes:nil];
    
    // 让文件句柄指向这个文件.
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:_filePath];
    
    // 开始请求数据
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:aURL]];
    
    // 请求数据
    NSData * data =
    [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
    
    // 通过句柄写入文件
    [self.fileHandle writeData:data];
}

// 解析 m3u8 文件
-(NSArray *)parsem3u8File:(NSString *)filePath
{
    // 最后返回的数组,里面是需要下载的 url 链接.
    NSMutableArray * array = [NSMutableArray array];
    
    // 从文件中拿出所有的数据
    NSString * fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSArray * detailArray = [fileContent componentsSeparatedByString:@"\n"];
    
    for (NSString * str in detailArray) {
        if (![str hasPrefix:@"http"]) {
            continue;
        }
        
        NSString * str1 = [str componentsSeparatedByString:@"?"][0];
        NSString * str2 =[str1 stringByReplacingOccurrencesOfString:@".ts" withString:@""];
        
        if ([array containsObject:str2]) {
            continue;
        }
        [array addObject:str2];
    }
    return array;
}




@end
