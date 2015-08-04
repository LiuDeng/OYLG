//
//  UserLoginViewController.m
//  OYLG
//
//  Created by 李志强 on 15/8/4.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "UserLoginViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UserRegistViewController.h"



@interface UserLoginViewController ()


@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender {

    if ([_userNameTextField.text isEqualToString:@""] || [_userPasswdTextField.text isEqualToString:@""] ) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // 用户登录.
    __block typeof(self) weakSelf = self;
    [AVUser logInWithUsernameInBackground:_userNameTextField.text password:_userPasswdTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            
            // 设置全局标记,表示已经登录了.
            NSUserDefaults * nd = [NSUserDefaults standardUserDefaults];
            [nd setValue:@"YES" forKey:@"LoginStatus"];
            
            weakSelf.changeButtonStatus();
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或者密码错误" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }];
}
- (IBAction)registAction:(id)sender {
    UserRegistViewController * RegistVC = [[UserRegistViewController alloc] init];
    
    [self.navigationController  pushViewController:RegistVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
