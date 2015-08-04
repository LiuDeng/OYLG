//
//  DownLoadTask.h
//  OYLG
//
//  Created by 李志强 on 15/8/1.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoadTask : NSObject

// 根据 url 下载 m3u8 文件
-(void)getm3u8File:(NSString *)aURL;
-(NSArray *)parsem3u8File:(NSString *)filePath;

@end
