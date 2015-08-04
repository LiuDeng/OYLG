//
//  UserRegistViewController.m
//  OYLG
//
//  Created by 李志强 on 15/8/4.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "UserRegistViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface UserRegistViewController ()

@end

@implementation UserRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registAction:(id)sender {
    if ([_userNameTextField.text isEqualToString:@""] || [_userPasswdTextField.text isEqualToString:@""] || [_userCheckPasswdTextField.text isEqualToString:@""] || [_userEmailTextField.text isEqualToString:@""] ) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"基本字段不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    AVUser *user = [AVUser user];
    user.username = _userNameTextField.text;
    user.password =  _userPasswdTextField.text;
    user.email = _userEmailTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败,请更换用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

@end
