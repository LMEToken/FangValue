//
//  FvaProDetailHeradCell.m
//  FangChuang
//
//  Created by weiping on 14-9-18.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaProDetailHeradCell.h"

@implementation FvaProDetailHeradCell
{
    NSInteger page;
}
@synthesize imageone1,imageone2,imageone3,allimageview,imageScrollView,pageControl;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

       self.selectionStyle = UITableViewCellSelectionStyleNone;

//        UIImageView *backview= [[UIImageView alloc]init];
//        backview.image = [UIImage imageNamed:@"companylogo"];
//        [self setBackgroundView:backview];
//        
//        //显示公司的标签。
//        UIImageView *lable1= [[UIImageView alloc]initWithFrame:CGRectMake(17, 100, 22, 11)];
//         lable1.image = [UIImage imageNamed:@"lable1"];
//        [self addSubview:lable1];
//        UIImageView *lable2= [[UIImageView alloc]initWithFrame:CGRectMake(43, 100, 22, 11)];
//        lable2.image = [UIImage imageNamed:@"lable2"];
//        [self addSubview:lable2];
//        UIImageView *lable3=  [[UIImageView alloc]initWithFrame:CGRectMake(70, 100, 22, 11)];
//        lable3.image = [UIImage imageNamed:@"lable3"];
//        [self addSubview:lable3];
//
//        page  = 3;
//        allimageview = [[UIView alloc]initWithFrame:CGRectMake(17, 20, 280, 150)];
//        imageone1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 65)];
//        imageone1.image = [UIImage imageNamed:@"company1"];
//        [allimageview addSubview:imageone1];
//        imageone2 = [[UIImageView alloc]initWithFrame:CGRectMake(105, 0, 80, 65)];
//        imageone2.image = [UIImage imageNamed:@"company2"];
//        [allimageview addSubview:imageone2];
//        imageone3 = [[UIImageView alloc]initWithFrame:CGRectMake(210, 0, 80, 65)];
//        imageone3.image = [UIImage imageNamed:@"company3"];
//        [allimageview addSubview:imageone3];
//        [self addSubview:allimageview];
//        
//        UISwipeGestureRecognizer *recognizerLeft;
//        recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromLeft:)];
//        [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//        [allimageview addGestureRecognizer:recognizerLeft];
//        
//        //向左滑动
//        UISwipeGestureRecognizer *recognizerRight;
//        recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromRight:)];
//        [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
//        [allimageview addGestureRecognizer:recognizerRight];
//   
//        
  }
    return self;
}

-(void)handleSwipeFromLeft:(UISwipeGestureRecognizer *)recognizer {
    
    NSLog(@"右滑滑");
    
}
-(void)handleSwipeFromRight:(UISwipeGestureRecognizer *)recognizer {
    
    NSLog(@"左滑滑");
    
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
