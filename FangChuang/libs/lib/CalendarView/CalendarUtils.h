//
//  CalendarUtils.h
//  CalendarTest
//
//  Created by 潘鸿吉 on 14-1-10.
//  Copyright (c) 2014年 潘鸿吉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarUtils : NSObject
+ (float) getNextHeight : (id) sender;
+ (void) showAlertView : (NSString*) str;
+ (NSString*) dateToString : (NSDate*) date;
+ (NSDate*) stringToDate : (NSString*) string;
+ (NSDate*) getTodayDate;
+ (NSString*) getYearAndMonth : (NSDate*) date style : (NSInteger) style language : (NSInteger) lang;
+ (NSDate*) getLastDate : (NSDate*)date;
+ (NSDate*) getNextDate : (NSDate*)date;
+ (NSInteger) getMonthHasDays : (NSDate*) date;
+ (NSInteger) getFirstDayInMonthForWeek : (NSDate*) date;
+ (NSDate*) getFirstDayWithDate : (NSDate*) date;
+ (NSArray*) getDaysWithDate : (NSDate*) date;
+ (NSDate*) getLastDay : (NSDate*) date;
+ (NSDate*) getNextDay : (NSDate*) date;
+ (NSInteger) getDayForDate : (NSDate*) date;
+ (NSInteger) getMonthForDate : (NSDate*) date;

+ (NSArray*) getWeekDaysArrayWithWeekStyle : (NSInteger) style language : (NSInteger) lang;
+ (NSArray*) getMonthDaysArrayWithLanguage : (NSInteger) lang style : (NSInteger) style;

@end
