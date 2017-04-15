//
//  FvaProDetailaccpCell.m
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaProDetailaccpCell.h"

@implementation FvaProDetailaccpCell
@synthesize acppadress,allpeonum;
- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [acppadress setTitle:@"http://www.baidu.com" forState:UIControlStateNormal ];
     allpeonum.titleLabel.text = @"7758258";
    allpeonum.titleLabel.textColor = [UIColor blackColor];
    address =acppadress.titleLabel.text;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)acppbt:(UIButton *)sender {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:acppadress.titleLabel.text]];

}
@end
