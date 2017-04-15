//
//  PresonalDataCellTableViewCell.m
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "PresonalDataCellTableViewCell.h"

@implementation PresonalDataCellTableViewCell
@synthesize rightlable,leftlable;
- (void)awakeFromNib
{
      self.selectionStyle = UITableViewCellSelectionStyleNone;
    [rightlable setFont:[UIFont fontWithName:KUIFont size:13]];
     [leftlable setFont:[UIFont fontWithName:KUIFont size:11]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
