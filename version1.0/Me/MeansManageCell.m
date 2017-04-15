//
//  MeansManageCell.m
//  FangChuang
//
//  Created by weiping on 14-10-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "MeansManageCell.h"

@implementation MeansManageCell
@synthesize rightlable,lefttext,imageline,heradimageline;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
         self.selectionStyle = UITableViewCellSelectionStyleNone;
        rightlable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 70, 30)];
        [rightlable setTextColor:[UIColor grayColor]];
       // rightlable.text = @"方创";
         
        [rightlable setFont:[UIFont fontWithName:KUIFont size:13]];
       [self addSubview:rightlable];
        
        lefttext = [[UITextField alloc]initWithFrame:CGRectMake(140, 10, 160, 30)];
        lefttext.textAlignment =NSTextAlignmentRight;
        [lefttext setFont:[UIFont fontWithName:KUIFont size:11]];
           lefttext.textColor = [UIColor blackColor];
         [self addSubview:lefttext];
//        lefttext.text = @"必填";
//        NSLog(@"%f",self.frame.size.height);
        
       imageline = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 290, 1)];
       imageline.image = [UIImage imageNamed:@"celllin@2x"];
         [self addSubview:imageline];
        
//        heradimageline = [[UIImageView alloc]initWithFrame:CGRectMake(15, 71, 290, 1)];
//         heradimageline.image = [UIImage imageNamed:@"celllin@2x"];
//        heradimageline.hidden=  YES;
//        [self addSubview: heradimageline];
        
               
        

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
