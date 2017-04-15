//
//  AddTimeViewController.m
//  FangChuang
//
//  Created by 顾 思谨 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//编辑页面
#import "AddTimeViewController.h"
#import "RemindViewController.h"
#import "EditTimeViewController.h"

#define PROJECTPICKER 100
#define PEOPLEPICKER 200

@interface AddTimeViewController ()
@property(nonatomic,retain)UITextField *addLabel;
@property(nonatomic,retain)UITextField *selectTF;
@property(nonatomic,retain) APickerView *myPickerView;
@property(nonatomic,retain) NSMutableArray *dataArray;
@property(nonatomic,copy) NSString *projectid;
@property(nonatomic,retain)UIButton *kuangView2;
@property ( nonatomic , retain) NSArray* users;

@end

@implementation AddTimeViewController
@synthesize myDic=_myDic,editeType=_editeType,proid=_proid,starDate=_starDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [remindTimeLabel setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"RemindTime"]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"编辑";
    [self addBackButton];
    [self setTabBarHidden:YES];
    
    self.dataArray=[[NSMutableArray alloc]init];
    
    //“完成"
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-80, -5, 100, 50)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor=[UIColor clearColor];
    [self addRightButton:rightButton isAutoFrame:NO];
    
//    UIImage *buttonImage = [UIImage imageNamed:@"028_anniu_1.png"];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setFrame:CGRectMake(40, 300, 240, buttonImage.size.height/2)];
//    [button setTitle:@"删除事件" forState:UIControlStateNormal];
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:button];
    
    [self initContentView];
}
#pragma -mark -functions
- (void)initContentView
{
    //背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:bgView];

    //暂时未知是什么
    UIImage *bg1 = [UIImage imageNamed:@"028_wenzikuang_1.png"];
    UIImageView *bgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, bg1.size.height/2+50)];
    [bgView1 setImage:bg1];

    //第一行输入框背景图
    UIImage *kuang = [UIImage imageNamed:@"27_shurukuang_1.png"];
    UIImageView *kuangView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(bgView.frame)+10, 300, kuang.size.height/2)];
    [kuangView setImage:kuang];
    [bgView addSubview:kuangView];

    //第一行输入框
    self.addLabel = [[UITextField alloc]initWithFrame:kuangView.frame];
    self.addLabel.placeholder=@"日程标题";
    [self.addLabel setText:[self.myDic objectForKey:@"sname"]];
    [self.addLabel setTextColor:[UIColor lightGrayColor]];
    [self.addLabel setFont:[UIFont systemFontOfSize:15]];
    [self.addLabel setBackgroundColor:[UIColor clearColor]];
    [self.addLabel setTextAlignment:NSTextAlignmentCenter];
    //2014.08.19 chenlihua 使键盘能正常返回
    self.addLabel.delegate=self;

    //[addLabel setUserInteractionEnabled:YES];
    [bgView addSubview:self.addLabel];

//    UITapGestureRecognizer *go = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(go:)];
//    [addLabel addGestureRecognizer:go];
//    [go release];
    
    
       UIImage *personKuang = [UIImage imageNamed:@"27_shurukuang_1.png"];
    
