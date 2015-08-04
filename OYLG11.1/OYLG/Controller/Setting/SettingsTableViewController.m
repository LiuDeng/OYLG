//
//  SettingsTableViewController.m
//  OYLG
//
//  Created by lanou3g on 15/8/3.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SettingsTableViewCell.h"
#import "CacheMenuViewController.h"
#import "RegardViewController.h"
#import "OYLG-Prefix.pch"

@interface SettingsTableViewController ()

@property(nonatomic,strong)UILabel *labelMenu;

@property(nonatomic,strong)UIButton *registerBut;//注册

@property(nonatomic,strong)UIButton *loginBut;//登录

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题的颜色
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [lab setTextColor:[UIColor whiteColor]];
    [lab setText:@"设置"];
    //lab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = lab;
//    self.tableView.contentSize = CGSizeMake(kScreenWidth, self.tableView.frame.size.height + 400);
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);

    
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingsTableViewCell" bundle:nil] forCellReuseIdentifier:@"Settingscell"];
    
    [self setExtraCellLineHidden:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if (section == 0) {
        return 4;
    }else{
        return 3;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Settingscell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"蜂窝数据下载";
            
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.contentView.frame)- 90, 5, 60, 34)];
            [switchButton setOn:NO];
            [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:switchButton];
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"缓存画质";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            self.labelMenu = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(cell.contentView.frame)- 90, 5, 60, 34)];
            _labelMenu.backgroundColor = [UIColor clearColor];
            _labelMenu.text = @"测试1";
            [cell addSubview:_labelMenu];
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"占用空间";
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(cell.contentView.frame)- 90, 5, 70, 34)];
            label.backgroundColor = [UIColor clearColor];
            label.text = @"测试2";
            [cell addSubview:label];
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"可用空间";
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(cell.contentView.frame)- 90, 5, 70, 34)];
            label.backgroundColor = [UIColor clearColor];
            label.text = @"测试3";
            [cell addSubview:label];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"给我评分";
        }if (indexPath.row == 1) {
            cell.textLabel.text = @"分享给小伙伴们";
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"关于";
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 200;
//}

//隐藏多余的cell 的分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 0, kScreenWidth, 150);
    UILabel *lll = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-100, 10, 200, 60)];
    lll.backgroundColor = [UIColor clearColor];
    lll.text = @"打dota,秀联盟,谨以此纪念我们逝去的青春";
    lll.textAlignment = NSTextAlignmentCenter;
    lll.numberOfLines = 0;
    lll.alpha = 0.5;
    [view addSubview:lll];
    
    self.registerBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.registerBut.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2-120, 100, 110, 30);
    self.registerBut.backgroundColor = [UIColor blueColor];
    self.registerBut.alpha = 0.9;
    [self.registerBut setTitle:@"登录" forState:(UIControlStateNormal)];
    [self.registerBut addTarget:self action:@selector(registerButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:_registerBut];
    
    self.loginBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.loginBut.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2+10, 100, 110, 30);
    self.loginBut.backgroundColor = [UIColor blueColor];
    self.loginBut.alpha = 0.9;
    [self.loginBut setTitle:@"注册" forState:(UIControlStateNormal)];
    [self.loginBut addTarget:self action:@selector(loginButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:_loginBut];
    
    [tableView setTableFooterView:view];
    
}


-(void)registerButAction:(UIButton *)sender
{
    NSLog(@"登录");
}

-(void)loginButAction:(UIButton *)sender
{
    NSLog(@"注册");
}




#pragma mark 各个cell 点击的方法
//蜂窝数据下载
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        
        
    }else {
        
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第一组
    if (indexPath.section == 0) {
        //缓存画质
        if (indexPath.row == 1) {
            CacheMenuViewController *menuVC = [[CacheMenuViewController alloc]init];
            //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:nil action:nil];
            //回传值
            menuVC.passValue = ^(NSString *astring){
                self.labelMenu.text = astring;
            };
            
            [self.navigationController pushViewController:menuVC animated:YES];
        }
    }
    
    //第二组
    if (indexPath.section == 1) {
        //给我评分
        if (indexPath.row == 0) {
            
            
        }
        //分享给小伙伴们
        if (indexPath.row == 1) {
            
            
        }
        //关于
        if (indexPath.row == 2) {
            RegardViewController *regardVC = [[RegardViewController alloc]init];
            
            
            [self.navigationController pushViewController:regardVC animated:YES];
        }
    }
    
    
}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
