//
//  BorderLabel.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-31.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "BorderLabel.h"

@implementation BorderLabel



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setNumberOfLines:0];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    //获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    //设置线条宽度
    CGContextSetLineWidth(context, .5f);
    
    //设置线条颜色
//    CGContextSetRGBStrokeColor(context, 219 / 255. , 219 / 255., 219 / 255., 1.0);
    
    //设置线条颜色
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    
    //    //设置灰色
    //    CGContextSetGrayStrokeColor(context, 1., 1.);
    
    //设置填充颜色
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    //开始起始路径 (0,0)
    CGContextBeginPath(context);
    
    //移动
    CGContextMoveToPoint(context, 0, 0);
    
    //划线 矩形边框
    CGContextAddLineToPoint(context, CGRectGetWidth(rect), 0);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGContextAddLineToPoint(context, 0, CGRectGetHeight(rect));
    CGContextAddLineToPoint(context, 0, 0);
    
    
    
    
    //连接点
    CGContextStrokePath(context);
//    CGContextClosePath(context);
    
//
//    
//    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)[self illuminatedString:self.text font:self.font]);
//
//    CGContextSetTextPosition(context, 0.0, 0.0);
//    
//    CTLineDraw(line, context);
////    CGContextRestoreGState(context);
//    CFRelease(line);
    
}


- (NSAttributedString *)illuminatedString:(NSString *)text
                                     font:(UIFont *)AtFont{
    
    NSLog(@"text = %@, fon = %@",text,AtFont);
    int len = [text length];
    //创建一个可变的属性字符串
    NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc] initWithString:@"adflkajdflajdflaj"];
    //改变字符串 从1位 长度为1 这一段的前景色，即字的颜色。
    
    [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName)
                       value:(id)self.textColor.CGColor
                       range:NSMakeRange(0, len)];
    return mutaString;
}

/**/

@end
