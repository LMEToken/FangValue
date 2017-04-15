//
//  FMeansManageVC.m
//  FangChuang
//
//  Created by weiping on 14-10-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "TMeansManageVC.h"
#import "Reachability.h"
#import "TGRImageViewController.h"

#import "FvaMyVC.h"

@interface TMeansManageVC ()
{
    NSInteger state;
}
@end

@implementation TMeansManageVC

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
    [self setTitle:@"资料管理"];
    [self setTabBarHidden:YES];
    [self addBackButton];
    [self addTableView];
    [self addleftbtton];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    

    // Do any additional setup after loading the view.
}

-(void)addleftbtton
{
    leftbtton = [[UIButton alloc]initWithFrame:CGRectMake(250, 10, 70, 30)];
    [leftbtton setTitle:@"编辑" forState:UIControlStateNormal];
    [leftbtton addTarget:self action:@selector(updatedata:) forControlEvents:UIControlEventTouchDown];
    [leftbtton.titleLabel setFont:[UIFont fontWithName:KUIFont size:15]];
    [self.navigationView addSubview:leftbtton];
    
}
# pragma mark 左按钮点击事件

-(void)doClickHeadAction:(UIButton *)btn
{
    if ([self isConnectionAvailable]) {
        
        TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:heradimage.image];
        viewController.transitioningDelegate = self;
        [self presentViewController:viewController animated:NO completion:nil];
        
    }else{
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网络已断开，请稍后重试" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
}

-(void)updatedata:(UIButton *)mybutton
{
//    if ([mybutton.titleLabel.text isEqualToString: @"确定"]) {
//        [mybutton setTitle:@"编辑" forState:UIControlStateNormal];
//        state=0;
//            [self.SetTablview reloadData];
//    }else   if ([mybutton.titleLabel.text isEqualToString: @"隐藏键盘"])
//    {
//
//  
//        [textview resignFirstResponder];
//
//         [mybutton setTitle:@"确定" forState:UIControlStateNormal];
//    }
//    else
//    {
//        [mybutton setTitle:@"确定" forState:UIControlStateNormal];
//        state=1;
//            [self.SetTablview reloadData];
//    }
    EditordieViewController *view=[[EditordieViewController alloc]initWithText:[[UserInfo sharedManager] user_name]
                                                                          Text:[[UserInfo sharedManager] usergender]
                                                                          Text: [[UserInfo sharedManager] useremail]
                                                                          Text: [[UserInfo sharedManager] useremail]
                                                                          Text: [[UserInfo sharedManager] useremail]
                                                                          Text: [[UserInfo sharedManager] useremail]
                                                                          Text: [[UserInfo sharedManager] useremail]
                                                                          Text: [[UserInfo sharedManager] useremail]
                                                                          Text: [[UserInfo sharedManager] useremail]];
    
    [view setDelegate:self];
  
    [self.navigationController pushViewController:view animated:NO];

    
}

-(void)addTableView
{
    self.SetTablview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height) style:UITableViewStylePlain];
    [self.SetTablview setDelegate:self];
    [ self.SetTablview setDataSource:self];
