//
//  DotaVideoURLModel.h
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DotaVideoURLModel : NSObject
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * message;
@property(nonatomic,strong)NSString * code;

+(NSString *) loadDotaVideoURL:(NSString *)aId  type:(NSString *)type;
@end
