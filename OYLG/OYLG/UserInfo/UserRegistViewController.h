//
//  UserRegistViewController.h
//  OYLG
//
//  Created by 李志强 on 15/8/4.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserRegistViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPasswdLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCheckPasswdLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswdTextField;
@property (weak, nonatomic) IBOutlet UITextField *userCheckPasswdTextField;
@property (weak, nonatomic) IBOutlet UITextField *userEmailTextField;
@property (weak, nonatomic) IBOutlet UIButton *registButton;

@end
