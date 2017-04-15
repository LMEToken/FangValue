//
//  EditModuleView.m
//  FangChuang
//
//  Created by omni on 14-4-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "EditModuleView.h"
#import "RTLabel.h"
#define TEXTTAG 333

@implementation EditModuleView


- (id)initWithFrame:(CGRect)frame titleArray:(NSArray *)tlArray contentArray:(NSArray *)ctArray titleColor:(NSString *)tlColor contentColor:(NSString *)ctColor{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = tlArray;
        self.contentArray = ctArray;
        self.titleColor = tlColor;
        self.contentColor = ctColor;
        
        //处理背景图片
        
        UIImage* image = [UIImage imageNamed:@"005_pinglunkuang_2.png"];
        UIImage* newImg = [image stretchableImageWithLeftCapWidth:100 topCapHeight:100];
        
        
        backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [backImageView setImage:newImg];
        [self addSubview:backImageView];
        
        CGFloat height = CGRectGetMinY(backImageView.frame) + 5;

        for (int i = 0; i < self.titleArray.count; i ++) {
            
            NSString* titleString = [NSString stringWithFormat:
                                @"<font face='Helvetica' size=14 color=%@> %@ </font>",
                                self.titleColor ? self.titleColor : @"orange",
                                [self.titleArray objectAtIndex:i]];
            
            RTLabel* titleLb = [[RTLabel alloc] initWithFrame:CGRectMake(5, height, 100, 25)];
            [titleLb setText:titleString];
            [titleLb setBackgroundColor:[UIColor clearColor]];
            [self addSubview:titleLb];

            NSString* contentString = [self.contentArray objectAtIndex:i];
            UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLb.frame)+5, height-3, CGRectGetWidth(frame)-100-15, 25)];
            [textView setBackgroundColor:[UIColor clearColor]];
            textView.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
            textView.text = contentString;
            [textView setTag:TEXTTAG+i];
            
            [self addSubview:textView];
         
            height = CGRectGetMaxY(titleLb.frame) + 5;

        }
        [self setFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), height)];
        [backImageView setFrame:CGRectMake(0, 0 , CGRectGetWidth(frame), height )];

    }
    
    return self;
}

- (void)setDataWithArray:(NSArray *)array
{
    [self.subviews enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[UIImageView class]]) {
            //停止遍历
        };
        if ([obj isKindOfClass:[UITextView class]]) {
            UITextView* textV = (UITextView*)obj;

            NSString* titleString = [self.titleArray objectAtIndex:textV.tag-TEXTTAG];
            textV.text = titleString;
        
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
