//
//  PlayProgramDetailViewController.h
//  布局
//
//  Created by 欧阳娇龙 on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DotaSomeOneProgramListModel.h" 

@interface PlayerProgramDetailViewController : UIViewController
@property(nonatomic,strong) DotaSomeOneProgramListModel * detailData;

@property (weak, nonatomic) IBOutlet UILabel *videoTitle;           // 视频名称
@property (weak, nonatomic) IBOutlet UIImageView *thumImage;        // 视频截图
@property (weak, nonatomic) IBOutlet UILabel *Dtime;                // 视频时间
@property (weak, nonatomic) IBOutlet UILabel *UpdateTime;           // 更新时间
@property (weak, nonatomic) IBOutlet UIButton *flvButton;           // 标清
@property (weak, nonatomic) IBOutlet UIButton *mp4Button;           // 高清
@property (weak, nonatomic) IBOutlet UIButton *HDButton;            // 超清
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;      // 下载
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;    // 收藏
@property (weak, nonatomic) IBOutlet UIButton *thumbButton;         // 点赞
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;    // 评论


@end
