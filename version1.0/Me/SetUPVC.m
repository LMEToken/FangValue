//
//  SetUPVC.m
//  FangChuang
//
//  Created by weiping on 14-10-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "SetUPVC.h"

@interface SetUPVC ()

@end

@implementation SetUPVC

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
    [self setTitle:@"设置"];
    [self setTabBarHidden:YES];
    [self addBackButton];
    [self addTableView];
    // Do any additional setup after loading the view.
}
-(void)addTableView
{
    self.SetTablview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height) style:UITableViewStylePlain];
    [self.SetTablview setDelegate:self];
    [ self.SetTablview setDataSource:self];
    [self.contentView addSubview:self.SetTablview];
    
    [self.SetTablview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
return @"个人设置";
    
}
//设置中将手机号和检查更新去掉
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetUPCell *cell = [[SetUPCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = [NSArray arrayWithObjects:@"密码",@"震动",@"声音",@"检查更新",nil];
    [cell.rightlable setText:[arr objectAtIndex:indexPath.row]];
    
    /*
    if (indexPath.row ==0) {
        UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        myview.image = [UIImage imageNamed:@"celllin@2x"];
        [cell addSubview:myview];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(190, 20, 100, 20)];
        lable.textAlignment = UITextAlignmentRight;
        [lable setFont:[UIFont fontWithName:KUIFont size:10]];
        [lable setTextColor:[UIColor grayColor]];
        NSLog(@"---iphone--%@",[[UserInfo sharedManager] userphone]);
        lable.text = [[UserInfo sharedManager] userphone];
        [cell addSubview:lable];
        
    }*/
    if (indexPath.row==0) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(240, 15, 100, 15)];
        [lable setFont:[UIFont fontWithName:KUIFont size:10]];
        [lable setTextColor:[UIColor grayColor]];
        lable.text = @"修改密码 ";
        [cell addSubview:lable];
        
        UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(290,10, 10, 20)];
        imageview2.image = [UIImage imageNamed:@"accessory"];
        [cell addSubview:imageview2];
    }
    if (indexPath.row==1) {
        
        UISwitch *view = [[UISwitch alloc]initWithFrame:CGRectMake(240, 10, 60, 40)];
        
        [view addTarget:self action:@selector(changevoice:) forControlEvents:UIControlEventTouchUpInside];
        if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"GoToShake"] isEqualToString:@"0"]) {
            view.on = NO;
        }else
        {
            view.on = YES;
        }
        [cell addSubview:view];
    }
    if (indexPath.row==2) {
        
        UISwitch *view = [[UISwitch alloc]initWithFrame:CGRectMake(240, 10, 60, 40)];
        [view addTarget:self action:@selector(changevoice2:) forControlEvents:UIControlEventTouchUpInside];
        if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"GoToVoice"] isEqualToString:@"0"]) {
            view.on = NO;
        }else
        {
            view.on = YES;
        }
        [cell addSubview:view];
        [cell addSubview:view];
    }
    if (indexPath.row==3) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(210, 15, 100, 15)];
        [lable setFont:[UIFont fontWithName:KUIFont size:10]];
        [lable setTextColor:[UIColor grayColor]];
        lable.text = @"当前版本: 1.0.1";
        [cell addSubview:lable];
        UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(290,10, 10, 20)];
        imageview2.image = [UIImage imageNamed:@"accessory"];
        [cell addSubview:imageview2];
        
        UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height, self.view.frame.size.width, 1)];
        myview.image = [UIImage imageNamed:@"celllin@2x"];
        [cell addSubview:myview];
        
    }
    return cell;
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetUPCell *cell = [[SetUPCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    NSArray *arr = [NSArray arrayWithObjects:@"手机号",@"密码",@"震动",@"声音",@"检查更新" ,nil];
    [cell.rightlable setText:[arr objectAtIndex:indexPath.row]];

    if (indexPath.row ==0) {
        UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        myview.image = [UIImage imageNamed:@"celllin@2x"];
        [cell addSubview:myview];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(190, 20, 100, 20)];
        lable.textAlignment = UITextAlignmentRight;
      [lable setFont:[UIFont fontWithName:KUIFont size:10]];
        [lable setTextColor:[UIColor grayColor]];
        NSLog(@"---iphone--%@",[[UserInfo sharedManager] userphone]);
        lable.text = [[UserInfo sharedManager] userphone];
        [cell addSubview:lable];
        
    }
    if (indexPath.row==1) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(240, 15, 100, 15)];
        [lable setFont:[UIFont fontWithName:KUIFont size:10]];
        [lable setTextColor:[UIColor grayColor]];
        lable.text = @"修改密码 ";
        [cell addSubview:lable];
        
        UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(290,10, 10, 20)];
        imageview2.image = [UIImage imageNamed:@"accessory"];
        [cell addSubview:imageview2];
    }
    if (indexPath.row==2) {
        
        UISwitch *view = [[UISwitch alloc]initWithFrame:CGRectMake(240, 10, 60, 40)];

        [view addTarget:self action:@selector(changevoice:) forControlEvents:UIControlEventTouchUpInside];
        if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"GoToShake"] isEqualToString:@"0"]) {
            view.on = NO;
        }else
        {
             view.on = YES;
        }
        [cell addSubview:view];
    }
    if (indexPath.row==3) {
       
        UISwitch *view = [[UISwitch alloc]initWithFrame:CGRectMake(240, 10, 60, 40)];
        [view addTarget:self action:@selector(changevoice2:) forControlEvents:UIControlEventTouchUpInside];
        if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"GoToVoice"] isEqualToString:@"0"]) {
            view.on = NO;
        }else
        {
            view.on = YES;
        }
        [cell addSubview:view];
        [cell addSubview:view];
    }
    if (indexPath.row==4) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(210, 15, 100, 15)];
        [lable setFont:[UIFont fontWithName:KUIFont size:10]];
        [lable setTextColor:[UIColor grayColor]];
        lable.text = @"当前版本: 1.0.1";
        [cell addSubview:lable];
        UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(290,10, 10, 20)];
        imageview2.image = [UIImage imageNamed:@"accessory"];
        [cell addSubview:imageview2];
        
        UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height, self.view.frame.size.width, 1)];
        myview.image = [UIImage imageNamed:@"celllin@2x"];
        [cell addSubview:myview];
      
    }
    return cell;
    
}
 */
