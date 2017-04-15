//
//  RongZiBianJiViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//融资方案编辑
#import "RongZiBianJiViewController.h"
#import "RongZiFangAnViewController.h"

@interface RongZiBianJiViewController ()

@end

@implementation RongZiBianJiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (id)initValueString:(NSString *)zetext rzfsText:(NSString *)rzfsText gzfaText:(NSString *)gzfa tcfsText:(NSString *)tcfsText
//{
//    self=[super init];
//    if (self) {
//        //        [self setTitle:title];
//        rzLable = [[NSString alloc] initWithFormat:@"%@",zetext];
//        rzfsLable = [[NSString alloc] initWithFormat:@"%@",rzfsText];
//        gzfsLable = [[NSString alloc] initWithFormat:@"%@",gzfa];
//        tcfsLable = [[NSString alloc] initWithFormat:@"%@",tcfsText];
//        
//    }
//    return self;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [self setTitle:@"编辑"];
    
    
    //右侧完成按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton setTitle:@"完成" forState:UIControlStateHighlighted];
    //2014.05.30 chenlihua 完成按钮放出来，原来是注释掉的。
    [rightButton addTarget:self action:@selector(WanChengEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rightButton isAutoFrame:NO];

    
    //cell背景图
    UIImage* bcImg = [UIImage imageNamed:@"60_kuang_1"];
    for (int i =0 ; i < 4; i++) {
        
        //cell的背景图
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10+55*i, 320, 80)];
        [bcImgV setImage:bcImg];
        [self.contentView addSubview:bcImgV];
        
        //黄色背景图
        UIImageView *imageViewtext=[[UIImageView alloc]initWithFrame:CGRectMake(310-400/2, 30+(55*i), 385/2, 20)];
        [imageViewtext setImage:[UIImage imageNamed:@"61_kuang_1"]];
        [self.contentView addSubview:imageViewtext];
        
        //融资方案等Label
        NSArray *array =[NSArray arrayWithObjects:@"【融资金额】",@"【融资方式】",@"【估值方案】",@"【退出方式】", nil];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(5, 25+(55*i), 90, 25)];
        [lab setFont:[UIFont fontWithName:KUIFont size:14]];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setFont:[UIFont systemFontOfSize:15]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[array objectAtIndex:i]];
        [self.contentView addSubview:lab];
        
        //":"Label
        UILabel *maohaolab=[[UILabel alloc]initWithFrame:CGRectMake(95, 25+(55*i), 90, 25)];
        [maohaolab setBackgroundColor:[UIColor clearColor]];
        [maohaolab setFont:[UIFont systemFontOfSize:15]];
        [maohaolab setTextColor:[UIColor blackColor]];
        [maohaolab setText:@":"];
        [self.contentView addSubview:maohaolab];
    }
    //请输入融资金额内容Label
    rzjeTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-400/2+8, 30+(55*0)+2, 385/2-16, 20-4)];
    [rzjeTextField setBorderStyle:UITextBorderStyleNone];
    [rzjeTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [rzjeTextField setPlaceholder:@"请输入融资金额"];
    [rzjeTextField setText:[self.dataDic objectForKey:@"money"]];
    [Utils setDefaultFont:rzjeTextField size:15];
    [rzfsTextField setFont:[UIFont fontWithName:KUIFont size:15]];
    [rzjeTextField setReturnKeyType:UIReturnKeyNext];
    [rzjeTextField setDelegate:self];
    rzjeTextField.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:rzjeTextField];

    //请输入融资方式内容Label
    rzfsTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-400/2+8, 30+(55*1)+1, 385/2-16, 20-4)];
    [rzfsTextField setBorderStyle:UITextBorderStyleNone];
    [rzfsTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [rzfsTextField setPlaceholder:@"请输入融资方式"];
    [rzfsTextField setText:[self.dataDic objectForKey:@"way"]];
    [Utils setDefaultFont:rzfsTextField size:15];
    [rzfsTextField setFont:[UIFont fontWithName:KUIFont size:15]];
    [rzfsTextField setReturnKeyType:UIReturnKeyNext];
    [rzfsTextField setDelegate:self];
    [self.contentView addSubview:rzfsTextField];

    //请填写估值方案内容Label
    gzfaTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-400/2+8, 30+(55*2)+2, 385/2-16, 20-4)];
    [gzfaTextField setBorderStyle:UITextBorderStyleNone];
    [gzfaTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [gzfaTextField setPlaceholder:@"请填写估值方案"];
    [gzfaTextField setText:[self.dataDic objectForKey:@"program"]];
    [Utils setDefaultFont:gzfaTextField size:15];
    [gzfaTextField setFont:[UIFont fontWithName:KUIFont size:15]];
    [gzfaTextField setReturnKeyType:UIReturnKeyNext];
    [gzfaTextField setDelegate:self];
    [self.contentView addSubview:gzfaTextField];

    //请编辑退出方式内容Label
    tcfsTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-400/2+8, 30+(55*3)+2, 385/2-16, 20-4)];
    [tcfsTextField setBorderStyle:UITextBorderStyleNone];
    [tcfsTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [tcfsTextField setPlaceholder:@"请编辑退出方式"];
    [Utils setDefaultFont:tcfsTextField size:15];
    [tcfsTextField setFont:[UIFont fontWithName:KUIFont size:15]];
    [tcfsTextField setText:[self.dataDic objectForKey:@"quit"]];
    [tcfsTextField setReturnKeyType:UIReturnKeyNext];
    [tcfsTextField setDelegate:self];
    [self.contentView addSubview:tcfsTextField];
}
#pragma -mark -UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:rzjeTextField]) {
        [rzfsTextField becomeFirstResponder];
        return YES;
    }else if ([textField isEqual:rzfsTextField]){
        [gzfaTextField becomeFirstResponder];
        return YES;
    }else if ([textField isEqual:gzfaTextField]){
        
        [tcfsTextField becomeFirstResponder];
    }else if ([textField isEqual:tcfsTextField]){
        //[UIView beginAnimations:@"" context:nil];
        //self.contentView.frame=CGRectMake(0, 64, 320, self.contentViewHeight);
        //[UIView commitAnimations];
        [tcfsTextField resignFirstResponder];
    }
    return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:gzfaTextField]) {
        
        //[UIView beginAnimations:@"" context:nil];
        //self.contentView.frame=CGRectMake(0, -50, 320, self.contentViewHeight);
        //[UIView commitAnimations];

    }
    return YES;
}
//- (void)saveNSUserDefaults {
//    
//    NSString *rzjeString=rzjeTextField.text;
//    NSString *rzfsString=rzfsTextField.text;
//    NSString *gzfaString=gzfaTextField.text;
//    NSString *tcfsString=tcfsTextField.text;
//    
//    
//    [(RongZiFangAnViewController*)self.delegate
//     reloadWithText:rzjeString
//     Text:rzfsString
//     Text:gzfaString
//     Text:tcfsString];
//    [self.navigationController popViewControllerAnimated:YES];
//
//    
//}
//2014.05.30 chenlihua 原来完成按钮是注释掉的。现在把“完成”按钮放出来，并且点击时，使其跳转到融资信息界面。
- (void)WanChengEvent:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
