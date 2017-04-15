//
//  CalendarStyle.m
//  CalendarTest
//
//  Created by 潘鸿吉 on 14-1-16.
//  Copyright (c) 2014年 潘鸿吉. All rights reserved.
//

#import "CalendarStyle.h"

@implementation CalendarStyle

@synthesize borderColor;
@synthesize todayColor;
@synthesize selectColor;
@synthesize style;
@synthesize font;
@synthesize todayTextColor;
@synthesize selectTextColor;
@synthesize thisMonthColor;
@synthesize otherMonthColor;
@synthesize thisMonthTextColor;
@synthesize otherMonthTextColor;
@synthesize selectDateArrayColor;
@synthesize selectDateArrayTextColor;
@synthesize delegate;

- (void)dealloc
{
    if (borderColor) {
        [borderColor release];
        borderColor = nil;
    }
    
    if (todayColor) {
        [todayColor release];
        todayColor = nil;
    }
    
    if (selectColor) {
        [selectColor release];
        selectColor = nil;
    }
    
    if (font) {
        [font release];
        font = nil;
    }
    
    if (todayTextColor) {
        [todayTextColor release];
        todayTextColor = nil;
    }
    
    if (selectTextColor) {
        [selectTextColor release];
        selectTextColor = nil;
    }
    
    if (thisMonthColor) {
        [thisMonthColor release];
        thisMonthColor = nil;
    }
    
    if (otherMonthColor) {
        [otherMonthColor release];
        otherMonthColor = nil;
    }
    
    if (thisMonthTextColor) {
        [thisMonthTextColor release];
        thisMonthTextColor = nil;
    }
    
    if (otherMonthTextColor) {
        [otherMonthTextColor release];
        otherMonthTextColor = nil;
    }
    
    if (selectDateArrayColor) {
        [selectDateArrayColor release];
        selectDateArrayColor = nil;
    }
    
    if (selectDateArrayTextColor) {
        [selectDateArrayTextColor release];
        selectDateArrayTextColor = nil;
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setBorderColor:[UIColor lightGrayColor]];
        [self setTodayColor:[UIColor colorWithRed:81.0f/255.0f green:196/255.0f blue:212/255.0f alpha:1.0f]];
        [self setSelectColor:[UIColor redColor]];
        [self setStyle:CalendarDateSelectStyleBorder];
        [self setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
        [self setTodayTextColor:[UIColor darkGrayColor]];
        [self setSelectTextColor:[UIColor darkGrayColor]];
        [self setThisMonthColor:[UIColor whiteColor]];
        [self setOtherMonthColor:[UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0f]];
        [self setThisMonthTextColor:[UIColor darkGrayColor]];
        [self setOtherMonthTextColor:[UIColor darkGrayColor]];
        [self setSelectDateArrayColor:[UIColor blueColor]];
        [self setSelectDateArrayTextColor:[UIColor brownColor]];
    }
    return self;
}

-(void)setBorderColor:(UIColor *)_borderColor
{
    if (_borderColor) {
        if (borderColor) {
            [borderColor release];
            borderColor = nil;
        }
        borderColor = [_borderColor retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setTodayColor:(UIColor *)_todayColor
{
    if (_todayColor) {
        if (todayColor) {
            [todayColor release];
            todayColor = nil;
        }
        todayColor = [_todayColor retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setSelectColor:(UIColor *)_selectColor
{
    if (_selectColor) {
        if (selectColor) {
            [selectColor release];
            selectColor = nil;
        }
        selectColor = [_selectColor retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setStyle:(CalendarDateSelectStyle)_style
{
    if (_style) {
        style = _style;
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setFont:(UIFont *)_font
{
    if (_font) {
        if (font) {
            [font release];
            font = nil;
        }
        font = [_font retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setTodayTextColor:(UIColor *)_todayTextColor
{
    if (_todayTextColor) {
        if (todayTextColor) {
            [todayTextColor release];
            todayTextColor = nil;
        }
        todayTextColor = [_todayTextColor retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setSelectTextColor:(UIColor *)_selectTextColor
{
    if (_selectTextColor) {
        if (selectTextColor) {
            [selectTextColor release];
            selectTextColor = nil;
        }
        selectTextColor = [_selectTextColor retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setThisMonthColor:(UIColor *)_thisMonthColor
{
    if (_thisMonthColor) {
        if (thisMonthColor) {
            [thisMonthColor release];
            thisMonthColor = nil;
        }
        thisMonthColor = [_thisMonthColor retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setOtherMonthColor:(UIColor *)_otherMonthColor
{
    if (_otherMonthColor) {
        if (otherMonthColor) {
            [otherMonthColor release];
            otherMonthColor = nil;
        }
        otherMonthColor = [_otherMonthColor retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setThisMonthTextColor:(UIColor *)_thisMonthTextColor
{
    if (_thisMonthTextColor) {
        if (thisMonthTextColor) {
            [thisMonthTextColor release];
            thisMonthTextColor = nil;
        }
        thisMonthTextColor = [_thisMonthTextColor retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setOtherMonthTextColor:(UIColor *)_otherMonthTextColor
{
    if (_otherMonthTextColor) {
        if (otherMonthTextColor) {
            [otherMonthTextColor release];
            otherMonthTextColor = nil;
        }
        otherMonthTextColor = [_otherMonthTextColor retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setSelectDateArrayColor:(UIColor *)_selectDateArrayColor
{
    if (_selectDateArrayColor) {
        if (selectDateArrayColor) {
            [selectDateArrayColor release];
            selectDateArrayColor = nil;
        }
        selectDateArrayColor = [_selectDateArrayColor retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

-(void)setSelectDateArrayTextColor:(UIColor *)_selectDateArrayTextColor
{
    if (_selectDateArrayTextColor) {
        if (selectDateArrayTextColor) {
            [selectDateArrayTextColor release];
            selectDateArrayTextColor = nil;
        }
        selectDateArrayTextColor = [_selectDateArrayTextColor retain];
        
        if (delegate && [delegate respondsToSelector:@selector(calendarStyleVauleChange)]) {
            [delegate calendarStyleVauleChange];
        }
    }
}

@end
