//
//  PersonalDataVC.m
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//方创人详细资料

#import "FvaluePeopleData.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"

@interface FvaluePeopleData ()

@end

@implementation FvaluePeopleData

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
    [self setTitle:@"方创人详细资料"];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self addTableview];
    self.contentView.backgroundColor = [UIColor whiteColor];
    if (![[[UserInfo sharedManager] username]isEqualToString:[self.peopledic objectForKey:@"username"]]) {
         [self addfriedview];
        
    }
   
    NSLog(@"%@",self.peopleid);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addfriedview
{
    //    NSLog(@"%f",self.contentView.frame.size.height);
    UIView *downview = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height-50, 320, 50)];
    downview.backgroundColor = [UIColor whiteColor];
    UIButton *addbt = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 300, 35)];
    [addbt setBackgroundImage:[UIImage imageNamed:@"sendmsg"] forState:UIControlStateNormal ];
    //加好友
//    [addbt setBackgroundImage:[UIImage imageNamed:@"addfired"] forState:UIControlStateNormal ];
    [addbt addTarget:self action:@selector(addfrieds) forControlEvents: UIControlEventTouchDown];
    [downview addSubview:addbt];
    [self.contentView addSubview:downview];
    
}
- (void)addfrieds
{
    
 
      [[NSUserDefaults standardUserDefaults] setObject:[self.peopledic objectForKey:@"username"] forKey:@"lianxiren"];
      [[NSUserDefaults standardUserDefaults] synchronize];
      [Utils changeViewControllerWithTabbarIndex:5];

}
- (void)addTableview
{
    self.PersonTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height-50) style:UITableViewStylePlain];
    //UITableViewStylePlain];
    [self.PersonTableview setDelegate:self];
    [ self.PersonTableview setDataSource:self];
    [self.contentView addSubview:self.PersonTableview];
    
    tableArray = [[NSMutableArray alloc]init];
    //为表单数组添加元素
    [tableArray addObject:[self newSectionArr:0 andRow:1]];
    [tableArray addObject:[self newSectionArr:1 andRow:3]];
    [tableArray addObject:[self newSectionArr:2 andRow:2]];
}
//定义这是第几块，块里面有多少行，数组里面保存行的内容
- (NSMutableArray*)newSectionArr:(NSInteger)section andRow:(NSInteger)row
{
    NSMutableArray *sectionArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < row; i ++) {
        [sectionArr addObject:[NSString stringWithFormat:@"Section:%ld,Row:%ld",(long)section,(long)i]];
    }
    return sectionArr;
}
#pragma mark - TableVIewDelegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[tableArray objectAtIndex:section] count];
}
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 &&indexPath.section==0) {
        
        
        if ([self isConnectionAvailable]) {
            
            TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:herdimage.image];
            viewController.transitioningDelegate = self;
            
            [self presentViewController:viewController animated:NO completion:nil];

            
        }else{
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网络已断开，请稍后重试" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }

   }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *seectionarr = [NSArray arrayWithObjects:@"签名",@"公司",@"职位",nil];
    NSArray * seection3arr=[NSArray arrayWithObjects:@"手机号",@"邮箱", nil];
// [NSArray arrayWithObjects:@"阶段",@"团队规模",@"融资状态",@"所属领域",@"公司介绍",nil];
    
    PresonlabelCell *cell = [[PresonlabelCell alloc]init];
    
    UILabel *rightlable= [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 70, 30)];
    [rightlable  setFont:[UIFont fontWithName:KUIFont size:12]];
   [cell addSubview:rightlable ];
    
    UILabel *leftlable= [[UILabel alloc]initWithFrame:CGRectMake(190, 10, 110, 30)];
    leftlable.textAlignment = NSTextAlignmentRight;
    [leftlable  setFont:[UIFont fontWithName:KUIFont size:12]];
   [cell addSubview:leftlable];
    
    NSLog(@"%@",self.peopledic);
    if (indexPath.row==0&&indexPath.section==0) {
        leftlable.hidden = YES;
        
        rightlable.hidden = YES;
        herdimage = [[UIImageView alloc]initWithFrame:CGRectMake(20  , 10, 60 , 60)];
        
        NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
        
        NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",[self.peopledic objectForKey:@"username"],   [[UserInfo sharedManager]username]]];
        if ([[self.peopledic objectForKey:@"username"] isEqualToString:[[UserInfo sharedManager] username]]) {
            [herdimage setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
        }else
        {
            [herdimage setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
        }

//        [herdimage setImageWithURL:[NSURL URLWithString:[self.peopledic objectForKey:@"picurl2"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
        herdimage.layer.cornerRadius = 10;//设置那个圆角的有多圆
        herdimage.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
        herdimage.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
        herdimage.layer.masksToBounds = YES;
        
        [cell addSubview:herdimage];
        
        UILabel *heradlable = [[UILabel alloc]initWithFrame:CGRectMake(100  , 10, 60 , 60)];
        if (![self isBlankString:[self.peopledic objectForKey:@"username"]]) {
            heradlable.text =[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"relname%@",[self.peopledic objectForKey:@"username"]]];
            
            //[self.peopledic objectForKey:@"username"];
            [cell addSubview:heradlable];
        }

        
    }
    if (indexPath.section==1) {
        rightlable.text = [seectionarr objectAtIndex:indexPath.row];
        if (indexPath.row==0) {
            if (![self isBlankString:[self.peopledic objectForKey:@"username"]]) {
                
               // leftlable.text=[self.peopledic objectForKey:@"username"];
               // leftlable.text=[[UserInfo sharedManager] user_name];
                if ([[self.peopledic objectForKey:@"username"]isEqualToString:[[UserInfo sharedManager] username]]) {
                    leftlable.text=[[UserInfo sharedManager] user_name];
                }else{
                    leftlable.text=[self.peopledic objectForKey:@"username"];
                }
            }
            
        }else if (indexPath.row==1)
        {
            if (![self isBlankString:[self.peopledic objectForKey:@"comname"]]) {
                 leftlable.text=[self.peopledic objectForKey:@"comname"];
            }
            
        }else
        {
            if (![self isBlankString:[self.peopledic objectForKey:@"cv"]]) {
                 leftlable.text=[self.peopledic objectForKey:@"cv"];
            }
            
        }
       

    }
    if (indexPath.section==2) {
        rightlable.text = [seection3arr objectAtIndex:indexPath.row];
        if (indexPath.row==0) {
            if (![self isBlankString:[self.peopledic objectForKey:@"mobile"]]) {
                leftlable.text=[self.peopledic objectForKey:@"mobile"];
            }
          
        }else
        {
            if (![self isBlankString:[self.peopledic objectForKey:@"email"]]) {
                leftlable.text=[self.peopledic objectForKey:@"email"];
            }
           
        }
       
    }

   return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return @"个人资料";
    }
    if (section==2) {
        return @"机构信息";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==2&&indexPath.row==4) {
        return 130;
    }
    if (indexPath.section ==0) {
        return 80;
    }
    
    return 50;
}
#pragma -mark -functions
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


@end
