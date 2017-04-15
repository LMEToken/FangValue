//
//  RiChengBiaoViewController.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//日程表
#import "RiChengBiaoViewController.h"
#import "ChaKanNeiRongViewController.h"
#import "EditTimeViewController.h"
#import "AddTimeViewController.h"

#import "FangChuangInsiderViewController.h"
#import "xiangmuViewController.h"

@interface RiChengBiaoViewController ()
@property(nonatomic,retain)NSDictionary *dic;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,copy)NSString *monthsStr;
@property(nonatomic,copy)NSString *stardDate;
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *finishTime;

@end

@implementation RiChengBiaoViewController

@synthesize proid=_proid;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadData
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [dateFormatter stringFromDate:[NSDate date]];
    NSString *str2 = [str substringWithRange:NSMakeRange(5, 2)];

    NSString *start = @"";
    NSString *end = @"";
    switch ([str2 intValue]) {
        case 1:
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"31"];
            break;

        case 2:            break;

            
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"28"];
            
            break;
        case 3:
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"31"];
            break;

        case 4:
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"30"];
            break;

        case 5:
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"31"];
            break;

        case 6:
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"30"];
            break;

        case 7:
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"31"];
            break;

        case 8:
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"31"];
            break;

        case 9:
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"30"];
            break;

        case 10:
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"31"];
            break;

        case 11:
            
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"30"];
            break;
        case 12:
            start = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
            end = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"31"];
            
            break;

        default:
            break;
    }
    if(self.finishTime==nil)
    {
        self.finishTime=end;
    }
    if (self.startTime==nil) {
        self.startTime=start;

    }
    
    NSLog(@"---startDate--%@",self.startTime);
    NSLog(@"----endDate--%@",self.finishTime);
    
    [[NetManager sharedManager]getScheduleListWithUsername:[[UserInfo sharedManager]username] startdate:self.startTime enddate:self.finishTime hudDic:Nil success:^(id responseDic) {
        NSLog(@"%@",responseDic);
        if (responseDic && [responseDic isKindOfClass:[NSDictionary class]]) {
            self.dic = [NSDictionary dictionaryWithDictionary:responseDic];
            NSLog(@"-----self.dic---%@",self.dic);
            //第一次的dic
           /* -----self.dic---{
                data =     (
                );
                msg = ok;
                status = 0;
            }
            */
            [self refreshCalendar];

        }

    } fail:^(id errorString) {
        
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if(calendarView)
//        [calendarView removeFromSuperview];
//    calendarView = [[CalendarView alloc]initWithFrame:CGRectMake(10, self.contentViewHeight - 200 - 320 + 20, 300, 300)];
//    [calendarView refleshriCheng:^(NSDate *date) {
//        
//    }];
//    calendarView.delegate=self;
    //[calendarView.calendarStyle setStyle:CalendarDateSelectStyleFill];
    
   
    
   [self loadData];
   [self initWithContentView];
   
    
    


}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self setTabBarHidden:YES];
    [self.titleLabel setText:@"日程表"];
    [self addBackButton];
    
    //添加右边的按钮
    UIButton* rtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rtBtn setBackgroundImage:[UIImage imageNamed:@"44_anniu_1"] forState:UIControlStateNormal];
  //  [rtBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rtBtn isAutoFrame:YES];
    
    
    //增大按钮触摸范围
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(250, -5, 70, 50);
    btn.backgroundColor=[UIColor clearColor];
    [btn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:btn];
    
    
    
    //初始化日历
     [self initWithContentView];
   
    
    //UITableView 背景
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.contentViewHeight - 200 + 10, 320, 190) style:UITableViewStylePlain];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.contentView addSubview:self.tableView];
    
}
#pragma -mark -functions
-(void)initWithContentView
{
    if(calendarView)
        [calendarView removeFromSuperview];
    calendarView = [[CalendarView alloc]initWithFrame:CGRectMake(10, self.contentViewHeight - 200 - 320 + 20, 300, 300)];
    [calendarView refleshriCheng:^(NSDate *date,NSString *str) {
        if([str isEqualToString:@"left"]){
            self.finishTime=[[CalendarUtils dateToString:date] substringWithRange:NSMakeRange(0, 10)];
            self.startTime=[[CalendarUtils dateToString:[CalendarUtils getLastDate:date]]substringWithRange:NSMakeRange(0, 10)];
            [self loadData];
            //2014.08.28 cehnlihua 点击日历上的左按钮的时候，会把底下的tableView清0.
            [self.dataArray removeAllObjects];
            [self.tableView reloadData];
        }
        
        else if([str isEqualToString:@"right"]){
            self.finishTime=[[CalendarUtils dateToString:[CalendarUtils getNextDate:[CalendarUtils getNextDate:date]]]substringWithRange:NSMakeRange(0, 10)];
            self.startTime=[[CalendarUtils dateToString:[CalendarUtils getNextDate:date]]substringWithRange:NSMakeRange(0, 10)];
            [self loadData];
            //2014.08.28 cehnlihua 点击日历上的右按钮的时候，会把底下的tableView清0.
            [self.dataArray removeAllObjects];
            [self.tableView reloadData];
           
        }
        //负责把有日程的日历上面显示颜色
        [self loadData];
      //  [self initWithContentView];
        
    }];
    calendarView.delegate=self;
//    //[calendarView.calendarStyle setStyle:CalendarDateSelectStyleFill];
//    
//    NSDate *newDate = [self getUsefulDate:[NSDate date]];
//    // NSMutableArray *dateArray = [[NSMutableArray alloc]init];
//    NSMutableArray *array1=[[NSMutableArray alloc]init];
//    NSMutableArray *array2=[[NSMutableArray alloc]init];
//    NSMutableArray *array3=[[NSMutableArray alloc]init];
//    NSMutableArray *array4=[[NSMutableArray alloc]init];
//    NSMutableArray *array5=[[NSMutableArray alloc]init];
//    
//    NSDateFormatter *formatter=[[[NSDateFormatter alloc]init]autorelease];
//    formatter.locale=[NSLocale systemLocale];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    for(NSDictionary *dic in array)
//    {
//        switch ([[dic objectForKey:@"pri"] intValue]) {
//            case 1:
//                [array1 addObject:[newDate dateByAddingTimeInterval:60*60*24*((int )[ [formatter dateFromString:[dic objectForKey:@"sdate"] ] timeIntervalSinceNow]/60/24/60)]];
//                break;
//            case 2:
//                [array2 addObject:[newDate dateByAddingTimeInterval:60*60*24*((int )[ [formatter dateFromString:[dic objectForKey:@"sdate"] ] timeIntervalSinceNow]/60/24/60)]];
//                break;
//            case 3:
//                [array3 addObject:[newDate dateByAddingTimeInterval:60*60*24*((int )[ [formatter dateFromString:[dic objectForKey:@"sdate"] ] timeIntervalSinceNow]/60/24/60)]];
//                break;
//            case 4:
//                [array4 addObject:[newDate dateByAddingTimeInterval:60*60*24*((int )[ [formatter dateFromString:[dic objectForKey:@"sdate"] ] timeIntervalSinceNow]/60/24/60)]];
//                break;
//            case 5:
//                [array5 addObject:[newDate dateByAddingTimeInterval:60*60*24*((int )[ [formatter dateFromString:[dic objectForKey:@"sdate"] ] timeIntervalSinceNow]/60/24/60)]];
//                break;
// 
//            default:
//                break;
//        }
//
//    
//    }
//   
//    NSMutableArray *dateArray = [[NSMutableArray alloc]initWithObjects:array1,array2,array3,array4,array5,nil];
//    [array1 release];
//    [array2 release];
//    [array3 release];
//    [array4 release];
//    [array5 release];
//    [calendarView setSelectedDateColorArray:[NSMutableArray arrayWithObjects:[UIColor orangeColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor cyanColor],[UIColor magentaColor], nil]];
//    
//    [calendarView setSelectDateArray:dateArray];
//    
//    [dateArray release];
    [self.contentView addSubview:calendarView];
}
-(void)refreshCalendar
{
    NSArray* tmpArray = [self.dic objectForKey:@"data"];
    if (tmpArray.count == 0) {
        return;
    }else{
        NSArray *array=[NSArray arrayWithArray:[self.dic objectForKey:@"data"]];
        
        //[calendarView.calendarStyle setStyle:CalendarDateSelectStyleFill];
        
       // NSMutableArray *dateArray = [[NSMutableArray alloc]init];
        NSMutableArray *array1=[[NSMutableArray alloc]init];
        NSMutableArray *array2=[[NSMutableArray alloc]init];
        NSMutableArray *array3=[[NSMutableArray alloc]init];
        NSMutableArray *array4=[[NSMutableArray alloc]init];
        NSMutableArray *array5=[[NSMutableArray alloc]init];
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.locale=[NSLocale systemLocale];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *newDate =[formatter dateFromString:[[formatter stringFromDate:[NSDate date]] substringWithRange:NSMakeRange(0, 10)]];
        
        for(NSDictionary *dic in array)
        {
            switch ([[dic objectForKey:@"pri"] intValue]) {
                case 1:
                    [array1 addObject:[newDate dateByAddingTimeInterval:60*60*24*((int )[ [formatter dateFromString:[dic objectForKey:@"sdate"] ] timeIntervalSinceDate:newDate]/60/24/60)]];
                    NSLog(@"newdate:%@  interval:%d",newDate,60*60*24*((int )[ [formatter dateFromString:[dic objectForKey:@"sdate"] ] timeIntervalSinceDate:newDate]/60/24/60));
                    break;
                case 2:
                    [array2 addObject:[newDate dateByAddingTimeInterval:60*60*24*((int )[ [formatter dateFromString:[dic objectForKey:@"sdate"] ] timeIntervalSinceNow]/60/24/60)]];
                    break;
                case 3:
                    [array3 addObject:[newDate dateByAddingTimeInterval:60*60*24*((int )[ [formatter dateFromString:[dic objectForKey:@"sdate"] ] timeIntervalSinceNow]/60/24/60)]];
                    break;
                case 4:
                    [array4 addObject:[newDate dateByAddingTimeInterval:60*60*24*((int )[ [formatter dateFromString:[dic objectForKey:@"sdate"] ] timeIntervalSinceNow]/60/24/60)]];
                    break;
                case 5:
                    [array5 addObject:[newDate dateByAddingTimeInterval:60*60*24*((int )[ [formatter dateFromString:[dic objectForKey:@"sdate"] ] timeIntervalSinceNow]/60/24/60)]];
                    break;
                    
                default:
                    break;
            }
            
            
        }
        
        NSMutableArray *dateArray = [[NSMutableArray alloc]initWithObjects:array1,array2,array3,array4,array5,nil];
        
        [calendarView setSelectedDateColorArray:[NSMutableArray arrayWithObjects:[UIColor orangeColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor cyanColor],[UIColor magentaColor], nil]];
        
        [calendarView setSelectDateArray:dateArray];

    }
}
- (NSDate*)getUsefulDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSLog(@"----dateStr=%@",dateStr);
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate = [dateFormatter dateFromString:dateStr];
    return newDate;
}
#pragma -mark -UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//2014.07.15 chenlihua 当点击的日期里面有日程时
- (void) calendarViewDidSelectDate:(NSDate *)date todayDate:(NSDate *)todayDate
{

    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.locale=[NSLocale systemLocale];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr = [formatter stringFromDate:date];
    NSLog(@"---timestr--%@",timeStr);
    self.stardDate=timeStr;
    [self.dataArray removeAllObjects];
    
    NSLog(@"----data--%@",[self.dic objectForKey:@"data"]);
    
    for(NSDictionary *dic1 in [self.dic objectForKey:@"data"])
    {
      if([[dic1 objectForKey:@"sdate"]isEqualToString:timeStr])
      {
          [self.dataArray addObject:dic1];
          NSLog(@"---1111-dataArray--%@",self.dataArray);
      }
    
    }
    NSLog(@"---1111-dataArray-rg-%@",self.dataArray);
    [self.tableView reloadData];
}
//2014.09.10 chenlihua 日程表中所有编辑好的事件时间和名称都是一样的
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"===cell--self.dataArray---%@",self.dataArray);
    
    
    NSString *cellString=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        
        //时间的图标
        UIImageView *timeIamgeView=[[UIImageView alloc]initWithFrame:CGRectMake(10, (50-21)/2., 35/2., 42/2.)];
        [timeIamgeView setImage:[UIImage imageNamed:@"25_tubia_1"]];
        [cell.contentView addSubview:timeIamgeView];

        //时间
        UILabel *timeLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeIamgeView.frame)+10, 12.5, 50, 25)];
        [timeLab setBackgroundColor:[UIColor clearColor]];
        [timeLab setTextColor:[UIColor grayColor]];
        [timeLab setFont:[UIFont systemFontOfSize:14]];
        if([self.dataArray count]>0)
        {
            NSString *timeStr=[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"stime"];
            NSLog(@"---stime-1111-%@",timeStr);
            [timeLab setText:[NSString stringWithFormat:@"%@:%@",[timeStr substringWithRange:NSMakeRange(0, 2)],[timeStr substringWithRange:NSMakeRange(2,[timeStr length]-2)]]];
        }
        NSString *timeStr=[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"stime"];
        NSLog(@"---stime-1111-%@",timeStr);
        [cell.contentView addSubview:timeLab];

        //名称图标
        UILabel *shijianLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLab.frame)+5, 12.5, 150, 25)];
        [shijianLab setBackgroundColor:[UIColor clearColor]];
        [shijianLab setTextColor:[UIColor orangeColor]];
        [shijianLab setFont:[UIFont systemFontOfSize:14]];
        if([self.dataArray count]>0)
        {
            [shijianLab setText:[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"sname"]];
            NSLog(@"---111111 sname--%@",[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"sname"]);

        }
        NSLog(@"---111111 sname--%@",[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"sname"]);
       [cell.contentView addSubview:shijianLab];

    }
    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"===cell--self.dataArray---%@",self.dataArray);
    
    
    NSString *cellString=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    
    //时间的图标
    UIImageView *timeIamgeView=[[UIImageView alloc]initWithFrame:CGRectMake(10, (50-21)/2., 35/2., 42/2.)];
    [timeIamgeView setImage:[UIImage imageNamed:@"25_tubia_1"]];
    [cell.contentView addSubview:timeIamgeView];
    
    //时间
    UILabel *timeLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeIamgeView.frame)+10, 12.5, 50, 25)];
    [timeLab setBackgroundColor:[UIColor clearColor]];
    [timeLab setTextColor:[UIColor grayColor]];
    [timeLab setFont:[UIFont systemFontOfSize:14]];
    if([self.dataArray count]>0)
    {
        NSString *timeStr=[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"stime"];
        NSLog(@"---stime-1111-%@",timeStr);
        [timeLab setText:[NSString stringWithFormat:@"%@:%@",[timeStr substringWithRange:NSMakeRange(0, 2)],[timeStr substringWithRange:NSMakeRange(2,[timeStr length]-2)]]];
    }
    NSString *timeStr=[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"stime"];
    NSLog(@"---stime-1111-%@",timeStr);
    [cell.contentView addSubview:timeLab];
    
    
    //名称图标
    UILabel *shijianLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLab.frame)+5, 12.5, 150, 25)];
    [shijianLab setBackgroundColor:[UIColor clearColor]];
    [shijianLab setTextColor:[UIColor orangeColor]];
    [shijianLab setFont:[UIFont systemFontOfSize:14]];
    if([self.dataArray count]>0)
    {
        [shijianLab setText:[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"sname"]];
        NSLog(@"---111111 sname--%@",[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"sname"]);
        
    }
    NSLog(@"---111111 sname--%@",[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"sname"]);
    [cell.contentView addSubview:shijianLab];
    
    
    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditTimeViewController *view=[[EditTimeViewController alloc]init];
    view.dic=[self.dataArray objectAtIndex:indexPath.row ];
    view.proid=self.proid;
    [self.navigationController pushViewController: view animated:YES];

}
#pragma  -mark -doClickButton
//点击进行编辑页面
- (void)rightButton:(UIButton*)button
{
    printf(__FUNCTION__);
    
    AddTimeViewController*view=[[AddTimeViewController alloc]init];
    view.proid=self.proid;
    view.editeType=1;
    if(!self.stardDate)
    {
        self.stardDate=[self getNowDate];
    }
    view.starDate=self.stardDate;
    [self.navigationController pushViewController: view animated:YES];
    
}
- (NSString*)getNowDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    return dateStr;
}
//2014.09.04 chenlihua 添加返回按钮
- (void) backButtonAction : (id) sender
{
    NSLog(@"---------返回按钮---parent-------------");
   [self.navigationController popViewControllerAnimated:NO];
    NSLog(@"--self.falg--%@----",self.flag);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
