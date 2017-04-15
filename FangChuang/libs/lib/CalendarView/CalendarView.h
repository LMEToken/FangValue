//
//  CalendarView.h
//  CalendarTest
//
//  Created by 潘鸿吉 on 14-1-7.
//  Copyright (c) 2014年 潘鸿吉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarStyle.h"

typedef void(^block)(NSDate *date,NSString *str) ;

typedef NS_ENUM(NSInteger, WeekTitleStyle) {
    WeekTitleStyleOneWord = 1,      //S , M , T , W , T , F , S
    WeekTitleStyleThreeWord = 2,    //Sun , Mon , Tue , Wed , Thu , Fri , Sat
    WeekTitleStyleAllWord = 3,      //Sunday , Monday , Tuesday , Wednesday , Thursday , Friday , Saturday
};

typedef NS_ENUM(NSInteger, DateTitleStyle) {
    DateTitleStyleThreeWordMonthYear = 1,  //Jan 2014
    DateTitleStyleThreeWordYearMonth = 2,  //2013 Jan
    DateTitleStyleAllWordMonthYear = 3,    //January 2014
    DateTitleStyleAllWordYearMonth = 4,    //2014 January
    DateTitleStyleDigitalMonthYear = 5,    //1-2014
    DateTitleStyleDigitalYearMonth = 6,    //2014-1
};

typedef NS_ENUM(NSInteger, CalendarLanguage) {
    CalendarLanguageChinese = 1,
    CalendarLanguageEnglish = 2,
};

@protocol CalendarViewDelegate <NSObject>
@required
- (void) calendarViewDidSelectDate : (NSDate*) date todayDate : (NSDate*) todayDate;

@end

@interface CalendarView : UIView <CalendarStyleDelegate>
{
    float       selfWidth;
    float       selfHeight;
    //日期标题view
    UIView      *dateTitleView;
    float       dateTitleHeight;
    UIButton    *leftButton;
    UIButton    *rightButton;
    
    //周日-周六view
    UIView      *weekTitleView;
    float       weekTitleHeight;
    
    //1-31 view
    UIView      *dayView;
    float       dayViewHeight;
    NSArray     *dateArray;
    
    block callBack;
}

@property (nonatomic , assign , readonly) NSDate   *todayDate;
@property (nonatomic , assign , readonly) NSDate   *currentDate;
@property (nonatomic , assign) CalendarLanguage     language;
@property (nonatomic , assign) DateTitleStyle       dateTitleStyle;
@property (nonatomic , assign) WeekTitleStyle       weekTitleStyle;
@property (nonatomic , assign) id <CalendarViewDelegate> delegate;
@property (nonatomic , assign) UILabel  *dateTitleLabel; //日期标题文字label
@property (nonatomic , assign) NSDate   *selectDate;
@property (nonatomic , assign) CalendarStyle   *calendarStyle;
@property (nonatomic , assign) NSArray  *selectDateArray;
@property (nonatomic , assign) NSMutableArray *selectedDateColorArray;

#pragma mark - 属性设置
#pragma mark 设置语言版本
- (void) setCalendarLanguage : (CalendarLanguage) lang;

#pragma mark 设置日期标题背景色
- (void) setDateTitleBackgroundColor : (UIColor*) color;

#pragma mark 设置日记标题左右按钮偏移量
- (void) setDateTitleButtonOffset : (CGPoint) point;

#pragma mark 设置周标题格式
- (void) setWeekTitleStyle : (WeekTitleStyle) style;

#pragma mark 设置周标题文字大小
- (void) setWeekTitleTextSize : (float) size;

#pragma mark 设置周标题文字颜色
- (void) setWeekTitleTextColor : (UIColor*) color;

#pragma mark 设置周标题文字字体
- (void) setWeekTitleTextFont : (UIFont*) font;

-(void)refleshriCheng:(block)db;
@end
