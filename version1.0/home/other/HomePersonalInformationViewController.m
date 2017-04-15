//
//  HomePersonalInformationViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-28.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//完善个人资料
#import "HomePersonalInformationViewController.h"
//验证页面
#import "HomeVerifyViewController.h"
//请选择身份界面
#import "HomeChooseIdentifyViewController.h"

@interface HomePersonalInformationViewController ()

@end

@implementation HomePersonalInformationViewController

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
    
    //标题
    [self setTitle:@"完善个人资料"];
    
    //返回按钮
    //修改返回的时候验证码自动重新发送的问题。
    // [self addBackButton];
    
    //初始化背景图
    [self initBackgroundView];
    
    //隐藏工具条
    [self setTabBarHidden:YES];
}
#pragma -mark -functions
-(void)initBackgroundView
{
    textFieldArray=[[NSMutableArray alloc]initWithObjects:@"请输入您的姓名",@"请输入公司名称",@"请输入职位",@"请输入邮箱",@"请输入网址", nil];
    
   imageArray=[[NSMutableArray alloc]initWithObjects:@"homepersonalinformationame",@"homepersonalinformationcompany",@"homepersonalinformationcomposition",@"homepersonalinformationmail",@"homepersonalinformationurl", nil];
    
    
    //背景UIScrollerView
    backScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [backScrollerView setBackgroundColor:[UIColor clearColor]];
    [backScrollerView setShowsVerticalScrollIndicator:NO];
    [backScrollerView setContentSize:CGSizeMake(320,700)];
    [backScrollerView setDelegate:self];
    backScrollerView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:backScrollerView];
    
    for (int i=0; i<5; i++) {
        
         //背景图
        backNameView=[[UIView alloc]initWithFrame:CGRectMake(0, 35+50*i, 320, 50)];
        backNameView.backgroundColor=[UIColor whiteColor];
        [backScrollerView addSubview:backNameView];
        
        //线
        UIImageView *lineNameView=[[UIImageView alloc]initWithFrame:CGRectMake(0, backNameView.frame.size.height-1, 320,0.5)];
        lineNameView.image=[UIImage imageNamed:@"homepersonalinformationline"];
        [backNameView addSubview:lineNameView];
        
        //背景图上图标
        UIImageView *nameImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 29, 29)];
        nameImage.image=[UIImage imageNamed:[imageArray objectAtIndex:i]];
        [backNameView addSubview:nameImage];
        
        //name输入框
        UITextField *nameTextField=[[UITextField alloc]initWithFrame:CGRectMake(nameImage.frame.origin.x+nameImage.frame.size.width+15, 17, 200, 20)];
        nameTextField.placeholder=[textFieldArray objectAtIndex:i];
        nameTextField.backgroundColor=[UIColor clearColor];
        nameTextField.textColor=[UIColor grayColor];
        nameTextField.tag=i;
        nameTextField.delegate=self;
        nameTextField.font=[UIFont fontWithName:KUIFont size:12];
        
       
        
        if (i==0) {
            nameTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
            text0=nameTextField.text;
        }else if (i==1){
            nameTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"company"];
            text1=nameTextField.text;

        }else if (i==2){
            nameTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"compostion"];
            text2=nameTextField.text;


        }else if(i==3){
            nameTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
            text3=nameTextField.text;


        }else if (i==4){
          
            nameTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"url"];
            text4=nameTextField.text;
            

        }
        [backNameView addSubview:nameTextField];

    }
    
    //提示
    remindImageView=[[UIImageView alloc]initWithFrame:CGRectMake(50, 310, 180, 10)];
    remindImageView.backgroundColor=[UIColor clearColor];
    remindImageView.image=[UIImage imageNamed:@"homepersonalinformationremind"];
    [backScrollerView addSubview:remindImageView];
    
    //下一步
    
    nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame=CGRectMake(22, remindImageView.frame.origin.y+remindImageView.frame.size.height+60, 275, 37);
    [nextButton setBackgroundImage:[UIImage imageNamed:@"homepersonalinformationnextbutton"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(doClickNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:nextButton];
                          
    
}
//通过区分字符串来验证邮箱
-(BOOL)validateEmail:(NSString*)email
{
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length))
    {
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy];
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        /*
         *使用compare option 来设定比较规则，如
         *NSCaseInsensitiveSearch是不区分大小写
         *NSLiteralSearch 进行完全比较,区分大小写
         *NSNumericSearch 只比较定符串的个数，而不比较字符串的字面值
         */
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        
        //取得域名部分
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else {
        return NO;
    }
}
//用正则表达式验证邮箱的合法性
-(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

#pragma -mark -doClickActins
-(void)doClickNextButton:(UIButton *)btn
{
    NSLog(@"--doClickNextButton--");
    
    NSLog(@"---text0--%@--",text0);
    NSLog(@"---text1--%@--",text1);
    NSLog(@"---text2--%@--",text2);
    NSLog(@"---text3--%@--",text3);
    NSLog(@"--text4--%@",text4);
    
    UITextField *textFild0=(UITextField *)[self.view viewWithTag:0];
    [textFild0 resignFirstResponder];
    UITextField *textFild1=(UITextField *)[self.view viewWithTag:1];
    [textFild1 resignFirstResponder];
    UITextField *textFild2=(UITextField *)[self.view viewWithTag:2];
    [textFild2 resignFirstResponder];
    UITextField *textFild3=(UITextField *)[self.view viewWithTag:3];
    [textFild3 resignFirstResponder];
    UITextField *textFild4=(UITextField *)[self.view viewWithTag:4];
    [textFild4 resignFirstResponder];
    
    
    if (!text0||[text0 isEqualToString:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"姓名不能为空" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;

    }else if (!text1||[text1 isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"公司名称不能为空" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;

    }else if (!text2||[text2 isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"职位不能为空" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;

    }else if (!text3||[text3 isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"邮箱不能为空" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;

    }else if (!text4||[text4 isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网址不能为空" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    } else if (![self validateEmail:text3]){
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入有效的邮箱地址" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;

    }else if (![self isValidateEmail:text3]){
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入有效的邮箱地址" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }

    
    
    HomeChooseIdentifyViewController *choose=[[HomeChooseIdentifyViewController alloc]init];
   
    NSUserDefaults *infoDefault = [NSUserDefaults standardUserDefaults];
    [infoDefault setObject:text0 forKey:@"name"];
    [infoDefault setObject:text1 forKey:@"company"];
    [infoDefault setObject:text2 forKey:@"compostion"];
    [infoDefault setObject:text3 forKey:@"email"];
    [infoDefault setObject:text4 forKey:@"url"];
    [infoDefault synchronize];
    
    
    [self.navigationController pushViewController:choose animated:NO];
    
}
//返回按钮
- (void) backButtonAction : (id) sender
{
    NSLog(@"--backButtonAction---");
    
    HomeVerifyViewController *verify=[[HomeVerifyViewController alloc]init];
    
    NSUserDefaults *infoDefault = [NSUserDefaults standardUserDefaults];
    [infoDefault setObject:text0 forKey:@"name"];
    [infoDefault setObject:text1 forKey:@"company"];
    [infoDefault setObject:text2 forKey:@"compostion"];
    [infoDefault setObject:text3 forKey:@"email"];
    [infoDefault setObject:text4 forKey:@"url"];
    [infoDefault synchronize];

    [self.navigationController pushViewController:verify animated:NO];
}
#pragma -mark -UITextfieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"----textFieldDidEndEditing---");
    if (textField.tag==0) {
        text0=textField.text;
    }else if (textField.tag==1){
        text1=textField.text;
    }else if (textField.tag==2){
        text2=textField.text;
    }else if (textField.tag==3){
        text3=textField.text;
    }else if (textField.tag==4){
        text4=textField.text;
    }
        
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"---textFieldShouldReturn----");
    [textField resignFirstResponder];
    return YES;
}
#pragma -mark -systemFunctions
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
