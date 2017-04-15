//
//  CalendarView.m
//  CalendarTest
//
//  Created by 潘鸿吉 on 14-1-7.
//  Copyright (c) 2014年 潘鸿吉. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarUtils.h"

#define weekLabelTag (10)
#define dayButtonTag (100)

@implementation CalendarView
@synthesize dateTitleLabel;
@synthesize todayDate;
@synthesize currentDate;
@synthesize delegate;
@synthesize selectDate;
@synthesize selectDateArray;
@synthesize selectedDateColorArray;

@synthesize language;
@synthesize dateTitleStyle;
@synthesize weekTitleStyle;
@synthesize calendarStyle;

- (void)dealloc
{
    if (todayDate) {
        [todayDate release];
        todayDate = nil;
    }
    
    if (currentDate) {
        [currentDate release];
        currentDate = nil;
    }
    
    if (dateArray) {
        [dateArray release];
        dateArray = nil;
    }
    
    if (selectDate) {
        [selectDate release];
        selectDate = nil;
    }
    
    if (calendarStyle) {
        [calendarStyle release];
        calendarStyle = nil;
    }
    
    if (selectDateArray) {
        [selectDateArray release];
        selectDateArray = nil;
    }
    
    if (selectedDateColorArray) {
        [selectedDateColorArray release];
        selectedDateColorArray = nil;
    }
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        calendarStyle = [[CalendarStyle alloc] init];
        [calendarStyle setDelegate:self];
        
        language = CalendarLanguageEnglish;
        dateTitleStyle = DateTitleStyleAllWordMonthYear;
        weekTitleStyle = WeekTitleStyleOneWord;
        
        selfWidth = frame.size.width;
        selfHeight = frame.size.height;
        todayDate = [[CalendarUtils getTodayDate] copy];
        currentDate = [[CalendarUtils getFirstDayWithDate:todayDate] copy];
        dateArray = [[NSArray alloc] initWithArray:[CalendarUtils getDaysWithDate:currentDate]];

        [self initDateTitleView];
        
        [self initWeekTitleView];
        
        [self initDayView];

    }
    return self;
}

-(void)setSelectDate:(NSDate *)_selectDate
{
    if (selectDate) {
        [selectDate retain];
    }
    selectDate = [_selectDate retain];
    [self resetDayView];
}

#pragma mark - initView
#pragma mark 日期标题
- (void) initDateTitleView
{
    if (!dateTitleView) {
        
        dateTitleHeight = selfHeight/7.0f;
        dateTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selfWidth, dateTitleHeight)];
        [dateTitleView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:dateTitleView];
        [dateTitleView release];
        
        leftButton = [[UIButton alloc] initWithFrame:CGRectMake(dateTitleHeight/4, dateTitleHeight/4, dateTitleHeight/2, dateTitleHeight/2)];
        [leftButton setImage:[UIImage imageNamed:@"CalendarView_LeftButton.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [dateTitleView addSubview:leftButton];
        [leftButton release];
        
        rightButton = [[UIButton alloc] initWithFrame:CGRectMake(selfWidth - dateTitleHeight/2 - dateTitleHeight/4, dateTitleHeight/4, dateTitleHeight/2, dateTitleHeight/2)];
        [rightButton setImage:[UIImage imageNamed:@"CalendarView_RightButton.png"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [dateTitleView addSubview:rightButton];
        [rightButton release];
        
        dateTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((dateTitleHeight/4)*2 + dateTitleHeight/2, 0, selfWidth-((dateTitleHeight/4)*2 + dateTitleHeight/2)*2, dateTitleHeight)];
        [dateTitleLabel setBackgroundColor:[UIColor clearColor]];
        [dateTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [dateTitleLabel setFont:[UIFont systemFontOfSize:selfWidth*selfHeight/4800]];
        [dateTitleLabel setText:[CalendarUtils getYearAndMonth:todayDate style:dateTitleStyle language:language]];
        [dateTitleLabel setTextColor:[UIColor grayColor]];
        [dateTitleView addSubview:dateTitleLabel];
        [dateTitleLabel release];
    }
}

#pragma mark 周几标题
- (void) initWeekTitleView
{
    if (!weekTitleView) {
        weekTitleHeight = selfHeight/7.0f;
        weekTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, [CalendarUtils getNextHeight:dateTitleView], selfWidth, weekTitleHeight)];
        [weekTitleView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:weekTitleView];
        [weekTitleView release];
        
        NSArray *titleArray = [CalendarUtils getWeekDaysArrayWithWeekStyle:weekTitleStyle language:language];
        for (int i = 0; i < 7; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*selfWidth/7, 0, selfWidth/7,weekTitleHeight)];
            [label setTag:weekLabelTag+i];
            [label setText:[NSString stringWithFormat:@"%@",[titleArray objectAtIndex:i]]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor colorWithRed:93.0f/255.0f green:198/255.0f blue:245/255.0f alpha:1.0f]];
            [label setFont:[UIFont systemFontOfSize:selfWidth*selfHeight/7000]];
            [label setBackgroundColor:[UIColor clearColor]];
            [weekTitleView addSubview:label];
            [label release];
        }
    }
}

