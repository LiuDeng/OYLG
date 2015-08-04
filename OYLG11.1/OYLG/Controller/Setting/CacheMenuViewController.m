//
//  CacheMenuViewController.m
//  OYLG
//
//  Created by lanou3g on 15/8/3.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "CacheMenuViewController.h"

@interface CacheMenuViewController ()

@property(nonatomic,strong)UIButton *button1;

@property(nonatomic,strong)UIButton *button2;

@property(nonatomic,strong)UIButton *button3;


@property(nonatomic,strong)UIView *myView;
@end

@implementation CacheMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置标题的颜色
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [lab setTextColor:[UIColor whiteColor]];
    [lab setText:@"缓存画质选择"];
    self.navigationItem.titleView = lab;
    
    //self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    //[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    
    [self p_setupView];
    
    
}

-(void)p_setupView
{
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.myView.backgroundColor = [UIColor grayColor];
    self.myView.alpha = 0.1;
    [self.view addSubview:_myView];
    
    
    self.button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button1.frame = CGRectMake(0 , 64 + 40, CGRectGetWidth(self.view.frame), 44);
    self.button1.backgroundColor = [UIColor whiteColor];
    [self.button1 setTitle:@"标清" forState:(UIControlStateNormal)];
    
    [self.button1 addTarget:self action:@selector(button1Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_button1];
    
    self.button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button2.frame = CGRectMake(0 , 64 + 40+44+10, CGRectGetWidth(self.view.frame), 44);
    self.button2.backgroundColor = [UIColor whiteColor];
    [self.button2 setTitle:@"高清" forState:(UIControlStateNormal)];
    
    [self.button2 addTarget:self action:@selector(button2Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_button2];
    
    self.button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button3.frame = CGRectMake(0 , 64 + 40+44+44+10+10, CGRectGetWidth(self.view.frame), 44);
    self.button3.backgroundColor = [UIColor whiteColor];
    [self.button3 setTitle:@"超清" forState:(UIControlStateNormal)];
    
    [self.button3 addTarget:self action:@selector(button3Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_button3];
    
}

//navigation 左面button点击方法 (block 回传值)
-(void)leftAction:(UIBarButtonItem *)sender
{
    if (self.button1.backgroundColor == [UIColor blueColor]) {
        
        _passValue(_button1.titleLabel.text);
    }else if (self.button2.backgroundColor == [UIColor blueColor]){
        
        _passValue(_button2.titleLabel.text);
    }else if(self.button3.backgroundColor == [UIColor blueColor]){
        
        _passValue(_button3.titleLabel.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)button1Action:(UIButton *)sender
{
    self.button1.backgroundColor = [UIColor blueColor];
    self.button2.backgroundColor = [UIColor whiteColor];
    self.button3.backgroundColor = [UIColor whiteColor];
    
    
    NSLog(@"按钮1");
}

-(void)button2Action:(UIButton *)sender
{
    self.button2.backgroundColor = [UIColor blueColor];
    self.button1.backgroundColor = [UIColor whiteColor];
    self.button3.backgroundColor = [UIColor whiteColor];
    
    
    NSLog(@"按钮2");

}

-(void)button3Action:(UIButton *)sender
{
    self.button3.backgroundColor = [UIColor blueColor];
    self.button1.backgroundColor = [UIColor whiteColor];
    self.button2.backgroundColor = [UIColor whiteColor];

    NSLog(@"按钮3");

}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