//    if(_editeType==1){
    
       //查找项目的背景框
        UIImage *kuang3 = [UIImage imageNamed:@"27_shurukuang_1.png"];
        UIImageView *kuangView3 = [[UIImageView alloc]init];
        kuangView3.frame=CGRectMake(310-kuang3.size.width/2, CGRectGetMaxY(kuangView.frame)+20, kuang3.size.width/2-100, kuang3.size.height/2);
        [kuangView3 setImage:kuang3];
        [kuangView3 setUserInteractionEnabled:YES];
        [bgView addSubview:kuangView3];

        //查找项目,textField
        self.selectTF = [[UITextField alloc]init];
        self.selectTF.frame=CGRectMake(CGRectGetMinX(kuangView3.frame)+5, CGRectGetMinY(kuangView3.frame), CGRectGetWidth(kuangView3.frame)-10, CGRectGetHeight(kuangView3.frame));
        [self.selectTF setBackgroundColor:[UIColor clearColor]];
        [self.selectTF setTextAlignment:NSTextAlignmentCenter];
        //2014.08.19 chenlihua 使键盘能正常返回
        self.selectTF.delegate=self;
        [bgView addSubview:self.selectTF];

        //查找项目button
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame=CGRectMake(CGRectGetMaxX(kuangView3.frame)+10,CGRectGetMaxY(self.selectTF.frame)+38,90, 30);
//    btn.frame=CGRectMake(CGRectGetMaxX(kuangView3.frame)+10,CGRectGetMinY(self.selectTF.frame),90, 30);

        [btn setTitle:@"查找项目" forState:UIControlStateNormal];
        btn.layer.cornerRadius=5;
        btn.backgroundColor=[UIColor orangeColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicK) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
//    }
    //参与人Label
    UILabel *personLabel = [[UILabel alloc]init];
//    if(self.editeType==1)
//    {
        personLabel.frame=CGRectMake(10, CGRectGetMaxY(kuangView.frame)+70, 100, personKuang.size.height/2);

//    }
//    else
//    {
//        personLabel.frame=CGRectMake(10, CGRectGetMaxY(kuangView.frame)+20, 100, personKuang.size.height/2);
//    }
    [personLabel setText:@"参与人:"];
    [personLabel setTextColor:[UIColor orangeColor]];
    [personLabel setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:personLabel];

    
    //参与人button
    UIImage *kuang2 = [UIImage imageNamed:@"27_shurukuang_2.png"];
    self.kuangView2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    if(self.editeType==1){
        self.kuangView2.frame=CGRectMake(310-kuang2.size.width/2, personLabel.frame.origin.y, kuang2.size.width/2, kuang2.size.height/2);
    
    }
    else{
        self.kuangView2.frame=CGRectMake(310-kuang2.size.width/2, personLabel.frame.origin.y, kuang2.size.width/2, kuang2.size.height/2);
    }
    [self.kuangView2 setBackgroundImage:kuang2 forState:UIControlStateNormal];
    [self.kuangView2 setTitle:@"无" forState:UIControlStateNormal];
    [self.kuangView2 addTarget:self action:@selector(pickerViewShow) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.kuangView2];
    
