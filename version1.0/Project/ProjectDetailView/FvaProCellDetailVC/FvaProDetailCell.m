//
//  FvaProDetailCell.m
//  FangChuang
//
//  Created by weiping on 14-9-18.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaProDetailCell.h"

@implementation FvaProDetailCell
@synthesize heradlable,detailetext,lookbt;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
 
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = NO;
        heradlable = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 30)];
        [heradlable setFont:[UIFont fontWithName:KUIFont size:12]];
        heradlable.textColor = [UIColor grayColor];
        [self addSubview:heradlable];
        detailetext = [[UITextView alloc]init];
        [detailetext setFont:[UIFont fontWithName:KUIFont size:12]];
        //        detailetext.text = @"1.团队执行力强，创始人在商业地产及互联网项目均有创业经验。执行力强";
        [self addSubview:detailetext];
        lookbt =[ [UIButton alloc]initWithFrame:CGRectMake(230, 55, 80, 20)];
//         lookbt.backgroundColor = [UIColor redColor];

        lookbt.hidden = YES;
        [self addSubview:lookbt];
   


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
