//
//  FavalueChangeVC.m
//  FangChuang
//
//  Created by Tom on 14-11-22.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FavalueChangeVC.h"

@interface FavalueChangeVC ()

@end

@implementation FavalueChangeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - tom 提示按钮 点击的效果
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        if (alertView.tag==2) {
             [Utils changeViewControllerWithTabbarIndex:4];
        }
    
    }
    
}
-(void)changepwd
{
  
    //看剩下的字符串的长度是否为零

    if ([nameTextField.text rangeOfString:@" "].length>0 ) {
        UIAlertView *myalertview = [[UIAlertView alloc]initWithTitle:@"密码不能含有空格" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        myalertview.tag=1;
        [myalertview show];
       
    }else
    if ([nameTextField.text isEqualToString:nameTextField2.text]) {
        [[NetManager sharedManager]changePasswordWithUsername:[[UserInfo sharedManager]username] oldpassword:self.userpwd newpassword:nameTextField.text  hudDic:nil success:^(id responseDic) {
            UIAlertView *myalertview = [[UIAlertView alloc]initWithTitle:@"修改成功" message:@"由于修改密码您需要重新登录" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            myalertview.tag=2;
            [myalertview show];
 
        } fail:^(id errorString) {
            
            if ([nameTextField.text isEqualToString: @""]) {
                UIAlertView *myalertview = [[UIAlertView alloc]initWithTitle:@"密码不能为空" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                myalertview.tag=1;
                [myalertview show];
            }else
            {
            [self.view showActivityOnlyLabelWithOneMiao:errorString];
            }
        }];
    }else
    {
        [self.view showActivityOnlyLabelWithOneMiao:@"确认密码与新密码不一致"];
    }
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self setTitle:@"修改密码"];
    [self setTabBarHidden:YES];
    //名字textField
    UIView  *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 40)];
    myview.backgroundColor = [UIColor whiteColor];
   nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, self.view.bounds.size.width-10, 40)];
    [nameTextField setBorderStyle:UITextBorderStyleNone];
    [nameTextField setFont:[UIFont fontWithName:KUIFont size:14]];
    [nameTextField setPlaceholder:@"请输入新密码"];
    nameTextField.backgroundColor=[UIColor whiteColor];
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nameTextField.secureTextEntry = YES;
    [nameTextField setDelegate:self];
    
    [self.contentView addSubview:myview];
    [self.contentView addSubview:nameTextField];
    
    UIView  *myview2 = [[UIView alloc]initWithFrame:CGRectMake(0, 90, self.view.bounds.size.width, 40)];
    myview2.backgroundColor = [UIColor whiteColor];
   nameTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 90, self.view.bounds.size.width-10, 40)];
    [nameTextField2 setBorderStyle:UITextBorderStyleNone];
    [nameTextField2 setFont:[UIFont fontWithName:KUIFont size:14]];
    [nameTextField2 setPlaceholder:@"请再次输入新密码"];
    nameTextField2.backgroundColor=[UIColor whiteColor];
    nameTextField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nameTextField2.secureTextEntry = YES;
    [nameTextField2 setDelegate:self];
    
    [self.contentView addSubview:myview2];
    [self.contentView addSubview:nameTextField2];
    
    
    UIButton *changebtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 150, self.view.bounds.size.width-60, 35)];
    [changebtn setImage:[UIImage imageNamed:@"changepwd"] forState:UIControlStateNormal];
    [changebtn addTarget:self action:@selector(changepwd) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:changebtn];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
