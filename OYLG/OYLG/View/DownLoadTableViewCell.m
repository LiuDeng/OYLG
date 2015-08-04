//
//  DownLoadTableViewCell.m
//  OYLG
//
//  Created by 李志强 on 15/8/1.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DownLoadTableViewCell.h"

@implementation DownLoadTableViewCell

- (IBAction)downLoadButtonAction:(id)sender {
    [self.delegate DownLoadButionAction:sender];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
