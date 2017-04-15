//
//  TongyongViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//通用
#import "TongyongViewController.h"
#import "AppDelegate.h"
@interface TongyongViewController ()

@end

@implementation TongyongViewController
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
    [self addBackButton];
    [self setTitle:@"通用"];
    [self setTabBarHidden:YES];
    
    
    
    isLeft = [[[NSUserDefaults standardUserDefaults]objectForKey:@"isleft"]boolValue];
    isLeft2 = [[[NSUserDefaults standardUserDefaults]objectForKey:@"isleft2"]boolValue];
    
    //新消息提醒
    isNewRemind = [[[NSUserDefaults standardUserDefaults]objectForKey:@"isNewRemind"]boolValue];
    
    NSLog(@"isleft=%hhd,isleft2=%hhd",isLeft,isLeft2);
    
    for (int i=1; i<4; i++) {
        //每个横栏的背景图
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 55*(i-1), 480, 110/2)];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [imageView setImage:[UIImage imageNamed:@"59_kuang_1"]];
        [self.contentView addSubview:imageView];

        //字体大不，震动，声音的Label
        //   NSArray *array=[NSArray arrayWithObjects:@"字体大小:",@"震动:",@"声音:", nil];
        // UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, (55*(i-1)), 80, 55)];
        //有关字体的东西去掉,替换为新消息提醒 2014.04.21 chenlihua
        NSArray *array=[NSArray arrayWithObjects:@"新消息提醒:",@"震动:",@"声音:", nil];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, (55*(i-1)), 100, 55)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextAlignment:NSTextAlignmentLeft];
        [lab setNumberOfLines:0];
        [lab setFont:[UIFont systemFontOfSize:18]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[array objectAtIndex:(i-1)]];
        [lab setFont:[UIFont fontWithName:KUIFont size:17]];
        [self.contentView addSubview:lab];
    }
    
    //字体背景图 ,有关字体的东西去掉，替换为新消息提醒 2014.04.21 chenlihua
    /*
    UIImage *chooseKuang = [UIImage imageNamed:@"15_anniu_1.png"];
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn setFrame:CGRectMake(187, 16, chooseKuang.size.width/2, chooseKuang.size.height/2)];
    [chooseBtn setBackgroundImage:chooseKuang forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(chooseFont:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:chooseBtn];
    
    //字体大小Label
    fontLabel = [[UILabel alloc]initWithFrame:CGRectMake(195, 16, 20, chooseKuang.size.height/2)];
    [fontLabel setBackgroundColor:[UIColor clearColor]];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"fontSize"]) {
        [fontLabel setText:@"12"];
    }else{
        [fontLabel setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"fontSize"]];
    }
    //[fontLabel setFont:[UIFont systemFontOfSize:13]];
    [Utils setMyDefaultFont:fontLabel];
    [fontLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:fontLabel];
    */
    
    //开关
    //新消息提醒
    //有关字体的东西去掉，替换为新消息提醒 2014.04.21 chenlihua
    toggleViewBaseChangeRemind = [[ToggleView alloc]initWithFrame:CGRectMake(250, 17, 100, 30) toggleViewType:ToggleViewTypeNoLabel toggleBaseType:ToggleBaseTypeChangeImage toggleButtonType:ToggleButtonTypeDefault];
    toggleViewBaseChangeRemind.toggleDelegate = self;
    [self.contentView addSubview:toggleViewBaseChangeRemind];
    
    //震动的开关
    toggleViewBaseChange1 = [[ToggleView alloc]initWithFrame:CGRectMake(250, 73, 100, 30) toggleViewType:ToggleViewTypeNoLabel toggleBaseType:ToggleBaseTypeChangeImage toggleButtonType:ToggleButtonTypeDefault];
    toggleViewBaseChange1.toggleDelegate = self;
    [self.contentView addSubview:toggleViewBaseChange1];
    
    //声音的开关
    toggleViewBaseChange2 = [[ToggleView alloc]initWithFrame:CGRectMake(250, 128, 100, 30) toggleViewType:ToggleViewTypeNoLabel toggleBaseType:ToggleBaseTypeChangeImage toggleButtonType:ToggleButtonTypeDefault];
    toggleViewBaseChange2.toggleDelegate = self;
    [self.contentView addSubview:toggleViewBaseChange2];
    
    
    UIImage *onImage = [UIImage imageNamed:@"71_dian_2.png"];
    UIImage *offImage = [UIImage imageNamed:@"64tongyong_icon02.png"];
    
    //新消息提醒开关
    onViewRemind = [[UIImageView alloc]initWithFrame:CGRectZero];
    [onViewRemind setImage:onImage];
    [self.contentView addSubview:onViewRemind];
    
    offViewRemind = [[UIImageView alloc]initWithFrame:CGRectZero];
    [offViewRemind setImage:offImage];
    [self.contentView addSubview:offViewRemind];
    
    if (isNewRemind) {
        [onViewRemind setFrame:CGRectMake(272, 17, 19, 19)];
        [offViewRemind setFrame:CGRectMake(272, 17, 19, 19)];
        [onViewRemind setHidden:YES];
        [offViewRemind setHidden:NO];
        [toggleViewBaseChangeRemind setSelectedButton:ToggleButtonSelectedLeft];
    }else{
        [onViewRemind setFrame:CGRectMake(290, 17, 19, 19)];
        [offViewRemind setFrame:CGRectMake(290, 17, 19, 19)];
        [offViewRemind setHidden:YES];
        [onViewRemind setHidden:NO];
        [toggleViewBaseChangeRemind setSelectedButton:ToggleButtonSelectedRight];
    }

    //震动开关
    onView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [onView setImage:onImage];
    [self.contentView addSubview:onView];

    offView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [offView setImage:offImage];
    [self.contentView addSubview:offView];

    if (isLeft) {
        [onView setFrame:CGRectMake(272, 73, 19, 19)];
        [offView setFrame:CGRectMake(272, 73, 19, 19)];
        [onView setHidden:YES];
        [offView setHidden:NO];
        [toggleViewBaseChange1 setSelectedButton:ToggleButtonSelectedLeft];
    }else{
        [onView setFrame:CGRectMake(290, 73, 19, 19)];
        [offView setFrame:CGRectMake(290, 73, 19, 19)];
        [offView setHidden:YES];
        [onView setHidden:NO];
        [toggleViewBaseChange1 setSelectedButton:ToggleButtonSelectedRight];
    }
    
    //声音开关
    onView2 = [[UIImageView alloc]initWithFrame:CGRectZero];
    [onView2 setImage:onImage];
    [self.contentView addSubview:onView2];

    offView2 = [[UIImageView alloc]initWithFrame:CGRectZero];
    [offView2 setImage:offImage];
    [self.contentView addSubview:offView2];

    if (isLeft2) {
        [onView2 setFrame:CGRectMake(272, 128, 19, 19)];
        [offView2 setFrame:CGRectMake(272, 128, 19, 19)];
        [onView2 setHidden:YES];
        [offView2 setHidden:NO];
        [toggleViewBaseChange2 setSelectedButton:ToggleButtonSelectedLeft];
    }else{
        [onView2 setFrame:CGRectMake(290, 128, 19, 19)];
        [offView2 setFrame:CGRectMake(290, 128, 19, 19)];
        [onView2 setHidden:NO];
        [offView2 setHidden:YES];
        [toggleViewBaseChange2 setSelectedButton:ToggleButtonSelectedRight];
    }