#pragma mark 具体
- (void) initDayView
{
    if (!dayView) {
        dayViewHeight = selfHeight-(selfHeight/7.0f)*2;
        dayView = [[UIView alloc] initWithFrame:CGRectMake(0, [CalendarUtils getNextHeight:weekTitleView], selfWidth, dayViewHeight)];
        [dayView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:dayView];
        [dayView release];
        
        
        for (int i = 0; i < 6; i++) {
            for (int j = 0; j < 7; j++) {
                int index = i * 7 + j;
                NSDate *date = [dateArray objectAtIndex:index];
                NSInteger month = [CalendarUtils getMonthForDate:date];
                NSInteger day = [CalendarUtils getDayForDate:date];
                NSInteger currentMonth = [CalendarUtils getMonthForDate:currentDate];
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(j * (selfWidth/7.0f), i * (dayViewHeight/6.0f), (selfWidth/7.0f), dayViewHeight/6.0f)];
                [button setTag:dayButtonTag+index];
                [button setTitle:[NSString stringWithFormat:@"%i" , day] forState:UIControlStateNormal];
//                [button.titleLabel setFont:calendarStyle.font];
                button.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:16];;
                [[button titleLabel] setTextAlignment:NSTextAlignmentCenter];
                [button addTarget:self action:@selector(dayViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                [dayView addSubview:button];
                [button release];
                
                if (month == currentMonth) {
                    [button setBackgroundColor:calendarStyle.thisMonthColor];
                    [button setTitleColor:calendarStyle.thisMonthTextColor forState:UIControlStateNormal];
                }
                else
                {
                    [button setBackgroundColor:calendarStyle.otherMonthColor];
                    [button setUserInteractionEnabled:NO];
                    [button setTitleColor:calendarStyle.otherMonthTextColor forState:UIControlStateNormal];
                }

                if ([date isEqualToDate:todayDate]) {
                    [button.layer setBorderColor:calendarStyle.todayColor.CGColor];
                    [button.layer setBorderWidth:2.0f];
                    [button setTitleColor:calendarStyle.todayTextColor forState:UIControlStateNormal];
                }
                else
                {
                    [button.layer setBorderWidth:0.5f];
                    [button.layer setBorderColor:calendarStyle.borderColor.CGColor];
                }
            }
        }
    }
}

