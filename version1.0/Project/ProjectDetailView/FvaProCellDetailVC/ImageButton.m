//
//  ImageButton.m
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ImageButton.h"

@implementation ImageButton
@synthesize btimageview,btlable;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        btimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        btlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 40, 30)];
        [self addSubview:btlable];
        [self addSubview:btimageview];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
