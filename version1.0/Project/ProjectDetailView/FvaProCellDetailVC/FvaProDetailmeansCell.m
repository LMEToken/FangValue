//
//  FvaProDetailmeansCell.m
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaProDetailmeansCell.h"

@implementation FvaProDetailmeansCell
@synthesize worlbt,worlbt2,worlbt3;
- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [worlbt setBackgroundImage:[UIImage imageNamed:@"means1"] forState:UIControlStateNormal];
    [worlbt2 setBackgroundImage:[UIImage imageNamed:@"means2"] forState:UIControlStateNormal];
    [worlbt3 setBackgroundImage:[UIImage imageNamed:@"means3"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)worlbt1:(UIButton *)sender {
    NSLog(@"点击了我");
}

- (IBAction)worlbt2:(UIButton *)sender {
    NSLog(@"点击了我");
}

- (IBAction)worlbt3:(UIButton *)sender {
    NSLog(@"点击了我");
}
@end
