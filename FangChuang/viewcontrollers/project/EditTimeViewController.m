//
//  EditTimeViewController.m
//  FangChuang
//
//  Created by 顾 思谨 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//日程表里，事件详情
#import "EditTimeViewController.h"
#import "AddTimeViewController.h"
#import "RiChengBiaoViewController.h"

@interface EditTimeViewController ()

@end
@implementation EditTimeViewController
@synthesize dic=_dic,proid=_proid;
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
    
    if ([self.view window] == nil)// 是否是正在使用的视图
        
    {
        self.view = nil;
    }
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:20]];
    self.titleLabel.text= @"事件详情";
    self.titleLabel.font=[UIFont fontWithName:KUIFont size:20];
    [self setTabBarHidden:YES];
    [self addBackButton];
    
    //右侧编辑按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
     [rightButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.font=[UIFont fontWithName:KUIFont size:17];
  //  [self addRightButton:rightButton isAutoFrame:NO];
    
    //初始化事件详情界面
    [self initContentView];
}
#pragma -mark -functions
- (void)initContentView
{
    //背景色
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:bgView];

    //事件和参与人的背景框
    UIImage *bg1 = [UIImage imageNamed:@"028_wenzikuang_1.png"];
    UIImageView *bgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, bg1.size.height/2)];
    [bgView1 setImage:bg1];
    [bgView addSubview:bgView1];

    //事件内容的背景图片
    UIImage *kuang = [UIImage imageNamed:@"27_shurukuang_2.png"];
    UIImageView *kuangView = [[UIImageView alloc]initWithFrame:CGRectMake(138, CGRectGetMinY(bgView.frame)+10, 172, kuang.size.height/2)];
    [kuangView setImage:kuang];
   [bgView addSubview:kuangView];

    //事件：Label
    UILabel *eventLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(kuangView.frame), 100, CGRectGetHeight(kuangView.frame))];
    [eventLabel setFont:[UIFont fontWithName:KUIFont size:15]];
    [eventLabel setText:@"事 件:"];
    [eventLabel setTextColor:[UIColor orangeColor]];
    [eventLabel setBackgroundColor:[UIColor clearColor]];
    eventLabel.font=[UIFont fontWithName:KUIFont size:17];
    [bgView addSubview:eventLabel];

    //事件内容Label
    UILabel *addLabel = [[UILabel alloc]initWithFrame:kuangView.frame];
    [addLabel setText:[self.dic objectForKey:@"sname"]];
    [addLabel setTextColor:[UIColor lightGrayColor]];
    [addLabel setFont:[UIFont fontWithName:KUIFont size:15]];
    [addLabel setBackgroundColor:[UIColor clearColor]];
    [addLabel setTextAlignment:NSTextAlignmentCenter];
    
     addLabel.font=[UIFont fontWithName:KUIFont size:17];
    [bgView addSubview:addLabel];

    //参成人背景框
    UIImage *personKuang = [UIImage imageNamed:@"27_shurukuang_2.png"];
    //参与人Label
    UILabel *personLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(kuangView.frame)+20, 100, personKuang.size.height/2)];
    [personLabel setFont:[UIFont fontWithName:KUIFont size:15]];
    [personLabel setText:@"参与人:"];
    [personLabel setTextColor:[UIColor orangeColor]];
    [personLabel setBackgroundColor:[UIColor clearColor]];
     personLabel.font=[UIFont fontWithName:KUIFont size:17];
    [bgView addSubview:personLabel];

    //参与人内容背景框
    UIImage *kuang2 = [UIImage imageNamed:@"27_shurukuang_2.png"];
    UIImageView *kuangView2 = [[UIImageView alloc]initWithFrame:CGRectMake(310-kuang2.size.width/2, personLabel.frame.origin.y, kuang2.size.width/2, kuang2.size.height/2)];
    [kuangView2 setImage:kuang2];
    [bgView addSubview:kuangView2];

    
    //参与人内容Label
    UILabel *addPersonLabel1 = [[UILabel alloc]initWithFrame:kuangView2.frame];
    [addPersonLabel1 setText:[self.dic objectForKey:@"createby"]];
    [addPersonLabel1 setTextColor:[UIColor lightGrayColor]];
    [addPersonLabel1 setFont:[UIFont fontWithName:KUIFont size:15]];
    [addPersonLabel1 setBackgroundColor:[UIColor clearColor]];
    [addPersonLabel1 setTextAlignment:NSTextAlignmentCenter];
     addPersonLabel1.font=[UIFont fontWithName:KUIFont size:17];
    [bgView addSubview:addPersonLabel1];


    UIImageView *bgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView1.frame)+10, 320, bg1.size.height/2-20)];
    [bgView2 setImage:bg1];
    [bgView addSubview:bgView2];
    
    //开始：Label
    UILabel *beginLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(bgView2.frame), 60, 80/2)];
    [beginLabel setText:@"开始"];
    [beginLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [beginLabel setTextColor:[UIColor orangeColor]];
    [beginLabel setBackgroundColor:[UIColor clearColor]];
     beginLabel.font=[UIFont fontWithName:KUIFont size:17];
    [bgView addSubview:beginLabel];

    //结束Label
    UILabel *endLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(beginLabel.frame), 60, 80/2)];
    [endLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [endLabel setText:@"结束"];
    [endLabel setTextColor:[UIColor orangeColor]];
    [endLabel setBackgroundColor:[UIColor clearColor]];
     endLabel.font=[UIFont fontWithName:KUIFont size:17];
    [bgView addSubview:endLabel];

    NSLog(@"----self.dic--%@",self.dic);
    
    //开始内容Label
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(beginLabel.frame)+50, CGRectGetMinY(bgView2.frame), 190, 80/2)];
    [startLabel setBackgroundColor:[UIColor clearColor]];
    
    if(self.dic){
        NSString *timeStr=[self.dic objectForKey:@"stime"];
      //  [startLabel setText:timeStr];
        [startLabel setText:[NSString stringWithFormat:@"%@ %@:%@",[self.dic objectForKey:@"sdate"],[timeStr substringWithRange:NSMakeRange(0, 2)],[timeStr substringWithRange:NSMakeRange(2,[timeStr length]-2)]]];
    
    }
    else{
    
       [startLabel setText:self.starDate];
    
    }
    
    [startLabel setTextColor:[UIColor lightGrayColor]];
    [startLabel setTextAlignment:NSTextAlignmentRight];
    [startLabel setUserInteractionEnabled:YES];
     startLabel.font=[UIFont fontWithName:KUIFont size:17];
    [bgView addSubview:startLabel];

    
    //结束内容Label
    finishLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(beginLabel.frame)+50, CGRectGetMaxY(startLabel.frame), 190, 80/2)];
    [finishLabel setBackgroundColor:[UIColor clearColor]];
    if(self.dic){
    NSString *timeStr1=[self.dic objectForKey:@"etime"];
      //  [finishLabel setText:timeStr1];
     [finishLabel setText:[NSString stringWithFormat:@"%@ %@:%@",[self.dic objectForKey:@"sdate"],[timeStr1 substringWithRange:NSMakeRange(0, 2)],[timeStr1 substringWithRange:NSMakeRange(2,[timeStr1 length]-2)]]];
    }
    else{
    
        [finishLabel setText:self.starDate];
    }
    [finishLabel setTextColor:[UIColor lightGrayColor]];
    [finishLabel setTextAlignment:NSTextAlignmentRight];
    [finishLabel setUserInteractionEnabled:YES];
     finishLabel.font=[UIFont fontWithName:KUIFont size:17];
    [bgView addSubview:finishLabel];

    