-(void)changevoice:(UISwitch *)view
{
    if(view.on == YES)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"GoToShake"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"GoToShake"];
        [[NSUserDefaults standardUserDefaults] synchronize];
     }
}
-(void)changevoice2:(UISwitch *)view
{
    if(view.on == YES)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"GoToVoice"];
    }else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"GoToVoice"];
    }
}
-(void)gotoview:(NSString *)userpwd
{
//    ChatWithFriendViewController *vc = [[ChatWithFriendViewController alloc]init];
    
    FavalueChangeVC *vc = [[FavalueChangeVC alloc]init];
    vc.userpwd=userpwd;
    [self.navigationController pushViewController:vc animated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 5 ;
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==3) {
        [self.view showActivityOnlyLabelWithOneMiao:@"当前版本为最新版本"];

    }

    if (indexPath.row==0) {
        self.stAlertView = [[STAlertView alloc] initWithTitle:@"验证密码"
                                                      message:nil
                                                textFieldHint:@"请输入你的密码"
                                          
                                               textFieldValue:nil
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确定"
                                            cancelButtonBlock:^{
                                            
                                            } otherButtonBlock:^(NSString * result){
                                           [[NetManager sharedManager]LoginWithusername:[[UserInfo sharedManager]username] password:result verificationcode:@"" hudDic:nil success:^(id sussceeful)
                                                {
                                               
                                                    
                                                    [self gotoview:result];
                                                    
                                                    
                                                }fail:^(id donwfurl)
                                                {
                                               
                                                NSString *str=@"登录失败，请检查您的用户名或密码是否填写正确。";
                                                    if ([donwfurl isEqualToString:str]) {
                                                        [self.view showActivityOnlyLabelWithOneMiao:@"验证失败。密码不正确"];
                                                    }else
                                                    {
                                                         [self.view showActivityOnlyLabelWithOneMiao:donwfurl];
                                                    }
                                            
                                                
                                                }];
                            
                                            }];

    }
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
