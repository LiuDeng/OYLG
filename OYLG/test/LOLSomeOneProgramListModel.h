//
//  LOLSomeOneProgramListModel.h
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LOLSomeOneProgramListModel : NSObject
@property(nonatomic,strong)NSString * thumb;
@property(nonatomic,strong)NSString * author;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * time;
@property(nonatomic,strong)NSString * date1;
@property(nonatomic,strong)NSString * id;
+(NSMutableArray *) loadLOLSomeOneProgramList:(NSString *)aId;
@end
