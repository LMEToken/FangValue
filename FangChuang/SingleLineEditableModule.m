//
//  SingleLineEditableModule.m
//  FangChuang
//
//  Created by omni on 14-4-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//添加项目，基本项目信息
#import "SingleLineEditableModule.h"
#import "RTLabel.h"

@implementation SingleLineEditableModule

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
- (id)initWithFrame:(CGRect)frame WithTitle:(NSString*)title{
    return [self initWithFrame:frame WithTitle:title WithTitleColor:Nil];
}

- (id)initWithFrame:(CGRect)frame WithTitle:(NSString *)title WithTitleColor:(UIColor *)color{
    self  = [super initWithFrame:frame];
    if (self) {
        
        //处理背景图片
        UIImage* image = [UIImage imageNamed:@"005_pinglunkuang_2.png"];
        UIImage* newImg = [image stretchableImageWithLeftCapWidth:100 topCapHeight:100];
        
        
        backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [backImageView setImage:newImg];
        backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:backImageView];
        
        CGSize titleSize = [title sizeWithFont:[UIFont fontWithName:@"Helvetica" size:16]];
        
        
        NSString* titleString = [NSString stringWithFormat:
                                 @"<font face='Helvetica' size=16 color=%@> %@ </font>",
                                 color ? color : @"orange",
                                 title];
        CGFloat height = CGRectGetMinY(backImageView.frame) + 5;

        RTLabel* titleLb = [[RTLabel alloc] initWithFrame:CGRectMake(5, height, titleSize.width+10, CGRectGetHeight(frame)-10)];
        [titleLb setText:titleString];
        [titleLb setBackgroundColor:[UIColor clearColor]];
        [self addSubview:titleLb];

        _textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLb.frame), height-3, CGRectGetWidth(frame)-titleSize.width-20, CGRectGetHeight(frame)-10)];
        [self.textView setBackgroundColor:[UIColor clearColor]];
        self.textView.text = self.titleStr;
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.textView.minNumberOfLines = 1;
        self.textView.maxNumberOfLines = 8;
        self.textView.isScrollable = NO;
        self.textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        self.textView.returnKeyType = UIReturnKeyDone;
        self.textView.placeholder = @"请添加...";
        
        self.textView.font = [UIFont fontWithName:@"Helvetica" size:16];
        [self addSubview:self.textView];
        
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
