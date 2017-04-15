//
//  ShowBox.m
//  RongYi
//
//  Created by BlueMobi BlueMobi on 13-6-26.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "ShowBox.h"
#import "LoginViewController.h"
#import "UserInfo.h"
@implementation ShowBox


+(void)showError:(NSString *)content
{

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];

}

+(void)showSuccess:(NSString *)content

{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];

}

+(void)showCollectSuccess:(NSString *)content controller:(UIViewController *) controller
{
//    1.UIAlertView *theAlert = [[[UIAlertView alloc] initWithTitle:@"Atention" message:@"我是中国人！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] autorelease];
//    2 UIImage *alertImage = [UIImage imageNamed:@"loveChina.png"];
//    3 UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:alertImage];
//    4 backgroundImageView.frame = CGRectMake(0, 0, 282, 160);
//    5 backgroundImageView.contentMode = UIViewContentModeScaleToFill;
//    6 [theAlert addSubview:backgroundImageView];
//    7 [theAlert sendSubviewToBack:backgroundImageView];
//    8
//    9 [theAlert show];
//    10 [theAlert release];
    
    

}



+(BOOL)alertTextNull:(NSString *)text message:(NSString *)message
{//为空返回yes
    NSLog(@"%d",text.length);
    if (text.length==0||!text||[text isKindOfClass:[NSNull class]]||[text isEqual:@"(null)"]) {
        if (message) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"错误提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
       
        
        return YES;
    }
    else
        return NO;

}
 
 
+(BOOL)alertEmail:(NSString *)Email require:(BOOL)require
{
    
    if (Email.length==0) {
        if (require) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写邮箱！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
             return YES;
        }
       else
       {
       
           return NO;
       }
    }
    else
    {
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:Email options:0 range:NSMakeRange(0, [Email length])];
        if(numberOfMatches !=1 ){ 
                
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"邮箱格式不正确"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                
                [alert show];
                [alert release]; 
            return YES;
        }
        else
            return NO;

        
       
    }
    
    
}



+(BOOL)alertPhoneNo:(NSString *)phoneNo
{

    if (phoneNo.length==0) {
       
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写手机号码！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
             
        return YES;
    }
    else
    {
        NSRegularExpression *phone = [NSRegularExpression regularExpressionWithPattern:@"\\b(1)[3458][0-9]{9}\\b" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger phoneMatches = [phone numberOfMatchesInString:phoneNo options:0 range:NSMakeRange(0, [phoneNo length])];
        if(phoneMatches !=1){
            
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请确认手机号码是否输入正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            [alert release];
            return YES;
            
        }
        else
            return NO;
        
    }

    
}


+(BOOL)alertPhoneNo:(NSString *)phoneNo require:(BOOL)require
{
    
    if (phoneNo.length==0) {
        if (require) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写手机号码！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
            
            return YES;
        }
        else
            return NO;
        
    }
    else
    { 
        NSRegularExpression *phone = [NSRegularExpression regularExpressionWithPattern:@"\\b(1)[3458][0-9]{9}\\b" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger phoneMatches = [phone numberOfMatchesInString:phoneNo options:0 range:NSMakeRange(0, [phoneNo length])];
        if(phoneMatches !=1){
            
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请确认手机号码是否输入正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            [alert release];
            return YES;
            
        }
        else
            return NO;

    }
    
}


+(BOOL)alertNoLogin
{
   
    
    
    if (![[UserInfo sharedManager] islogin]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您未登录，请先登陆,否则该功能将不可用！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        
        
        
        return YES;
    }
    else
        return NO;
    
}

+(BOOL)alertNoLoginWithPush:(UIViewController *) view
{ 
   
    
    UserInfo *user=[UserInfo sharedManager];
    if (!user.islogin) {

        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录后使用！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        LoginViewController *login=[[LoginViewController alloc]init];
        [view.navigationController pushViewController:login animated:YES];
        [login release];
        
        
        return YES;
    }
    else
        return NO;
    
}






+(BOOL)alertCardNo:(NSString *)cardNo require:(BOOL)require
{
    if (cardNo.length==0||!cardNo||[cardNo isKindOfClass:[NSNull class]]) {
    
    
        if (require) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写会员卡号！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];

            
            return YES;
           
        }
        else
            return NO;
        
    }
    else{
    
        NSRegularExpression *CardNo = [NSRegularExpression regularExpressionWithPattern:@"\\b[0-9]{8}\\b" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger CardNoMatches = [CardNo numberOfMatchesInString:cardNo options:0 range:NSMakeRange(0, [cardNo length])];
        if(CardNoMatches !=1){
            
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"有非法字符或卡号不是8位数字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            [alert release];
            return YES;
            
        }
        else
            return NO;

        
    }
    
}


 




+(BOOL)alertLoginName:(NSString *)loginName require:(BOOL)require
{
    if (loginName.length==0||!loginName||[loginName isKindOfClass:[NSNull class]]) {
        
        
        if (require) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写登录名！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
            
            return YES;
            
        }
        else
            return NO;
        
    }
    else{
         
        NSRegularExpression *CardNo = [NSRegularExpression regularExpressionWithPattern:@"\\b[a-zA-Z0-9_]{2,15}\\b" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger CardNoMatches = [CardNo numberOfMatchesInString:loginName options:0 range:NSMakeRange(0, [loginName length])];
        NSLog(@"111==%d",CardNoMatches);
        if(CardNoMatches !=1){
            
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录名中含有非法字符，登录名只能由2-15位数字，字母，下划线组成" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            [alert release];
            return YES;
            
        }
        else
            return NO;
        
        
    }
    
}


+(BOOL)alertPassWord:(NSString *)password
{
    
    
    if (password.length==0||!password||[password isKindOfClass:[NSNull class]]) {
        
        
         
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写密码！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return YES;
            
        }
      
    
    if (password.length>=6&&password.length<=20) {
        return NO;
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码必须由6-20的字母或数字组成" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        
        return YES;}


}


 +(void)showAll
{

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"当前已经是全部数据！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
}


@end
