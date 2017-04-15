//
//  CalendarUtils.m
//  CalendarTest
//
//  Created by 潘鸿吉 on 14-1-10.
//  Copyright (c) 2014年 潘鸿吉. All rights reserved.
//

#import "CalendarUtils.h"

#define CalendarLanguageChinese 1
#define CalendarLanguageEnglish 2

#define WeekTitleStyleOneWord 1
#define WeekTitleStyleThreeWord 2
#define WeekTitleStyleAllWord 3

#define DateTitleStyleThreeWordMonthYear 1
#define DateTitleStyleThreeWordYearMonth 2
#define DateTitleStyleAllWordMonthYear 3
#define DateTitleStyleAllWordYearMonth 4
#define DateTitleStyleDigitalMonthYear 5
#define DateTitleStyleDigitalYearMonth 6

@implementation CalendarUtils

+ (float) getNextHeight : (id) sender
{
    if ([sender respondsToSelector:@selector(frame)]) {
        float height = [sender frame].size.height + [sender frame].origin.y;
        return height;
    }
    return 0;
}

+ (void) showAlertView : (NSString*) str
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

+ (NSString*) dateToString : (NSDate*) date
{
    //通过NSDateFormatter获取NSDate对象的NSString对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    [formatter release];
    
    return dateString;
}

+ (NSDate*) stringToDate : (NSString*) string
{
    //通过NSDateFormatter获取日期字符串的NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:string];
    [formatter release];
    
    return date;
}

