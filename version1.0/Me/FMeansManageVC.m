//
//  FMeansManageVC.m
//  FangChuang
//
//  Created by weiping on 14-10-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FMeansManageVC.h"
#import "Reachability.h"

@interface FMeansManageVC ()
{
    NSInteger state;
}
@end

@implementation FMeansManageVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"资料管理"];
    [self setTabBarHidden:YES];
    [self addBackButton];
    [self addTableView];
    [self addleftbtton];
  
    // Do any additional setup after loading the view.
}
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

-(void)addleftbtton
{
    UIButton *mybutton = [[UIButton alloc]initWithFrame:CGRectMake(260, 10, 70, 30)];
    [mybutton setTitle:@"编辑" forState:UIControlStateNormal];
    [mybutton addTarget:self action:@selector(updatedata:) forControlEvents:UIControlEventTouchDown];
    [mybutton.titleLabel setFont:[UIFont fontWithName:KUIFont size:15]];
    [self.navigationView addSubview:mybutton];
    
}
-(void)updatedata:(UIButton *)mybutton
{
    EditordieViewControllerF *vc= [[EditordieViewControllerF alloc]initWithText:[[UserInfo sharedManager] user_name]
                                                                           Text:[[UserInfo sharedManager] usergender]
                                                                           Text:[[UserInfo sharedManager] base]
                                                                           Text:[[UserInfo sharedManager] comname]
                                                                           Text:[[UserInfo sharedManager] post]
                                                                           Text:[[UserInfo sharedManager] useremail]
                                                                           Text:@""
                                                                           Text:@""
                                                                           Text:@""];
    
    [vc setDelegate:self];
    
    [self.navigationController pushViewController:vc animated:NO];

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

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeansManageCell *cell = [[MeansManageCell alloc]init];
    
    cell.lefttext.delegate = self;
    [cell.lefttext addTarget:self action:@selector( textFieldDidChange:) forControlEvents:  UIControlEventEditingDidBegin  ];
    if (state==0) {
        textcolor =[UIColor grayColor];
        cell.userInteractionEnabled = NO;
    }else
    {
        cell.userInteractionEnabled = YES;
        textcolor =[UIColor blackColor];
       

    }
    NSArray *arr = [NSArray arrayWithObjects:@"头像",@"真实姓名",@"性别",@"所在地",@"公司",@"职位" ,@"邮箱",nil];
    [cell.rightlable setText:[arr objectAtIndex:indexPath.row]];
    if (indexPath.row==0) {
        cell.lefttext.hidden = YES;
        cell.imageline.frame = CGRectMake(15, 70, 290, 1);
        
        
        heradimage = [[UIImageView alloc]initWithFrame:CGRectMake(250, 10,50 , 50)];
        heradimage.layer.cornerRadius = 10;//设置那个圆角的有多圆
        heradimage.layer.borderWidth = .1;//设置边框的宽度，当然可以不要
        heradimage.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
        heradimage.layer.masksToBounds = YES;
        [heradimage  setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
        [cell addSubview:heradimage];
        cell.userInteractionEnabled = YES;
        
        
        
        UIButton *headButton=[[UIButton alloc]init];
        headButton.frame=CGRectMake(250, 10,50 , 50);
        headButton.backgroundColor=[UIColor clearColor];
        [headButton addTarget:self action:@selector(doClickHeadAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:headButton];
    
        
    }
    if (indexPath.row==1) {
        [cell.lefttext setTextColor:[UIColor grayColor]];
        cell.lefttext.userInteractionEnabled=NO;
        [cell.lefttext setText: [[UserInfo sharedManager] user_name]];
    
       
    }
    if (indexPath.row==2) {
        [cell.lefttext setTextColor:[UIColor grayColor]];
        cell.lefttext.userInteractionEnabled=NO;
        NSLog(@"--gender-%@",[[UserInfo sharedManager] usergender]);
        
        if ([[[UserInfo sharedManager] usergender]isEqualToString:@"f"]) {
             [cell.lefttext setText:@"女"];
        }else if  ([[[UserInfo sharedManager] usergender]isEqualToString:@"m"]) {
              [cell.lefttext setText:@"男"];
        }else
        {
              [cell.lefttext setText:[[UserInfo sharedManager] usergender]];
        }
        
       

        
//        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(295, 10, 10, 20)];
//        imageview.image = [UIImage imageNamed:@"accessory"];
//        [cell addSubview:imageview];
    }
    if (indexPath.row==3) {
        [cell.lefttext setTextColor:[UIColor grayColor]];
        cell.lefttext.userInteractionEnabled=NO;
        [cell.lefttext setText:[[UserInfo sharedManager] base]];
    }
    if (indexPath.row==4) {
        [cell.lefttext setTextColor:[UIColor grayColor]];
        cell.lefttext.userInteractionEnabled=NO;
        NSLog(@"comname--%@",[[UserInfo sharedManager] comname]);
        [cell.lefttext setText:[[UserInfo sharedManager] comname]];
    }
    if (indexPath.row==5) {

        [cell.lefttext setTextColor:[UIColor grayColor]];
        cell.lefttext.userInteractionEnabled=NO;
        [cell.lefttext setText:[[UserInfo sharedManager] post]];
    }
    if (indexPath.row==6) {

        [cell.lefttext setTextColor:[UIColor grayColor]];
        cell.lefttext.userInteractionEnabled=NO;
        [cell.lefttext setText:[[UserInfo sharedManager] useremail]];
        
      UIImageView  *imageline = [[UIImageView alloc]initWithFrame:CGRectMake(15, 50, 290, 1)];
        imageline.image = [UIImage imageNamed:@"celllin@2x"];
        [cell addSubview:imageline];
    }
       cell.lefttext.textColor = [UIColor blackColor];
 
    return cell;
    
}
- (void) textFieldDidChange:(UITextField *) TextField{
    [TextField setText:@""];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 70;
    }

    return 50;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     return @"基本资料";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 35;
    }
    return 0;
}
#pragma -mark -doClickActions
- (void)backButtonAction:(UIButton*)sender
{
    FvaMyVC *tMeans=[[FvaMyVC alloc]init];
    [self.navigationController pushViewController:tMeans animated:NO];
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
