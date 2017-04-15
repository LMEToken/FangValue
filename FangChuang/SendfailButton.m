//
//  SendfailButton.m
//  FangChuang
//
//  Created by weiping on 14-9-15.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "SendfailButton.h"

@implementation SendfailButton
@synthesize btimage,ActivityIndicator;
@synthesize stated;
- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
      stated = @"0";
        [self setBackgroundImage:btimage.image forState: UIControlStateNormal ];
        btimage = [[UIImageView alloc]init];
        [btimage setImage:[UIImage imageNamed:@"duanwang"]];
        btimage.center =CGPointMake(100.0f, 100.0f);
        [btimage setFrame:CGRectMake(0,0, 20, 20)];
        [self addSubview:btimage];

        ActivityIndicator =[ [UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        ActivityIndicator.center = CGPointMake(100.0f, 100.0f);
        [ActivityIndicator setFrame:CGRectMake(0,0, 20, 20)];
       ActivityIndicator.color = [UIColor grayColor];
        [self  addSubview:ActivityIndicator];
   
 



        // Initialization code
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