//    timeTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTime:)];
//    [startLabel addGestureRecognizer:timeTap1];
//    [timeTap1 release];
//    
//    timeTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTime:)];
//    [finishLabel addGestureRecognizer:timeTap2];
//    [timeTap2 release];
    
    UIImageView *bgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView2.frame)+10, 320, 40)];
    [bgView3 setImage:bg1];
    [bgView3 setUserInteractionEnabled:YES];
    [bgView addSubview:bgView3];

    //提醒Label
    UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(bgView3.frame), 50, 40)];
    [remindLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [remindLabel setText:@"提醒"];
    [remindLabel setTextColor:[UIColor orangeColor]];
    [remindLabel setBackgroundColor:[UIColor clearColor]];
     remindLabel.font=[UIFont fontWithName:KUIFont size:17];
    [bgView addSubview:remindLabel];

    //提醒内容Label
    UILabel *remindTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, CGRectGetMinY(bgView3.frame), 100, 40)];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"无",@"0",@"5分钟前",@"1",@"15分钟前",@"2",@"30分钟前",@"3",@" 1小时前",@"4",@"2小时前",@"5",@"一天前",@"6",@"两天前",@"7", nil];
    [remindTimeLabel setText:[dic objectForKey:[self.dic objectForKey:@"alertmode"]]];
    

