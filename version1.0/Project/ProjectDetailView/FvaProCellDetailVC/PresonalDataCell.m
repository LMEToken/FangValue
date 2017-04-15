//
//  PresonalDataCell.m
//  FangChuang
//
//  Created by weiping on 14-9-23.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "PresonalDataCell.h"

@implementation PresonalDataCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;


    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