- (void) resetDayView
{
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 7; j++) {
            int index = i * 7 + j;
            NSDate *date = [dateArray objectAtIndex:index];
            NSInteger month = [CalendarUtils getMonthForDate:date];
            NSInteger day = [CalendarUtils getDayForDate:date];
            NSInteger currentMonth = [CalendarUtils getMonthForDate:currentDate];
            
            UIButton *button = (UIButton*)[dayView viewWithTag:dayButtonTag+index];
            if (button) {
                [button setTitle:[NSString stringWithFormat:@"%i" , day] forState:UIControlStateNormal];
                [button.layer setBorderWidth:0.5f];
                [button.layer setBorderColor:calendarStyle.borderColor.CGColor];
                if (month == currentMonth) {
                    [button setBackgroundColor:calendarStyle.thisMonthColor];
                    [button setTitleColor:calendarStyle.thisMonthTextColor forState:UIControlStateNormal];
                    [button setUserInteractionEnabled:YES];
                }
                else
                {
                    [button setBackgroundColor:calendarStyle.otherMonthColor];
                    [button setTitleColor:calendarStyle.otherMonthTextColor forState:UIControlStateNormal];
                    [button setUserInteractionEnabled:NO];
                }
                
                
//                if (calendarStyle.style == CalendarDateSelectStyleBorder) {
//                    if (selectDateArray) {
//                        for (NSDate *tempDate in selectDateArray) {
//                            if ([tempDate isEqualToDate:date]) {
//                                [button.layer setBorderColor:calendarStyle.selectDateArrayColor.CGColor];
//                                [button.layer setBorderWidth:2.0f];
//                                [button setTitleColor:calendarStyle.selectDateArrayTextColor forState:UIControlStateNormal];
//                            }
//                        }
//                    }
                if (calendarStyle.style == CalendarDateSelectStyleBorder) {
                    if (selectDateArray) {
                        for (id object in selectDateArray) {
                            if ([object isKindOfClass:[NSArray class]]) {
                                for (int i = 0;i < selectDateArray.count;i++) {
                                    NSArray *array = [selectDateArray objectAtIndex:i];
                                    for (NSDate *tempDate in array) {
                                        if ([tempDate isEqualToDate:date]) {
                                            [button.layer setBorderColor:[[selectedDateColorArray objectAtIndex:i]CGColor]];
                                            [button.layer setBorderWidth:2.0f];
                                            [button setTitleColor:calendarStyle.selectDateArrayTextColor forState:UIControlStateNormal];
                                        }
                                    }
                                }

                            }else{
                                for (NSDate *tempDate in selectDateArray) {
                                    if ([tempDate isEqualToDate:date]) {
                                        [button.layer setBorderColor:calendarStyle.selectDateArrayColor.CGColor];
                                        [button.layer setBorderWidth:2.0f];
                                        [button setTitleColor:calendarStyle.selectDateArrayTextColor forState:UIControlStateNormal];
                                    }
                                }
                            }
                        }
                    }
                    
            
                    if ([date isEqualToDate:todayDate]) {
                        [button.layer setBorderColor:calendarStyle.todayColor.CGColor];
                        [button.layer setBorderWidth:2.0f];
                        [button setTitleColor:calendarStyle.todayTextColor forState:UIControlStateNormal];
                    }
                    else if ([date isEqualToDate:selectDate])
                    {
                        [button setUserInteractionEnabled:NO];
                        [button.layer setBorderWidth:2.0f];
                        [button.layer setBorderColor:calendarStyle.selectColor.CGColor];
                        [button setTitleColor:calendarStyle.selectTextColor forState:UIControlStateNormal];
                    }
                }
                else if(calendarStyle.style == CalendarDateSelectStyleFill)
                {
//                    if (selectDateArray) {
//                        for (NSDate *tempDate in selectDateArray) {
//                            if ([tempDate isEqualToDate:date]) {
//                                [button setBackgroundColor:calendarStyle.selectDateArrayColor];
//                                [button setTitleColor:calendarStyle.selectDateArrayTextColor forState:UIControlStateNormal];
//                            }
//                        }
//                    }
                    if (selectDateArray) {
                        for (id object in selectDateArray) {
                            if ([object isKindOfClass:[NSArray class]]) {
                                for (int i = 0;i < selectDateArray.count;i++) {
                                    NSArray *array = [selectDateArray objectAtIndex:i];
                                    for (NSDate *tempDate in array) {
                                        if ([tempDate isEqualToDate:date]) {
                                            [button setBackgroundColor:[selectedDateColorArray objectAtIndex:i]];
                                            [button setTitleColor:calendarStyle.selectDateArrayTextColor forState:UIControlStateNormal];
                                        }
                                    }
                                }
                            }else{
                                for (NSDate *tempDate in selectDateArray) {
                                    if ([tempDate isEqualToDate:date]) {
                                        [button setBackgroundColor:calendarStyle.selectDateArrayColor];
                                        [button setTitleColor:calendarStyle.selectDateArrayTextColor forState:UIControlStateNormal];
                                    }
                                }
                            }
                        }
                    }

                    
                    if ([date isEqualToDate:todayDate]) {
                        [button setBackgroundColor:calendarStyle.todayColor];
                        [button setTitleColor:calendarStyle.todayTextColor forState:UIControlStateNormal];
                    }
                    else if ([date isEqualToDate:selectDate])
                    {
                        [button setUserInteractionEnabled:NO];
                        [button setBackgroundColor:calendarStyle.selectColor];
                        [button setTitleColor:calendarStyle.selectTextColor forState:UIControlStateNormal];
                    }
                }
            }
        }
    }
}