//    [remindTimeLabel setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"RemindTime"]];
    [remindTimeLabel setTextColor:[UIColor lightGrayColor]];
    [remindTimeLabel setBackgroundColor:[UIColor clearColor]];
    remindLabel.font=[UIFont fontWithName:KUIFont size:17];
    [bgView addSubview:remindTimeLabel];

    
    //提醒右侧箭头
    UIImage *arrow = [UIImage imageNamed:@"27_jiantou_1.png"];
    UIImageView *arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(300-arrow.size.width/2, CGRectGetMinY(bgView3.frame)+12, arrow.size.width/2, arrow.size.height/2)];
    [arrowView setImage:arrow];
   // [bgView addSubview:arrowView];

    //删除事件button
    UIImage *buttonImage = [UIImage imageNamed:@"028_anniu_1.png"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [button setFrame:CGRectMake(40, 300, 240, buttonImage.size.height/2)];
    [button setTitle:@"删除事件" forState:UIControlStateNormal];
    button.titleLabel.text = @"删除事件";
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
   // [bgView addSubview:button];
    
//    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.contentViewHeight+216, 0, 0)];
//    //datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*365*10];
//    //datePicker.maximumDate = [NSDate date];
//    //datePicker.date = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
//    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
//    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
//    [self.contentView addSubview:datePicker];
//    [datePicker release];
}
#pragma -mark -doClickAction
//编辑事件
- (void)done:(UIButton*)sender
{
    AddTimeViewController *view=[[AddTimeViewController alloc]init];
    view.myDic=self.dic;
    view.proid=self.proid;
    view.editeType=0;
    [self.navigationController pushViewController:view animated:YES];

    NSLog(@"=====");
}
//删除事件
- (void)delete:(id)sender
{
    NSLog(@"delete");
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"删除成功",@"success", nil];
    
  [[NetManager sharedManager]scheduledelWithUsername:[self.dic objectForKey:@"createby"]
                                 andWithScheduleid:[self.dic objectForKey:@"id"]
                                            hudDic:dic success:^(id responseDic) {
                                                
                                                NSLog(@"--responseDic--%@",responseDic);
                                                NSLog(@"删除成功");
                                                
                                                
                                                //2014.09.04 chenlihua 弹出一个提醒
                                                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"事件删除成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                                [alert show];
                                                
                                                
                                                //2014.08.30 chenlihua 删除后，跳转回tableView没有刷新，事件还在。
                                              
                                               
                                                 RiChengBiaoViewController *riCheng=[[RiChengBiaoViewController alloc]init];
                                                
                                                riCheng.flag=@"delete";
                                                
                                                [self.navigationController pushViewController:riCheng animated:YES];
                                               
                                                    
                                              
                                               
                                                
                                                
} fail:^(id errorString) {
   
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"事件删除失败，请重新进行删除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    ;
}];
    
    
}

- (void) backButtonAction : (id) sender
{
    NSLog(@"---------返回按钮---parent-------------");
    [self.navigationController popViewControllerAnimated:NO];
   
  
    
}

//- (void)chooseTime:(UITapGestureRecognizer*)tap
//{
//    if ([tap isEqual:timeTap1]) {
//        number = 0;
//    }
//    if ([tap isEqual:timeTap2]) {
//        number = 1;
//    }
//    [button setHidden:YES];
//    [UIView animateWithDuration:0.3 animations:^{
//        [datePicker setFrame:CGRectMake(0, self.contentViewHeight-216, 0, 0)];
//    }];
//    
//}
//- (void)dateChanged:(id)sender
//{
//    NSDate *date = datePicker.date;
//    //NSLog(@"====%@",[date description]);
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"MM月dd日 EEE HH:mm"];
//    NSString* dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
//    NSLog(@"%@",dateStr);
//    [dateFormatter release];
//    if (number == 0) {
//        [startLabel setText:dateStr];
//    }
//    if (number == 1) {
//        [finishLabel setText:dateStr];
//    }
//    [UIView animateWithDuration:.5f delay:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [datePicker setFrame:CGRectMake(0, self.contentViewHeight+216, 0, 0)];
//    } completion:^(BOOL finished) {
//        [button setHidden:NO];
//    }];
//}

@end
