//
//  DownLoadBreakPointResume.m
//  OYLG
//
//  Created by 李志强 on 15/8/1.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DownLoadBreakPointResume.h"

@interface DownLoadBreakPointResume ()
{
    // 1.文件的总大小.
    long long _total;
    // 2.当前下载了多少.
    long long _current;
}
@property(nonatomic,strong)NSURLConnection  * conn; // 连接对象.
@property(nonatomic,strong)NSFileHandle * fileHandle; // 也是单例,文件句柄.
@end

@implementation DownLoadBreakPointResume
// 根据 url 断点续传



@end