//    fontArray = [[NSArray alloc]initWithObjects:@"10",@"12",@"14", nil];
//    //myPickerView = [[APickerView alloc]initWithFrame:CGRectMake(0, self.contentViewHeight+216, 320, 216)];
//    myPickerView = [[APickerView alloc]initWithData:fontArray];
//    //[myPickerView setBackgroundColor:[UIColor whiteColor]];
//    myPickerView.delegate = self;
//    //myPickerView.showsSelectionIndicator = YES;
//    [self.contentView addSubview:myPickerView];
//    [myPickerView release];
}
#pragma  -mark -ToggleViewDelegate
- (void)selectLeftButton:(ToggleView*)toggleView
{
    if ([toggleView isEqual:toggleViewBaseChange1]) {
        NSLog(@"震动开关");
        if (!isLeft) {
            [UIView animateWithDuration:0.3 animations:^{
                [offView setHidden:NO];
                [onView setHidden:YES];
                [offView setFrame:CGRectMake(272, 73, 19, 19)];
                [onView setFrame:CGRectMake(272, 73, 19, 19)];
            }];
        }
        isLeft = YES;
        shake = YES ;
        //[[NSUserDefaults standardUserDefaults]setBool:isLeft forKey:@"isleft"];
        //2014.08.18 chenlihua 修改声音和震动
        NSUserDefaults *shakeDefault=[NSUserDefaults standardUserDefaults];
        [shakeDefault setBool:isLeft forKey:@"isleft"];
        [shakeDefault synchronize];
        
    }else if ([toggleView isEqual:toggleViewBaseChange2]) {
        NSLog(@"声音开关");
        if (!isLeft2) {
            [UIView animateWithDuration:0.3 animations:^{
                [offView2 setHidden:NO];
                [onView2 setHidden:YES];
                [onView2 setFrame:CGRectMake(272, 128, 19, 19)];
                [offView2 setFrame:CGRectMake(272, 128, 19, 19)];
            }];
        }
        
        isLeft2 = YES;
        sound = YES;
       // [[NSUserDefaults standardUserDefaults]setBool:isLeft2 forKey:@"isleft2"];
        //2014.08.18 chenlihua 修改声音和震动
        NSUserDefaults *soundDefault=[NSUserDefaults standardUserDefaults];
        [soundDefault setBool:isLeft2 forKey:@"isleft2"];
        [soundDefault synchronize];
        
    }else if ([toggleView isEqual:toggleViewBaseChangeRemind])
    {
        //新消息提醒
        if (!isNewRemind) {
            [UIView animateWithDuration:0.3 animations:^{
                [offViewRemind setHidden:NO];
                [onViewRemind setHidden:YES];
                [offViewRemind setFrame:CGRectMake(272, 17, 19, 19)];
                [onViewRemind setFrame:CGRectMake(272, 17, 19, 19)];
            }];
        }
        isNewRemind = YES;
        //全局变量赋值
        remind = YES;
      //  [[NSUserDefaults standardUserDefaults]setBool:isNewRemind forKey:@"isNewRemind"];
        //2014.08.18 chenlihua 修改声音和震动
        NSUserDefaults *remindDefault=[NSUserDefaults standardUserDefaults];
        [remindDefault setBool:isNewRemind forKey:@"isNewRemind"];
        [remindDefault synchronize];

    }
}
- (void)selectRightButton:(ToggleView*)toggleView
{
    if ([toggleView isEqual:toggleViewBaseChange1]) {
        NSLog(@"震动");
        if (isLeft) {
            [UIView animateWithDuration:0.3 animations:^{
                [offView setHidden:YES];
                [onView setHidden:NO];
                [onView setFrame:CGRectMake(290, 73, 19, 19)];
                [offView setFrame:CGRectMake(290, 73, 19, 19)];
            }];
        }
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        isLeft = NO;
        shake = NO;
        
       // [[NSUserDefaults standardUserDefaults]setBool:isLeft forKey:@"isleft"];
        //2014.08.19 chenlihua
        NSUserDefaults *shakeDefault=[NSUserDefaults standardUserDefaults];
        [shakeDefault setBool:isLeft forKey:@"isleft"];
        [shakeDefault synchronize];
        
    }else if ([toggleView isEqual:toggleViewBaseChange2]) {
        AudioServicesPlaySystemSound(1000);
        NSLog(@"声音");
        if (isLeft2) {
            [UIView animateWithDuration:0.3 animations:^{
                [offView2 setHidden:YES];
                [onView2 setHidden:NO];
                [onView2 setFrame:CGRectMake(290, 128, 19, 19)];
                [offView2 setFrame:CGRectMake(290, 128, 19, 19)];
            }];
        }
        isLeft2= NO;
        sound = NO;
      //  [[NSUserDefaults standardUserDefaults]setBool:isLeft2 forKey:@"isleft2"];
        
        //2014.08.19 chenlihua
        NSUserDefaults *soundDefault=[NSUserDefaults standardUserDefaults];
        [soundDefault setBool:isLeft2 forKey:@"isleft2"];
        [soundDefault synchronize];
        
        
    }else if ([toggleView isEqual:toggleViewBaseChangeRemind]){

        //新消息提醒
        if (isNewRemind) {
            NSLog(@"新消息提醒");
            [UIView animateWithDuration:0.3 animations:^{
                [offViewRemind setHidden:YES];
                [onViewRemind setHidden:NO];
                [onViewRemind setFrame:CGRectMake(290, 17, 19, 19)];
                [offViewRemind setFrame:CGRectMake(290, 17, 19, 19)];
            }];
        }
        isNewRemind = NO;
        remind = NO ;
       // [[NSUserDefaults standardUserDefaults]setBool:isNewRemind forKey:@"isNewRemind"];
        
        //2014.08.19 chenlihua
        NSUserDefaults *remindDefault=[NSUserDefaults standardUserDefaults];
        [remindDefault setBool:isNewRemind forKey:@"isNewRemind"];
        [remindDefault synchronize];
    }
}
#pragma  -mark -pickerView dataSource
//有关字体的东西，暂时取消了
- (void)chooseFont:(UIButton*)sender
{
    fontArray = [[NSArray alloc]initWithObjects:@"10",@"12",@"14", nil];
    myPickerView = [[APickerView alloc]initWithData:fontArray];
    myPickerView.delegate = self;
    [self.contentView addSubview:myPickerView];

    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"mySize"]) {
        [myPickerView setSelectRow:1 inComponent:0 animated:YES];
    }else{
        [myPickerView setSelectRow:[[[NSUserDefaults standardUserDefaults]objectForKey:@"mySize"]intValue] inComponent:0 animated:YES];
    }
    
    //[UIView animateWithDuration:.3f animations:^{
        //[myPickerView setFrame:CGRectMake(0, self.contentViewHeight-216, 320, 216)];
    //}];
    //[myPickerView selectRow:[[[NSUserDefaults standardUserDefaults]objectForKey:@"mySize"]intValue] inComponent:0 animated:YES];
}
- (void) pickerViewSelectObject : (id) object index : (NSInteger) index
{
    int i = -1;
    switch (index) {
        case 0:
            i = 0;
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",i] forKey:@"mySize"];
            [[NSUserDefaults standardUserDefaults]setObject:@"10" forKey:@"fontSize"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            break;
        case 1:
            i = 1;
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",i] forKey:@"mySize"];
            [[NSUserDefaults standardUserDefaults]setObject:@"12" forKey:@"fontSize"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            break;
        case 2:
            i = 2;
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",i] forKey:@"mySize"];
            [[NSUserDefaults standardUserDefaults]setObject:@"14" forKey:@"fontSize"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            break;
        default:
            break;
    }
//    [UIView animateWithDuration:.5f delay:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [myPickerView setFrame:CGRectMake(0, self.contentViewHeight+216, 320, 216)];
//    } completion:nil];
    fontLabel.text = [fontArray objectAtIndex:index];
    [Utils setMyDefaultFont:fontLabel];
}
@end
