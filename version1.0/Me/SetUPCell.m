//
//  SetUPCell.m
//  FangChuang
//
//  Created by weiping on 14-10-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "SetUPCell.h"

@implementation SetUPCell
@synthesize rightlable;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        rightlable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 70, 30)];
        [rightlable setTextColor:[UIColor grayColor]];
        
        [rightlable setFont:[UIFont fontWithName:KUIFont size:13]];
        UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(15, self.frame.size.height, 290, 1)];
        myview.image = [UIImage imageNamed:@"celllin@2x"];
        [self addSubview:myview];
        [self addSubview:rightlable];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