+ (NSDate*) getTodayDate
{
    NSDate *date = [NSDate date];
    
    NSCalendar  * calendar = [[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSUInteger  unitFlags = NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    [component setTimeZone:[NSTimeZone systemTimeZone]];
    [component setHour:0];
    [component setMinute:0];
    [component setSecond:0];
    
    NSDate *todayDate = [calendar dateFromComponents:component];
    
    //改变NSDate对象的GMT市区
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];

    return todayDate;
}

+ (NSString*) getYearAndMonth : (NSDate*) date style : (NSInteger) style language : (NSInteger) lang
{
    NSCalendar  * calendar = [[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSUInteger  unitFlags = NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    [component setTimeZone:[NSTimeZone systemTimeZone]];
    NSInteger year = [component year];
    NSInteger month = [component month];

    /*
     DateTitleStyleThreeWordMonthYear = 1,  //Jan 2014
     DateTitleStyleThreeWordYearMonth = 2,  //2013 Jan
     DateTitleStyleAllWordMonthYear = 3,    //January 2014
     DateTitleStyleAllWordYearMonth = 4,    //2014 January
     DateTitleStyleDigitalMonthYear = 5,    //1 2014
     DateTitleStyleDigitalYearMonth = 6,    //2014 1
    */
    
    NSString *string = nil;
    NSString *monthStr = [NSString stringWithFormat:@"%@", [[CalendarUtils getMonthDaysArrayWithLanguage:lang style:style] objectAtIndex:month-1]];
    NSString *yearString = [NSString stringWithFormat:@"%i" ,year];
    if (style == DateTitleStyleThreeWordMonthYear || style == DateTitleStyleAllWordMonthYear || style == DateTitleStyleDigitalMonthYear) {
        string = [NSString stringWithFormat:@"%@ %@" , monthStr , yearString];
    }
    else if (style == DateTitleStyleThreeWordYearMonth || style == DateTitleStyleAllWordYearMonth || style == DateTitleStyleDigitalYearMonth)
    {
        string = [NSString stringWithFormat:@"%@ %@" , yearString , monthStr];
    }
    return string;
}

+ (NSDate*) getLastDate : (NSDate*)date
{
    NSCalendar  * calendar = [[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSUInteger  unitFlags = NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    [component setTimeZone:[NSTimeZone systemTimeZone]];
    [component setMonth:[component month]-1];
    [component setDay:1];
//    [component setHour:0];
    NSDate *lastDate = [calendar dateFromComponents:component];
    return lastDate;
}

+ (NSDate*) getNextDate : (NSDate*)date
{
    NSCalendar  * calendar = [[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSUInteger  unitFlags = NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    [component setTimeZone:[NSTimeZone systemTimeZone]];
    [component setMonth:[component month]+1];
    [component setDay:1];
//    [component setHour:0];
    NSDate *nextDate = [calendar dateFromComponents:component];
    return nextDate;
}

+ (NSInteger) getMonthHasDays : (NSDate*) date
{
    NSCalendar *c = [[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSLog(@"length : %i , location : %i" , days.length , days.location);
    return days.length;
}

+ (NSInteger) getFirstDayInMonthForWeek : (NSDate*) date
{
    NSCalendar  * calendar = [[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSUInteger  unitFlags = NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    [component setTimeZone:[NSTimeZone systemTimeZone]];
    NSInteger weekDay = [component weekday];
    return weekDay;
}

+ (NSDate*) getFirstDayWithDate : (NSDate*) date
{
    NSCalendar  * calendar = [[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSUInteger  unitFlags = NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    [component setTimeZone:[NSTimeZone systemTimeZone]];
    [component setDay:1];

    return [calendar dateFromComponents:component];
}

+ (NSArray*) getDaysWithDate : (NSDate*) date
{
    NSInteger weekday = [CalendarUtils getFirstDayInMonthForWeek:date];
    
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    
    NSDate *lastDay = date;
    
    for (int i = weekday - 1; i > 0; i--) {
        lastDay = [CalendarUtils getLastDay:lastDay];
        [dateArray insertObject:lastDay atIndex:0];
    }
    
    NSDate *nextDate = date;
    for (int i = 0; i < 42 - (weekday - 1); i++) {
        if (i != 0) {
            nextDate = [CalendarUtils getNextDay:nextDate];
        }
        [dateArray addObject:nextDate];
    }
    
    return [dateArray autorelease];
}

+ (NSDate*) getLastDay : (NSDate*) date
{
    NSCalendar  * calendar = [[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSUInteger  unitFlags = NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    [component setTimeZone:[NSTimeZone systemTimeZone]];
    [component setHour:-24];
    NSDate *lastDay = [calendar dateFromComponents:component];
    return lastDay;
}

+ (NSDate*) getNextDay : (NSDate*) date
{
    NSCalendar  * calendar = [[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSUInteger  unitFlags = NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    [component setTimeZone:[NSTimeZone systemTimeZone]];
    [component setHour:24];
    NSDate *nextDay = [calendar dateFromComponents:component];
    return nextDay;
}

+ (NSInteger) getDayForDate : (NSDate*) date
{
    NSCalendar  * calendar = [[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSUInteger  unitFlags = NSCalendarUnitDay;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    return [component day];
}

+ (NSInteger) getMonthForDate : (NSDate*) date
{
    NSCalendar  * calendar = [[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSUInteger  unitFlags = NSCalendarUnitMonth;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    return [component month];
}

+ (NSArray*) getWeekDaysArrayWithWeekStyle : (NSInteger) style language : (NSInteger) lang
{
    NSArray *titleArray;
    if (lang == CalendarLanguageEnglish) {
        if (style == WeekTitleStyleOneWord) {
            titleArray = [NSArray arrayWithObjects:@"S",@"M",@"T",@"W",@"T",@"F",@"S", nil];
        }
        else if (style == WeekTitleStyleThreeWord)
        {
            titleArray = [NSArray arrayWithObjects:@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat", nil];
        }
        else if (style == WeekTitleStyleAllWord)
        {
            titleArray = [NSArray arrayWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
        }
        else
        {
            titleArray = nil;
        }
    }
    else if (lang == CalendarLanguageChinese)
    {
        if (style == WeekTitleStyleOneWord) {
            titleArray = [NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
        }
        else if (style == WeekTitleStyleThreeWord)
        {
            titleArray = [NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
        }
        else if (style == WeekTitleStyleAllWord)
        {
            titleArray = [NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
        }
        else
        {
            titleArray = nil;
        }
    }
    else
    {
        titleArray = nil;
    }
    return titleArray;
}

+ (NSArray*) getMonthDaysArrayWithLanguage : (NSInteger) lang style : (NSInteger) style
{
    NSArray *monthArray;
    if (lang == CalendarLanguageEnglish) {
        if (style == DateTitleStyleThreeWordMonthYear || style == DateTitleStyleThreeWordYearMonth) {
            monthArray  = [NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
        }
        else if (style == DateTitleStyleAllWordMonthYear || style == DateTitleStyleAllWordYearMonth)
        {
           monthArray  = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
          
        }
        else if (style == DateTitleStyleDigitalMonthYear || style == DateTitleStyleDigitalYearMonth)
        {
            monthArray  = [NSArray arrayWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
        }
        else
        {
            monthArray  = nil;
        }
    }
    else if (lang == CalendarLanguageChinese)
    {
        if (style == DateTitleStyleThreeWordMonthYear || style == DateTitleStyleThreeWordYearMonth) {
            monthArray  = [NSArray arrayWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二", nil];
        }
        else if (style == DateTitleStyleAllWordMonthYear || style == DateTitleStyleAllWordYearMonth)
        {
            monthArray  = [NSArray arrayWithObjects:@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月", nil];
        }
        else if (style == DateTitleStyleDigitalMonthYear || style == DateTitleStyleDigitalYearMonth)
        {
            monthArray  = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
        }
        else
        {
            monthArray  = nil;
        }
        
    }
    else
    {
        monthArray = nil;
    }
    return monthArray;
}

@end
