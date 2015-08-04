//
//  CacheMenuViewController.h
//  OYLG
//
//  Created by lanou3g on 15/8/3.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^passValueBlock)(NSString *astring);
@interface CacheMenuViewController : UIViewController


@property(nonatomic,copy)passValueBlock passValue;


@end
