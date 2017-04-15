//
//  ModuleView.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-4.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//2014.07.10 chenlihua 商业计划部分用
#import "ModuleView.h"
#import "RTLabel.h"
#define BUTTONTAG 333

@implementation ModuleView

@synthesize titleArray;
@synthesize contentArray;
@synthesize titleColor;
@synthesize contentColor;




- (id)initWithFrame:(CGRect)frame
         titleArray:(NSArray*)tlArray
       contentArray:(NSArray*)ctArray
         titleColor:(NSString*)tlColor
       contentColor:(NSString*)ctColor
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleArray = tlArray;
        self.contentArray = ctArray;
        self.titleColor = tlColor;
        self.contentColor = ctColor;
        
        
        //处理图片
        UIImage* image = [UIImage imageNamed:@"005_pinglunkuang_2.png"];
        UIImage* newImg = [image stretchableImageWithLeftCapWidth:100 topCapHeight:100];
        
        //背景图片
        backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [backImageView setImage:newImg];
        [self addSubview:backImageView];
        
        
        CGFloat height = CGRectGetMinY(backImageView.frame) + 5;
        for (int i = 0; i < self.titleArray.count; i ++) {
           
            NSString* string = [NSString stringWithFormat:
                                @"<font face='Helvetica' size=14 color=%@> %@ </font> <font face=AmericanTypewriter size=14 color=%@> %@ </font> ",
                                self.titleColor ? self.titleColor : @"orange",
                                [self.titleArray objectAtIndex:i] ,
                                self.contentColor ? self.contentColor : @"gray",
                                [self.contentArray objectAtIndex:i] ];
            
            
            RTLabel* titleLb = [[RTLabel alloc] initWithFrame:CGRectMake( 5, height , CGRectGetWidth(frame) - 10, 20)];
            [titleLb setParagraphReplacement:@" "];
            [titleLb setTag:BUTTONTAG + i];
            [titleLb setText:string];
            [titleLb setBackgroundColor:[UIColor clearColor]];
            [self addSubview:titleLb];
            
            CGSize size = [titleLb optimumSize];
            [titleLb setFrame:CGRectMake(5, height, CGRectGetWidth(frame) - 10, size.height)];
            
            height = CGRectGetMaxY(titleLb.frame) + 5;
            
            NSLog(@"height = %f",height);
        }
        [self setFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) , CGRectGetWidth(frame), height )];

        [backImageView setFrame:CGRectMake(0, 0 , CGRectGetWidth(frame), height )];
    }
    return self;
}


- (void)setDataWithArray:(NSArray*)array
{
    
    __block CGFloat y = CGRectGetMinY(backImageView.frame);
    
    [self.subviews enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //停止遍历
        if ([obj isKindOfClass:[UIImageView class]]) {
//            *stop = YES;
            
        }
        
        if ([obj isKindOfClass:[RTLabel class]]) {
            
            RTLabel* label = (RTLabel*)obj;
            
            [label setText:[NSString stringWithFormat:
                                               @"<font face='Helvetica' size=14 color=%@> %@ </font> <font face=AmericanTypewriter size=14 color=%@> %@ </font> ",
                                               self.titleColor ? self.titleColor : @"orange",
                                               [self.titleArray objectAtIndex:label.tag - BUTTONTAG] ,
                                               self.contentColor ? self.contentColor : @"gray",
                                               [array objectAtIndex:label.tag - BUTTONTAG] ]];
            CGSize size = [label optimumSize];
            [label setFrame:CGRectMake(5, y, CGRectGetWidth(label.frame) - 10, size.height)];
            
            [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame) , CGRectGetWidth(self.frame), CGRectGetMaxY(label.frame) + 5 )];
            
            [backImageView setFrame:CGRectMake(0, 0 , CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) )];
         
            y = CGRectGetMaxY(label.frame) + 5;
        }
        
        
    }];
    
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