#pragma mark - CalendarStyleDelegate
-(void)calendarStyleVauleChange
{
    [self resetDayView];
}

#pragma mark - button action
#pragma mark 左按钮
- (void) leftButtonAction
{
    NSLog(@"%@",currentDate);
    callBack(currentDate,@"left");
    
    NSDate *lastDate = [CalendarUtils getLastDate:currentDate];
    if (currentDate) {
        [currentDate release];
        currentDate = nil;
    }
    currentDate = [lastDate retain];
    
    if (dateArray) {
        [dateArray release];
        dateArray = nil;
    }
    dateArray = [[NSArray alloc] initWithArray:[CalendarUtils getDaysWithDate:currentDate]];
    
    [dateTitleLabel setText:[CalendarUtils getYearAndMonth:currentDate style:dateTitleStyle language:language]];
    
    NSLog(@"currentDate : %@" , currentDate);
    
    [self resetDayView];
}

-(void)refleshriCheng:(block)db
{
   callBack=[db copy];
}

#pragma mark 右按钮
- (void) rightButtonAction
{
    callBack(currentDate,@"right");
    NSDate *nextDate = [CalendarUtils getNextDate:currentDate];
    if (currentDate) {
        [currentDate release];
        currentDate = nil;
    }
    currentDate = [nextDate retain];
    
    if (dateArray) {
        [dateArray release];
        dateArray = nil;
    }
    dateArray = [[NSArray alloc] initWithArray:[CalendarUtils getDaysWithDate:currentDate]];
    
    [dateTitleLabel setText:[CalendarUtils getYearAndMonth:currentDate style:dateTitleStyle language:language]];
    
    NSLog(@"currentDate : %@" , currentDate);
    
    [self resetDayView];
}

#pragma mark 日期点击事件
- (void) dayViewButtonAction : (id) sender
{
//    NSLog(@"tag : %d" , [sender tag]);
    UIButton *button = (UIButton*)sender;
    
    NSInteger index = button.tag - dayButtonTag;
    NSDate *date = [dateArray objectAtIndex:index];

    if (selectDate) {
        [selectDate release];
        selectDate = nil;
    }
    selectDate = [date copy];
    
    [self resetDayView];
    
    
    if (delegate && [delegate respondsToSelector:@selector(calendarViewDidSelectDate:todayDate:)]) {
        [delegate calendarViewDidSelectDate:date todayDate:todayDate];
    }
}

#pragma mark - 属性设置
#pragma mark 设置日期标题格式
-(void)setDateTitleStyle:(DateTitleStyle)_dateTitleStyle
{
    if (dateTitleStyle != _dateTitleStyle) {
        dateTitleStyle = _dateTitleStyle;
        [dateTitleLabel setText:[CalendarUtils getYearAndMonth:currentDate style:dateTitleStyle language:language]];
    }
}

