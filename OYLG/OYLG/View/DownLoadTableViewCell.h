//
//  DownLoadTableViewCell.h
//  OYLG
//
//  Created by 李志强 on 15/8/1.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DownLoadTableViewCellDelegate <NSObject>

-(void)DownLoadButionAction:(UIButton *)sender;

@end

@interface DownLoadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property(nonatomic,weak) id<DownLoadTableViewCellDelegate> delegate;

@end