//    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom)];
//    panRecognizer.maximumNumberOfTouches = 1;
//    [self.SetTablview addGestureRecognizer:panRecognizer];//关键语句，给self.view添加一个手势监测；
 
   

    [self.contentView addSubview:self.SetTablview];
    [self.SetTablview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    MeansManageCell *cell = [[MeansManageCell alloc]init];
    cell.lefttext.delegate = self;
   
    
    if (state==0) {
        textcolor =[UIColor grayColor];
        cell.userInteractionEnabled = NO;
    }else
    {
        cell.userInteractionEnabled = YES;
        textcolor =[UIColor blackColor];
    }
    if (indexPath.row==0) {
           cell.imageline.hidden = YES;
    }
    if (indexPath.section==0) {
        indexsesion=0;
        NSArray *arr = [NSArray arrayWithObjects:@"头像",@"真实姓名",@"性别",@"所在地",@"公司",@"职位" ,@"邮箱",nil];
        if (indexPath.row==0) {
//            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(295, 20, 10, 20)];
//            imageview.image = [UIImage imageNamed:@"accessory"];
//            [cell addSubview:imageview];
            cell.lefttext.hidden = YES;
            
            
            heradimage = [[UIImageView alloc]initWithFrame:CGRectMake(250, 10,50 , 50)];
            heradimage.layer.cornerRadius = 10;//设置那个圆角的有多圆
            heradimage.layer.borderWidth = .1;//设置边框的宽度，当然可以不要
            heradimage.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
            heradimage.layer.masksToBounds = YES;
            [heradimage  setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
            [cell addSubview:heradimage];
            cell.userInteractionEnabled=YES;
            
            
            
            UIButton *headButton=[[UIButton alloc]init];
            headButton.frame=heradimage.frame;
            headButton.backgroundColor=[UIColor clearColor];
            [headButton addTarget:self action:@selector(doClickHeadAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:headButton];
            
        }
        if (indexPath.row==1) {
            indexrow=1;
            [cell.lefttext setTextColor:[UIColor grayColor]];
            cell.lefttext.userInteractionEnabled=NO;
            [cell.lefttext setText: [[UserInfo sharedManager] user_name]];
        }

        if (indexPath.row==2) {
            indexrow=2;
            sex = [[UITextField alloc]initWithFrame:CGRectMake(200, 10, 100, 30)];
            sex.textAlignment = NSTextAlignmentRight;
            [sex setFont:[UIFont fontWithName:KUIFont size:13]];
            
            if ([[[UserInfo sharedManager] usergender]isEqualToString:@"f"]) {
                 sex.text=@"女";
            }else if  ([[[UserInfo sharedManager] usergender]isEqualToString:@"m"]) {
                sex.text=@"男";
            }else
            {
               sex.text = [[UserInfo sharedManager] usergender];
            }

          //  sex.text = [[UserInfo sharedManager] usergender];
            [sex setTextColor:textcolor];
         
            [cell addSubview:sex];
//            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(295, 10, 10, 20)];
//            imageview.image = [UIImage imageNamed:@"accessory"];
//            [cell addSubview:imageview];
        }
        if (indexPath.row==3) {
            indexrow=3;
            address = [[UITextField alloc]initWithFrame:CGRectMake(200, 10, 100, 30)];
            address.textAlignment = NSTextAlignmentRight;
            [address setFont:[UIFont fontWithName:KUIFont size:13]];
            address.text = [[UserInfo sharedManager] base];
            address.delegate=self;
               [ address addTarget:self action:@selector(textFieldDidChange2:) forControlEvents:  UIControlEventEditingDidBegin  ];
            [address setTextColor:textcolor];
            [cell addSubview:address];
        }
        if (indexPath.row==4) {
            indexrow=4;
            company = [[UITextField alloc]initWithFrame:CGRectMake(200, 10, 100, 30)];
            company.textAlignment = NSTextAlignmentRight;
            [company setFont:[UIFont fontWithName:KUIFont size:13]];
            company.delegate=self;
            NSLog(@"--gongsi---%@",[[UserInfo sharedManager]comname]);
            company.text = [[UserInfo sharedManager]comname];
            NSLog(@"%@",company.text);
            [ company addTarget:self action:@selector(textFieldDidChange2:) forControlEvents:  UIControlEventEditingDidBegin  ];
            [company setTextColor:textcolor];
            [cell addSubview:company];
        }
        if (indexPath.row==5) {
            indexrow=5;
            position = [[UITextField alloc]initWithFrame:CGRectMake(200, 10, 100, 30)];
            position.textAlignment = NSTextAlignmentRight;
            [position setFont:[UIFont fontWithName:KUIFont size:13]];
            position.delegate=self;
            position.text =[[UserInfo sharedManager] post];
            //@"软件工程师";
            
                  [ position addTarget:self action:@selector(textFieldDidChange2:) forControlEvents:  UIControlEventEditingDidBegin  ];
            [position setTextColor:textcolor];
            [cell addSubview:position];
        }
        if (indexPath.row==6) {
            indexrow=6;
            email= [[UITextField alloc]initWithFrame:CGRectMake(200, 10, 100, 30)];
            [email setFont:[UIFont fontWithName:KUIFont size:13]];
            email.textAlignment = NSTextAlignmentRight;
            email.text = [[UserInfo sharedManager] useremail];
             [email addTarget:self action:@selector(textFieldDidChange2:) forControlEvents:  UIControlEventEditingDidBegin  ];
            email.delegate=self;
            [email setTextColor:textcolor];
            [cell addSubview:email];
        }
        
        [cell.rightlable setText:[arr objectAtIndex:indexPath.row]];
    }
    if (indexPath.section==1) {
        indexsesion=1;
        NSArray *arr;
        if ([[[UserInfo sharedManager] usertype]isEqualToString:@"1"]) {
        arr = [NSArray arrayWithObjects:@"基金币种",@"偏好额度",@"投资轮次",@"关注领域",nil];
        }else
        {
         arr =[NSArray arrayWithObjects:@"所属领域",@"阶段",@"团队规模",@"融资状态",nil];
        }

//
        [cell.rightlable setText:[arr objectAtIndex:indexPath.row]];
        if (indexPath.row==0) {
            indexrow=0;
            fundtype= [[UITextField alloc]initWithFrame:CGRectMake(190, 10, 110, 30)];
            [fundtype setFont:[UIFont fontWithName:KUIFont size:13]];
            fundtype.textAlignment = NSTextAlignmentRight;
           // fundtype.text = [[UserInfo sharedManager] lingyu];
            
            NSLog(@"-lingyu--%@--",[[UserInfo sharedManager] lingyu]);
            if (![[UserInfo sharedManager] lingyu]) {
                fundtype.text=@"必选";
            }else{
                if ([[[UserInfo sharedManager] lingyu] isEqualToString:@""]) {
                    fundtype.text=@"必选";
                }else{
                   fundtype.text = [[UserInfo sharedManager] lingyu];
                    
                }
            }

            [fundtype addTarget:self action:@selector(textFieldDidChange2:) forControlEvents:  UIControlEventEditingDidBegin  ];
            fundtype.delegate=self;
            [fundtype setTextColor:textcolor];
            [cell addSubview:fundtype];
        }
        if (indexPath.row==1) {
            indexrow=1;
            likenum= [[UITextField alloc]initWithFrame:CGRectMake(190, 10, 110, 30)];
            likenum.textAlignment = NSTextAlignmentRight;
            [likenum setFont:[UIFont fontWithName:KUIFont size:13]];
          // likenum.text = [[UserInfo sharedManager] jieduan];
            
            NSLog(@"-jieduan--%@--", [[UserInfo sharedManager] jieduan]);
            if (! [[UserInfo sharedManager] jieduan]) {
                likenum.text=@"必选";
            }else{
                if ([ [[UserInfo sharedManager] jieduan] isEqualToString:@""]) {
                    likenum.text=@"必选";
                }else{
                    likenum.text =  [[UserInfo sharedManager] jieduan];
                    
                }
            }

            [likenum addTarget:self action:@selector(textFieldDidChange2:) forControlEvents:  UIControlEventEditingDidBegin  ];
            [likenum setTextColor:textcolor];
          
            likenum.delegate=self;
            [cell addSubview:likenum];
        }
        if (indexPath.row==2) {
           invest= [[UITextField alloc]initWithFrame:CGRectMake(190, 10, 110, 30)];
            indexrow=2;
            [invest setFont:[UIFont fontWithName:KUIFont size:13]];
          // invest.text = [[UserInfo sharedManager] guimo];
            
            NSLog(@"-guimo--%@--",[[UserInfo sharedManager] guimo]);
            if (![[UserInfo sharedManager] guimo]) {
                invest.text=@"必选";
            }else{
                if ([[[UserInfo sharedManager] guimo] isEqualToString:@""]) {
                    invest.text=@"必选";
                }else{
                    invest.text = [[UserInfo sharedManager] guimo];
                    
                }
            }

            [invest addTarget:self action:@selector(textFieldDidChange2:) forControlEvents:  UIControlEventEditingDidBegin  ];
            [invest setTextColor:textcolor];
            invest.textAlignment = NSTextAlignmentRight;
            invest.delegate=self;
            [cell addSubview:invest];
        }
        if (indexPath.row==3) {
                 indexrow=0;
            indexsesion=3;
            field= [[UITextField alloc]initWithFrame:CGRectMake(190, 10, 110, 30)];
       
            field.textAlignment = NSTextAlignmentRight;
            [field setFont:[UIFont fontWithName:KUIFont size:13]];
            /*
            if ( ![[UserInfo sharedManager] rongzi]==nil) {
                field.text=@"";
            }else
            {
                 field.text = [[UserInfo sharedManager] rongzi];
            }
             */
            NSLog(@"-rongzi--%@--",[[UserInfo sharedManager] rongzi]);
            if (![[UserInfo sharedManager] rongzi]) {
                field.text=@"必选";
            }else{
                if ([[[UserInfo sharedManager] rongzi] isEqualToString:@""]) {
                    field.text=@"必选";
                }else{
                    field.text = [[UserInfo sharedManager] rongzi];

                }
            }
            
            
           
            [field addTarget:self action:@selector(textFieldDidChange2:) forControlEvents:  UIControlEventEditingDidBegin  ];
            [field setTextColor:textcolor];
            field.delegate=self;
            [cell addSubview:field];
        }

    }
    
    if (indexPath.section==2) {
        indexsesion=2;
        cell.imageline.hidden = YES;
        textview = [[UITextView alloc]initWithFrame:CGRectMake(20, 5, 280, 80)];
        textview.delegate=self;
        textview.text =[[UserInfo sharedManager] gongsijianjie];
        [textview setFont:[UIFont fontWithName:KUIFont size:10]];
        textview.textColor = textcolor;
        textview.backgroundColor=[UIColor clearColor];
        textview.editable=NO;
        cell.userInteractionEnabled=YES;
        [cell addSubview:textview];
    }
    
    return cell;
    
}

#pragma mark 键盘消失
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.SetTablview reloadData];
    return YES;
}
//- (void)talkResign:(UITapGestureRecognizer*)tap
//{
//  
//}
#pragma mark 键盘出现
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
//    [leftbtton setTitle:@"隐藏键盘" forState:UIControlStateNormal];
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize size = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSLog(@"%f",size.height);
    //[_tabelView setFrame:CGRectMake(0, 0, 320, screenHeight-size.height-navigationHeight-50)];
    [self.SetTablview setFrame:CGRectMake(0, 0, 320,self.SetTablview.frame.size.height-size.height )];
       [UIView commitAnimations];
    [self.SetTablview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexrow inSection:indexsesion] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}
#pragma mark 键盘隐藏
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.SetTablview setFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height)];
}
- (void) textFieldDidChange2:(UITextField *) TextField{

    [TextField setText:@""];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 7;
    }
    if (section==1) {
        return 4;
    }
    return 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0&&indexPath.section==0) {
        return 70;
    }
    if (indexPath.section==2) {
        return 120;
    }
    return 50;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
         return @"基本资料";
    }
    if (section==1) {
        return @"机构信息";
    }
    return @"公司简介";
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section==0) {
//        return 35;
//    }
    return 35;
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
#pragma -mark -funcitons
-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    return isExistenceNetwork;
}
#pragma -mark -UITabelViewDelegate
/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0) {
            if ([self isConnectionAvailable]) {
                
                TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:heradimage.image];
                viewController.transitioningDelegate = self;
                
                [self presentViewController:viewController animated:NO completion:nil];
                
            }else{
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网络已断开，请稍后重试" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }

        }
    }
}
 */
#pragma -mark -doClickActions
- (void)backButtonAction:(UIButton*)sender
{
    FvaMyVC *my=[[FvaMyVC alloc]init];
    [self.navigationController pushViewController:my animated:NO];
}

@end