//    personTextField = [[UITextField alloc]initWithFrame:CGRectMake(4, 4, kuang2.size.width/2-8, kuang2.size.height/2-8)];
//    [personTextField setDelegate:self];
//    [personTextField setTextColor:[UIColor lightGrayColor]];
//    personTextField.text=[self.myDic objectForKey:@"attend"];
//    [kuangView2 addSubview:personTextField];
//    [personTextField release];
    
    //开始结束背景图
    UIImageView *bgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView1.frame)+10, 320, bg1.size.height/2-20)];
    [bgView2 setImage:bg1];
    [bgView addSubview:bgView2];

    //开始Label
    UILabel *beginLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(bgView2.frame), 60, 80/2)];
    [beginLabel setText:@"开始"];
    [beginLabel setTextColor:[UIColor orangeColor]];
    [beginLabel setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:beginLabel];

    //结束Label
    UILabel *endLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(beginLabel.frame), 60, 80/2)];
    [endLabel setText:@"结束"];
    [endLabel setTextColor:[UIColor orangeColor]];
    [endLabel setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:endLabel];

    //开始内容
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(beginLabel.frame)+50, CGRectGetMinY(bgView2.frame), 190, 80/2)];
    [startLabel setBackgroundColor:[UIColor clearColor]];
    if(_editeType==0){
     
        NSString *timeStr=[self.myDic objectForKey:@"stime"];
        [startLabel setText:[NSString stringWithFormat:@"%@ %@:%@",[self.myDic objectForKey:@"sdate"],[timeStr substringWithRange:NSMakeRange(0, 2)],[timeStr substringWithRange:NSMakeRange(2,[timeStr length]-2)]]];
    }
    else{
    
        [startLabel setText:[NSString stringWithFormat:@"%@ %@",_starDate,[self getNowDate]]];
    
    }
    [startLabel setTextColor:[UIColor lightGrayColor]];
    [startLabel setTextAlignment:NSTextAlignmentRight];
    [startLabel setUserInteractionEnabled:YES];
    [bgView addSubview:startLabel];

    //结束内容
    finishLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(beginLabel.frame)+50, CGRectGetMaxY(startLabel.frame), 190, 80/2)];
    [finishLabel setBackgroundColor:[UIColor clearColor]];
    if(_editeType==0)
    {
    NSString *timeStr1=[self.myDic objectForKey:@"etime"];
    [finishLabel setText:[NSString stringWithFormat:@"%@ %@:%@",[self.myDic objectForKey:@"sdate"],[timeStr1 substringWithRange:NSMakeRange(0, 2)],[timeStr1 substringWithRange:NSMakeRange(2,[timeStr1 length]-2)]]];
    }
    else{
        [finishLabel setText:[NSString stringWithFormat:@"%@ %@",_starDate,[self getNowDate]]];
    
    }
    [finishLabel setTextColor:[UIColor lightGrayColor]];
    [finishLabel setTextAlignment:NSTextAlignmentRight];
    [finishLabel setUserInteractionEnabled:YES];
    [bgView addSubview:finishLabel];

    
    timeTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTime:)];
    [startLabel addGestureRecognizer:timeTap1];

    
    timeTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTime:)];
    [finishLabel addGestureRecognizer:timeTap2];

    //提醒背景框
    UIImageView *bgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView2.frame)+10, 320, 40)];
    [bgView3 setImage:bg1];
    [bgView3 setUserInteractionEnabled:YES];
    [bgView addSubview:bgView3];

    //提醒Label
    UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(bgView3.frame), 50, 40)];
    [remindLabel setText:@"提醒"];
    [remindLabel setTextColor:[UIColor orangeColor]];
    [remindLabel setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:remindLabel];

    //提醒内容Label
    remindTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, CGRectGetMinY(bgView3.frame), 100, 40)];
    //[remindTimeLabel setBackgroundColor:[UIColor orangeColor]];
    [remindTimeLabel setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"RemindTime"]];
    [remindTimeLabel setTextColor:[UIColor lightGrayColor]];
    [remindTimeLabel setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:remindTimeLabel];

    UITapGestureRecognizer *remindTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remind:)];
    [bgView3 addGestureRecognizer:remindTap];

    //提醒箭头
    UIImage *arrow = [UIImage imageNamed:@"27_jiantou_1.png"];
    UIImageView *arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(300-arrow.size.width/2, CGRectGetMinY(bgView3.frame)+12, arrow.size.width/2, arrow.size.height/2)];
    [arrowView setImage:arrow];
    [bgView addSubview:arrowView];

    //开始，结束的时间选择框
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.contentViewHeight+216, 0, 0)];
    //datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*365*10];
    //datePicker.maximumDate = [NSDate date];
    //datePicker.date = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    [self.contentView addSubview:datePicker];
}
- (NSString*)getNowDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    return dateStr;
}
//参与人
-(void)pickerViewShow
{
    //2014.08.22 chenlihua 使当点击参与人的时候，前面两个输入框出现的键盘都要自动消失。
    [self.addLabel resignFirstResponder];
    [self.selectTF resignFirstResponder];
    
    //2014.08.22 chenlihua 删除时间选择框
    [datePicker setFrame:CGRectMake(0, self.contentViewHeight, 0, 0)];
    
    [[NetManager sharedManager]scheduleacclistWithUsername:[[UserInfo sharedManager] username]
                                                 projectid:self.proid
                                                    hudDic:nil
                                                   success:^(id responseDic) {
                                                       
                                                    
                                                       
                                                       self.dataArray=[responseDic objectForKey:@"data"];
                                                       
                                                       self.userIDArray = [self.dataArray mutableArrayValueForKeyPath:@"usracc"];
                                                       
                                                       self.uesrNameArray = [self.dataArray mutableArrayValueForKeyPath:@"user_name"];
                                                       
                                                       //点击后删除之前的PickerView
                                                       for (UIView *view in self.view.subviews) {
                                                           if ([view isKindOfClass:[CYCustomMultiSelectPickerView class]]) {
                                                               [view removeFromSuperview];
                                                           }
                                                       }
                                                       
                                                       multiPickerView = [[CYCustomMultiSelectPickerView alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height - 260-20, 320, 260+44)];
                                                       
                                                       //  multiPickerView.backgroundColor = [UIColor redColor];
                                                       multiPickerView.entriesArray = self.uesrNameArray;
                                                       multiPickerView.entriesSelectedArray = nil;
                                                       multiPickerView.multiPickerDelegate = self;
                                                       
                                                       [self.view addSubview:multiPickerView];
                                                       
                                                       [multiPickerView pickerShow];
                                                       
                                                       
//                                                           self.myPickerView = [[APickerView alloc]initWithData:self.uesrNameArray];
//                                                           
//                                                           self.myPickerView.delegate = self;
//                                                           [self.view addSubview:self.myPickerView];
//                                                           [self.myPickerView release];
                                                       
                                                       
                                                   }
                                                      fail:^(id errorString) {
                                                          
                                                      } ];
    

}
//开始结束时间选择框
- (void)dateChanged:(id)sender
{
    NSDate *date = datePicker.date;
    //NSLog(@"====%@",[date description]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    dateFormatter.locale=[NSLocale systemLocale];
    NSString *dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    
    if (number == 0) {
        [startLabel setText:dateStr];
        NSDate *starDate=datePicker.date;
    }
    if (number == 1) {
        [finishLabel setText:dateStr];
    }
    [UIView animateWithDuration:.5f delay:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [datePicker setFrame:CGRectMake(0, self.contentViewHeight+216, 0, 0)];
    } completion:nil];

    /*
    ---startLabel--2014-08-29 10:38
    -finishLabel--2014-08-29 10:37
     */
    
    
    //2014.08.29 chenlihua 开始时间和结束时间的比较。
    BOOL result = [startLabel.text compare:finishLabel.text] == NSOrderedSame;
    NSLog(@"result:%d",result);
    if (result==1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"开始时间和结束时间不能相等" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    BOOL result1 = [startLabel.text compare:finishLabel.text]==NSOrderedDescending;
    if (result1==1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"开始时间不能晚于结束时间" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }

    
}

