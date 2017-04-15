//
//  CalendarStyle.h
//  CalendarTest
//
//  Created by 潘鸿吉 on 14-1-16.
//  Copyright (c) 2014年 潘鸿吉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CalendarDateSelectStyle) {
    CalendarDateSelectStyleBorder = 1,
    CalendarDateSelectStyleFill = 2,
};

@protocol CalendarStyleDelegate <NSObject>

- (void) calendarStyleVauleChange;

@end

@interface CalendarStyle : NSObject
@property (nonatomic , retain) UIColor *borderColor;
@property (nonatomic , retain) UIColor *todayColor;
@property (nonatomic , retain) UIColor *selectColor;
@property (nonatomic , assign) CalendarDateSelectStyle    style;
@property (nonatomic , retain) UIFont *font;
@property (nonatomic , retain) UIColor *todayTextColor;
@property (nonatomic , retain) UIColor *selectTextColor;
@property (nonatomic , retain) UIColor *thisMonthColor;
@property (nonatomic , retain) UIColor *otherMonthColor;
@property (nonatomic , retain) UIColor *thisMonthTextColor;
@property (nonatomic , retain) UIColor *otherMonthTextColor;
@property (nonatomic , retain) UIColor *selectDateArrayColor;
@property (nonatomic , retain) UIColor *selectDateArrayTextColor;

@property (nonatomic , assign) id <CalendarStyleDelegate> delegate;
@end
