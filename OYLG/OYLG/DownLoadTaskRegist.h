//
//  DownLoadTask.h
//  OYLG
//
//  Created by 李志强 on 15/7/31.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataBaseTool.h"

// 下载任务管理器.
@interface DownLoadTaskRegist : NSObject

// 添加任务
-(void) addDownLoadTask:(NSString *)aURL info:(id)aInfo withType:(NSString *)aType;
@end
