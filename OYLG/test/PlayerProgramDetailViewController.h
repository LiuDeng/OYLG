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

@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UIImageView *thumImage;
@property (weak, nonatomic) IBOutlet UILabel *Dtime;
@property (weak, nonatomic) IBOutlet UILabel *UpdateTime;
@property (weak, nonatomic) IBOutlet UIButton *flvButton;
@property (weak, nonatomic) IBOutlet UIButton *mp4Button;
@property (weak, nonatomic) IBOutlet UIButton *HDButton;
@end
