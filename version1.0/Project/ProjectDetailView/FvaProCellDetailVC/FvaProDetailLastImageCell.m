//
//  FvaProDetailLastImageCell.m
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaProDetailLastImageCell.h"

@implementation FvaProDetailLastImageCell
@synthesize heradlable;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        heradlable = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 30)];
        [heradlable setFont:[UIFont fontWithName:KUIFont size:13]];
        [self addSubview:heradlable];
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
