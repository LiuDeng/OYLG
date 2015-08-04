//
//  DownLoadTableViewController.m
//  OYLG
//
//  Created by 李志强 on 15/8/1.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DownLoadTableViewController.h"
#import "DataBaseTool.h"
#import "DownLoadTask.h"
#import "DownLoadTableViewCell.h"
#import "Md5.h"


@interface DownLoadTableViewController ()<DownLoadTableViewCellDelegate>
@property(nonatomic,strong)NSMutableArray * titleArray ;
@property(nonatomic,strong)NSMutableArray * urlArray;
@property(nonatomic,strong)NSMutableArray * statusArray;


@property(nonatomic,assign)NSInteger totalFile;
@property(nonatomic,assign)NSInteger curFileIndex;
@property(nonatomic,assign)NSInteger offset;
@end

@implementation DownLoadTableViewController

#pragma mark ==== 视图出现前
// 视图将要出现
-(void)viewWillAppear:(BOOL)animated {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSString * DocumentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString * dataBasePath = [DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
    DataBaseTool * db = [DataBaseTool shareDataBase];
    [db connectDB:dataBasePath];
    
    self.urlArray = [db selectString:@"select url from DownLoadTaskTable order by sid"];
    self.titleArray = [db selectString:@"select title from DownLoadTaskTable order by sid"];
    self.statusArray = [db selectString:@"select status from DownLoadTaskTable order by sid" ];
    [db disconnectDB];
    
}
#pragma mark ==== 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册 cell
    [self.tableView registerNib:[UINib nibWithNibName:@"DownLoadTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
#pragma mark ==== tableview 的代理方法
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _urlArray.count;
}
// 返回Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    DownLoadTableViewCell * cell = [tableView  dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = _titleArray[indexPath.row];
    cell.progress.progress = 0;
    cell.progressLabel.text = @"0 bytes/s";
    [cell.downLoadButton setTitle:@"下载" forState:(UIControlStateNormal)];
    cell.downLoadButton.tag = 100 + indexPath.row;
    
    cell.delegate = self;
    return cell;
}
// 返回 cell 高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
#pragma mark ==== 下载视频代理方法
// 下载视频
-(void)DownLoadButionAction:(UIButton *)sender {
    NSLog(@"%@",_titleArray[sender.tag - 100]);
    // 判断 m3u8文件是否在沙盒中存在?
    // 或者从数据库中检查下载到哪儿了(当前下载的 url 是什么,现在到的位置).
    
    // 根据点击按钮的 url 生成一个 md5文件名.
    NSString * fileName = [Md5 md5:_urlArray[sender.tag -100]];
    
    NSString * CachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString * filePath = [CachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/OLDm3u8/%@.m3u8",fileName]];
    
    NSFileManager * fm = [NSFileManager defaultManager];
    // 判断m3u8文件是否存在.
    if ([fm fileExistsAtPath:filePath]) {
        NSLog(@"%@文件存在",filePath);
        // 文件若存在,
        // 从文件中读出m3u8文件的内容,
        // 从数据库中读出,现在正在下载哪个文件,以及当前偏移量.
        DownLoadTask * DLTask = [[DownLoadTask alloc] init];
        //        NSArray * downLoadList = [DLTask parsem3u8File:filePath];
        
        // 连接数据库找到信息.
        NSString * DocumentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString * dataBasePath = [DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
        DataBaseTool * db = [DataBaseTool shareDataBase];
        [db connectDB:dataBasePath];
        
        self.totalFile = [db sqlFieldInt:[NSString stringWithFormat:@"select totalFile from DownLoadTaskTable where url = '%@'",_urlArray[sender.tag - 100 ]]];
        self.curFileIndex = [db sqlFieldInt:[NSString stringWithFormat:@"select curFileIndex from DownLoadTaskTable where url = '%@'",_urlArray[sender.tag - 100 ]]];
        self.offset = [db sqlFieldInt:[NSString stringWithFormat:@"select offset from DownLoadTaskTable where url = '%@'",_urlArray[sender.tag - 100 ]]];
        
        [db disconnectDB];
        
        NSLog(@"%ld,%ld,%ld",(long)self.totalFile,(long)self.curFileIndex,(long)self.offset);
        
    }else
    {
        NSLog(@"%@文件不存在",filePath);
        // 如果不存在
        // 1.下载 m3u8 文件.
        // 2.解析它
        // 3.向数据库中该条记录中注册一些东西:总共有多少个文件,当前下载到那个文件了.下载到当前文件的哪个位置了.
        DownLoadTask * DLTask = [[DownLoadTask alloc] init];
        
        // 下载 m3u8文件
        [DLTask getm3u8File:_urlArray[sender.tag - 100]];
        sleep(2);
        // 解析
        NSArray * downLoadList = [DLTask parsem3u8File:filePath];
        NSLog(@"%ld",(unsigned long)downLoadList.count);
        NSString * DocumentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString * dataBasePath = [DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
        DataBaseTool * db = [DataBaseTool shareDataBase];
        [db connectDB:dataBasePath];
        
        [db execDMLSql:[NSString stringWithFormat:@"update DownLoadTaskTable set totalFile = %ld,curFileIndex = %d, offset = %d where url = '%@'",(unsigned long)downLoadList.count,0,0,_urlArray[sender.tag -100]]];
        
        [db disconnectDB];
        
        // 记录当前的信息.
        self.totalFile = downLoadList.count;
        self.curFileIndex = 0;
        self.offset = 0;
    }
}
#pragma mark ==== 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
