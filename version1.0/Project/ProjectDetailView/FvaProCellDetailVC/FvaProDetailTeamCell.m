//
//  FvaProDetailTeamCell.m
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaProDetailTeamCell.h"
#import "FvaProCompanInVC.h"
@implementation FvaProDetailTeamCell
@synthesize teamtext;
- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    teamtext.userInteractionEnabled = NO;
    teamtext.text = @"CEO :大毛.啦啦啦啦啦啦啦啦啦啦啦啦啦啊啊啦啦啦啦阿拉啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啦啦啦";
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
