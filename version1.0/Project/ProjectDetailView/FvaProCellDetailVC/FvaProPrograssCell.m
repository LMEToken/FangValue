//
//  FvaProPrograssCell.m
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaProPrograssCell.h"

@implementation FvaProPrograssCell
@synthesize prograse,graselabe;
- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    prograse.value = 50;
    prograse.userInteractionEnabled = NO;
    [graselabe setTitle:[NSString stringWithFormat:@"%%%d",(int)prograse.value] forState:UIControlStateNormal];
//    prograselable.text = [NSString stringWithFormat:@"%%%d",(int)prograse.value];
//    [prograselable setFont:[UIFont fontWithName:KUIFont size:13]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)DetailBT:(UIButton *)sender {
    NSLog(@"你想看就看");
}
@end