#pragma -mark  -picker delegate
//获取到选中的数据
-(void)returnChoosedPickerString:(NSMutableArray *)selectedEntriesArr
{
    NSLog(@"selectedArray=%@",selectedEntriesArr);
    
    NSMutableArray* newArray = [NSMutableArray array];
    
    for (NSString* str in selectedEntriesArr) {
        
        int index = [self.uesrNameArray indexOfObject:str];
        
        [newArray addObject:[self.userIDArray objectAtIndex:index]];
        
    }
    self.attend = [newArray componentsJoinedByString:@","];
    
//    self.kuangView2.titleLabel.text = dataStr;
    [self.kuangView2 setTitle:self.attend forState:UIControlStateNormal];
    // 再次初始化选中的数据
//    entriesSelected = [[NSArray arrayWithArray:selectedEntriesArr] retain];
}
- (void) pickerViewSelectObject : (id) object index : (NSInteger) index
{
    ;
}
- (void)pickerview:(APickerView *)view SelectObject:(id)object index:(NSInteger)index
{
    if (view.tag == PROJECTPICKER) {
        
        //在这里赋值 项目ID
        self.proid  = [self.projectIDArray objectAtIndex:index];
    }
    else if (view.tag == PEOPLEPICKER)
    {
        
    }
}
#pragma  -mark -doClickAction
//查找项目
-(void)btnClicK
{
    //2014.08.22 chenlihua 查找项目的时候，先要删除之前的参与人提示框。
    //点击后删除之前的PickerView
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[CYCustomMultiSelectPickerView class]]) {
            [view removeFromSuperview];
        }
    }
    //2014.08.22 chenlihua 删除时间选择框
    [datePicker setFrame:CGRectMake(0, self.contentViewHeight, 0, 0)];
    
    //2014.08.22 chenlihua 当查找项目为空的时候，弹出提示。
    if ([self.selectTF.text isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"要查找的项目不能为空" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    self.selectTF.font=[UIFont fontWithName:@"Arial-BoldMT" size:16];
    if(self.selectTF.text!=nil||[self.selectTF.text isEqualToString:@""]){
        [self.selectTF resignFirstResponder];
        [[NetManager sharedManager] prosearchWithUsername:[[UserInfo sharedManager] username]
                                                   search:[self.selectTF text]
                                                   hudDic:nil
                                                  success:^(id responseDic) {
                                                      NSLog(@"responseDic =%@",responseDic);
                                                      self.dataArray=[responseDic objectForKey:@"data"];
                                                      
                                                      self.projectIDArray = [self.dataArray mutableArrayValueForKeyPath:@"projectid"];
                                                      
                                                      self.projectNameArray = [self.dataArray mutableArrayValueForKeyPath:@"projectname"];
                                                      
                                                      
                                                      
                                                      //                                                  for(NSDictionary *dic in self.dataArray)
                                                      //                                                  {
                                                      //
                                                      //
                                                      //                                                  }
                                                      
                                                      self.myPickerView=[[APickerView alloc]initWithData:self.projectNameArray];
                                                      self.myPickerView.delegate = self;
                                                      [self.myPickerView setTag:PROJECTPICKER];
                                                      [self.view addSubview:self.myPickerView];
                                                      
                                                      
                                                      
                                                      
                                                  }
                                                     fail:^(id errorString) {
                                                         
                                                         
                                                         
                                                     }];
    }
    
}

//完成按钮
- (void)done:(UIButton*)sender
{
    NSLog(@"---startLabel--%@",startLabel.text);
    NSLog(@"---finishedLabel--%@",finishLabel.text);
    
    //2014.08.29 chenlihua 比较开始时间和结束时间，若开始时间晚于结束时间则弹出提示。
    BOOL result = [startLabel.text compare:finishLabel.text] == NSOrderedSame;
    NSLog(@"result:%d",result);
    if (result==1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"开始时间和结束时间不能相等" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    BOOL result1 = [startLabel.text compare:finishLabel.text]==NSOrderedDescending;
    if (result1==1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"开始时间不能晚于结束时间" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    
    

    NSLog(@"=====");
    if(_editeType==0)
    {
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"编辑成功",@"success", nil];
        
        //2014.08.23 chenlihua 在输入参数为空的时候，会出现提示
        if (!self.attend) {
            UIAlertView *alet=[[UIAlertView alloc]initWithTitle:@"提示" message:@"参与人不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alet show];
            return;
            
        }

    [[NetManager sharedManager] scheduleeditWithUsername:[self.myDic objectForKey:@"createby"]
                                              scheduleid:[self.myDic objectForKey:@"id"]
                                                   sdate:[startLabel.text substringWithRange:NSMakeRange(0, 10)]
                                                   stime:[startLabel.text substringWithRange:NSMakeRange(11, [startLabel.text length]-11)]
                                                   etime:[finishLabel.text substringWithRange:NSMakeRange(11, [finishLabel.text length]-11)]
                                                  attend:self.attend
                                                     pri:@"1"
                                                 project:/*_proid*/@"1"
                                                   sname:self.addLabel.text
                                                   sdesc:@"未使用"
                                                location:@"上海"
                                               alertmode:@"0"
                                                   alert:@"30"
                                                  hudDic:dic
                                                 success:^(id responseDic) {
                                                     [self.navigationController popViewControllerAnimated:YES];

                                                 }
                                                    fail:^(id errorString) {
                                                        
                                                    }];
    }
    else if(_editeType==1){
        
    NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:@"创建成功",@"success", nil];
        
    //2014.08.23 chenlihua 在输入参数为空的时候，会出现提示
        if (!self.attend) {
            UIAlertView *alet=[[UIAlertView alloc]initWithTitle:@"提示" message:@"参与人不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alet show];
            return;

        }
        /*
        -dic---{
            alert = 30;
            apptoken = app540404f6c7e7c;
            attend = p52d16f7659340;
            etime = "10:32";
            location = "\U4e0a\U6d77";
            pri = 1;
            project = 1;
            sdate = "2014-09-12";
            sdesc = "\U672a\U4f7f\U7528";
            sname = 7777777777;
            stime = "01:32";
            username = crystal;
        }
*/
        
    [[NetManager sharedManager]schedulecreateWithUsername:[[UserInfo sharedManager]username]
                                                    sdate:[startLabel.text substringWithRange:NSMakeRange(0, 10)]
                                                    stime:[startLabel.text substringWithRange:NSMakeRange(11, [startLabel.text length]-11)]
                                                    etime:[finishLabel.text substringWithRange:NSMakeRange(11, [finishLabel.text length]-11)]
                                                   attend:self.attend
                                                      pri:@"1"
                                                  project:/*_proid*/@"1"
                                                    sname:self.addLabel.text
                                                    sdesc:@"未使用"
                                                 location:@"上海"
                                                alertmode:@"0"
                                                    alert:@"30"
                                                   hudDic:dic1
                                                  success:^(id responseDic) {
                                                      
                                                      [self.navigationController popViewControllerAnimated:YES];
                                                  }
                                                     fail:^(id errorString) {
                                                         
                                                         ;                                                     }];
    }
}
//选择时间
- (void)chooseTime:(UITapGestureRecognizer*)tap
{
    
    //点击后删除之前的PickerView
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[CYCustomMultiSelectPickerView class]]) {
            [view removeFromSuperview];
        }
    }

    //2014.08.22 chenlihua 先把时间框的位置放于0，给人一种比较好的动画感觉。
    [datePicker setFrame:CGRectMake(0, self.contentViewHeight, 0, 0)];
    
    //2014.08.22 chenlihua 选择开始，结束时，键盘要消失。
    [self.addLabel resignFirstResponder];
    [self.selectTF resignFirstResponder];
    
    
    if ([tap isEqual:timeTap1]) {
        number = 0;
    }
    if ([tap isEqual:timeTap2]) {
        number = 1;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [datePicker setFrame:CGRectMake(0, self.contentViewHeight-216, 0, 0)];
    }];
}
//提醒
- (void)remind:(UITapGestureRecognizer*)tap
{
    RemindViewController *vc = [[RemindViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma  -mark -Textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   // [personTextField resignFirstResponder];
    //2014.08.19 chenlihua 使返回按钮能正常返回
    [textField resignFirstResponder];
    return YES;
}
//2014.08.22 chenlihua 添加UITextFiled Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //点击后删除之前的PickerView
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[CYCustomMultiSelectPickerView class]]) {
            [view removeFromSuperview];
        }
        
    }
    //删除时间选择框。
    [datePicker setFrame:CGRectMake(0, self.contentViewHeight, 0, 0)];
   
    /*
    [UIView animateWithDuration:0.5 animations:^{
        [datePicker setFrame:CGRectMake(0, self.contentViewHeight-216, 0, 0)];
    }];
    */
}
@end
