//
//  FvaMecell.m
//  FangChuang
//
//  Created by weiping on 14-9-23.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaMecell.h"

@implementation FvaMecell
@synthesize  leftlable,rightimage,cellline;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor redColor];
        rightimage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 5, 40, 40)];
        [self addSubview:rightimage];
        
        cellline = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0, 260, 1)];
        cellline.image = [UIImage imageNamed:@"cellfenge"];
        [self addSubview:cellline];
        
        leftlable =  [[UILabel alloc]initWithFrame:CGRectMake(110, 5, 70, 40)];
        [leftlable setFont:[UIFont fontWithName:KUIFont size:15]];
        [leftlable setTextColor:[UIColor grayColor]];
        [self addSubview:leftlable];
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
