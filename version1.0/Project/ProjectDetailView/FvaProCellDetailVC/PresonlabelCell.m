//
//  PresonlabelCell.m
//  FangChuang
//
//  Created by weiping on 14-9-23.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "PresonlabelCell.h"

@implementation PresonlabelCell
@synthesize heradlable;
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
    heradlable = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 30)];
    [heradlable setFont:[UIFont fontWithName:KUIFont size:10]];
    [self addSubview:heradlable];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
