//
//  DotaSomeOneProgramListModel.h
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DotaSomeOneProgramListModel : NSObject
@property(nonatomic,strong)NSString * thumb;
@property(nonatomic,strong)NSString * author;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * time;
@property(nonatomic,strong)NSString * date;
@property(nonatomic,strong)NSString * id;
+(NSMutableArray *) loadDotaSomeOneProgramList:(NSString *)aId;
+(NSMutableArray *) loadDotaSomeOneProgramListMoreData:(NSString *)aId index:(NSInteger) index;
@end
