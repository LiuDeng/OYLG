//
//  UserLoginViewController.h
//  OYLG
//
//  Created by 李志强 on 15/8/4.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^changeButton)(void);
@interface UserLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPasswdLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswdTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property(nonatomic,copy)changeButton changeButtonStatus;

@end