#pragma mark 设置语言版本
- (void) setCalendarLanguage : (CalendarLanguage) lang
{
    language = lang;
    [dateTitleLabel setText:[CalendarUtils getYearAndMonth:currentDate style:dateTitleStyle language:language]];
    
    NSArray *titleArray = [CalendarUtils getWeekDaysArrayWithWeekStyle:weekTitleStyle language:language];
    for (int i = 0; i < 7; i++) {
        UILabel *label = (UILabel*)[weekTitleView viewWithTag:i+weekLabelTag];
        if (label) {
            [label setText:[NSString stringWithFormat:@"%@",[titleArray objectAtIndex:i]]];
        }
    }
}

#pragma mark 设置日期标题背景色
- (void) setDateTitleBackgroundColor:(UIColor *)color
{
    if (dateTitleView && color) {
        [dateTitleView setBackgroundColor:color];
    }
}

#pragma mark 设置日记标题左右按钮偏移量
- (void) setDateTitleButtonOffset : (CGPoint) point
{
    if (leftButton) {
        [leftButton setFrame:CGRectMake(dateTitleHeight/4+point.x, dateTitleHeight/4+point.y, dateTitleHeight/2, dateTitleHeight/2)];
    }
    if (rightButton) {
        [rightButton setFrame:CGRectMake(selfWidth - dateTitleHeight/2 - dateTitleHeight/4-point.x, dateTitleHeight/4+point.y, dateTitleHeight/2, dateTitleHeight/2)];
    }
}

#pragma mark 设置周标题格式
- (void) setWeekTitleStyle : (WeekTitleStyle) style
{
    weekTitleStyle = style;
    NSArray *titleArray = [CalendarUtils getWeekDaysArrayWithWeekStyle:weekTitleStyle language:language];
    for (int i = 0; i < 7; i++) {
        UILabel *label = (UILabel*)[weekTitleView viewWithTag:i+weekLabelTag];
        if (label) {
            [label setText:[NSString stringWithFormat:@"%@",[titleArray objectAtIndex:i]]];
        }
    }
}

#pragma mark 设置周标题文字大小
- (void) setWeekTitleTextSize : (float) size
{
    for (int i = 0; i < 7; i++) {
        UILabel *label = (UILabel*)[weekTitleView viewWithTag:i+weekLabelTag];
        if (label) {
            [label setFont:[UIFont systemFontOfSize:size]];
        }
    }
}

#pragma mark 设置周标题文字颜色
- (void) setWeekTitleTextColor : (UIColor*) color
{
    if (color) {
        for (int i = 0; i < 7; i++) {
            UILabel *label = (UILabel*)[weekTitleView viewWithTag:i+weekLabelTag];
            if (label) {
                [label setTextColor:color];
            }
        }
    }
}

#pragma mark 设置周标题文字字体
- (void) setWeekTitleTextFont : (UIFont*) font
{
    if (font) {
        for (int i = 0; i < 7; i++) {
            UILabel *label = (UILabel*)[weekTitleView viewWithTag:i+weekLabelTag];
            if (label) {
                [label setFont:font];
            }
        }
    }
}

#pragma mark 设置日期数组
-(void)setSelectDateArray:(NSArray *)_selectDateArray
{
    if (_selectDateArray) {
        if (selectDateArray) {
            [selectDateArray release];
            selectDateArray = nil;
        }
        
        selectDateArray = [[NSArray alloc] initWithArray:_selectDateArray];
        
        [self resetDayView];
        
    }
}

#pragma mark 设置选中日期颜色数组
- (void)setSelectedDateColorArray:(NSMutableArray *)_selectedDateColorArray
{
    if (_selectedDateColorArray) {
        if (selectedDateColorArray) {
            [selectedDateColorArray release];
            selectedDateColorArray = nil;
        }
        
        selectedDateColorArray = [[NSMutableArray alloc] initWithArray:_selectedDateColorArray];
        
        [self resetDayView];
        
    }

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
