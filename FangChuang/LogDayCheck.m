//
//  LogDayCheck.m
//  FangChuang
//
//  Created by omni on 14-4-14.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "LogDayCheck.h"

@implementation LogDayCheck

+ (NSUInteger)NumberOfDaysElapsedBetweenILastLogDate
{
    NSDate *lastLogDay = [[NSUserDefaults standardUserDefaults] valueForKey:@"LogDate"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateStyle:NSDateFormatterFullStyle];//直接输出的话是机器码
    
   // NSString *string = [formatter stringFromDate:lastLogDay];

    //NSLog(@"lastLogDay = %@",string);
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentCalendar components:NSCalendarUnitDay
                                                      fromDate:lastLogDay
                                                        toDate:[NSDate date]
                                                       options:0];
    return [components day];
}
@end
