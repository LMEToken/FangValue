//
//  FvaMyVC.m
//  FangChuang
//
//  Created by weiping on 14-9-23.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//我的页面
#import "FvaMyVC.h"
#import "LTBounceSheet.h"

#define color [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]
@interface FvaMyVC ()
@property(nonatomic,strong) LTBounceSheet *sheet;


@end

@implementation FvaMyVC

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
    
    [self setTitle:@"我"];
    
    [self addTableview];
    
    [self setTabBarIndex:3];

    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.sheet];
    // Do any additional setup after loading the view.
}
-(UIButton *) produceButtonWithTitle:(NSString*) title
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor= [UIColor whiteColor];
    button.layer.cornerRadius=23;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    return button;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addTableview
{
    self.MyTablview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height) style:UITableViewStylePlain];
    //UITableViewStylePlain];
    [self.MyTablview setDelegate:self];
    [ self.MyTablview setDataSource:self];
    
    /*
    UIImageView *herdimage = [UIImageView new];
    herdimage.frame= self.MyTablview.bounds;
    [herdimage  setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]
               placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
    //        herdimage.image = [UIImage imageNamed:@"PresonImage"];
    [herdimage setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [herdimage setContentMode:UIViewContentModeScaleAspectFill];
    */
    
    [self.contentView addSubview:self.MyTablview];
    
    [self.MyTablview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableArray = [[NSMutableArray alloc]init];
    //为表单数组添加元素
    [tableArray addObject:[self newSectionArr:0 andRow:1]];
    [tableArray addObject:[self newSectionArr:1 andRow:4]];
    [tableArray addObject:[self newSectionArr:2 andRow:1]];
    [tableArray addObject:[self newSectionArr:3 andRow:0]];

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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[tableArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FvaMecell *cell = [[FvaMecell alloc]init];
     NSArray *arr = [NSArray arrayWithObjects:@"资料管理",@"名片管理",@"关于方创",@"设置",@"登出", nil];
    if (indexPath.section==1) {
        if (indexPath.row==0) {
              cell.cellline.hidden = YES;
        }
//        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
       [cell.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"data%d",indexPath.row+1]]];
        [cell.leftlable setText:[arr objectAtIndex:indexPath.row]];
 
    }
    if (indexPath.section ==2) {
        if (indexPath.row==0) {
            cell.cellline.hidden = YES;
        }
        [cell.rightimage setImage:[UIImage imageNamed:@"data5"]];
         [cell.leftlable setText:[arr lastObject]];
    }

 
   
    if (indexPath.section==0) {
        if (indexPath.row==0) {
          /*
            UIImageView *herdimage = [[UIImageView alloc]initWithFrame:CGRectMake(0  , 0, self.view.bounds.size.width , 100)];
            herdimage.alpha=0.3;

//            [herdimage  setImage:[UIImage imageNamed:@"4buffer.jpg"]];
            //        herdimage.image = [UIImage imageNamed:@"PresonImage"];
            [cell addSubview:herdimage];
           */
//            
//            [self setBlurView:[AMBlurView new]];
//            [[self blurView] setFrame:cell.bounds];
//            [[self blurView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
//            [cell addSubview:[self blurView]];
           cell.cellline.hidden = YES;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        herdimage=[[UIImageView alloc]initWithFrame:CGRectMake(30  , 10, 70 , 70)];
        [herdimage setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
        //2014.05.13 chenlihua 暂时去掉圆角，好与微信做对比。
        [herdimage.layer setCornerRadius:10.0f];
        [herdimage.layer setMasksToBounds:YES];
        [cell addSubview:herdimage];
        
        
        UIButton *headButton=[[UIButton alloc]init];
        headButton.frame=herdimage.frame;
        headButton.backgroundColor=[UIColor clearColor];
        [headButton addTarget:self action:@selector(doClickHeadAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:headButton];
        
        
//        herdimage = [[UIImageView alloc]initWithFrame:CGRectMake(30  , 10, 70 , 70)];
//        herdimage.layer.cornerRadius = 10;//设置那个圆角的有多圆
//        herdimage.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
//        herdimage.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
//        herdimage.layer.masksToBounds = YES;
//         [herdimage  setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
////        herdimage.image = [UIImage imageNamed:@"PresonImage"];
//        [cell addSubview:herdimage];
        UILabel *heradlable = [[UILabel alloc]initWithFrame:CGRectMake(130  , 10, 190 , 65)];
        heradlable.text = [[UserInfo sharedManager] user_name];
        [cell addSubview:heradlable];
    }
    if (indexPath.section==1 &&indexPath.row==1) {
        cell.rightimage.hidden = YES;
        cell.leftlable.hidden = YES;
    }
    return cell;

}

-(void)doClickHeadAction:(UIButton *)btn
{
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 20;
    }
    if (section==2) {
        return 35;
    }
    if (section==3) {
        return 80;
    }
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }
    
    if (indexPath.section==1 &&indexPath.row==1) {
        return 0;
    }
    
    return 50;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    if (indexPath.row==0&&indexPath.section==0) {
        
        /*
        if ([self isConnectionAvailable]) {
            
            TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:herdimage.image];
            viewController.transitioningDelegate = self;
            [self presentViewController:viewController animated:NO completion:nil];

        }else{
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网络已断开，请稍后重试" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        */
        
//        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"noloadata"];
//      AppDelegate * _app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        
//       UIImageView* herdimageview = [[UIImageView alloc] initWithFrame:_app.window.bounds];
//        //    view.userInteractionEnabled = YES;
//    [herdimageview  setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
//        [herdimageview setBackgroundColor:[UIColor redColor]];
//        [_app.window addSubview:herdimageview];
    }
    if (indexPath.section==1&&indexPath.row==3) {
        SetUPVC *vc=[[SetUPVC alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
    }
    if (indexPath.section==1&&indexPath.row==0) {
        if ([[[UserInfo sharedManager] usertype]isEqualToString:@"2"] ) {
            FMeansManageVC *vc=[[FMeansManageVC alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
        }else if([[[UserInfo sharedManager] usertype]isEqualToString:@"0"])
        {
            TMeansManageVC *vc=[[TMeansManageVC alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
        }else if ([[[UserInfo sharedManager] usertype]isEqualToString:@"1"])
        {
            TMeansManageVC *vc=[[TMeansManageVC alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
        }
      


    
    }
    if (indexPath.section==1&&indexPath.row==2) {
        GuanYuViewController *vc = [[GuanYuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
    }
    if (indexPath.section==2) {
        
        self.sheet = [[LTBounceSheet alloc]initWithHeight:250 bgColor:[UIColor whiteColor]];
        self.sheet.alpha=1;
        
        backmyview  = [[UIView alloc]initWithFrame:self.contentView.bounds];
        backmyview.alpha=.3;
        backmyview.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:backmyview];
        
        UITextView *tuichutextview = [[UITextView alloc]init];
        tuichutextview.frame=CGRectMake(46, 13, 233, 38);
        tuichutextview.text = @"退出后不会删除任何历史记录，下次登录依然可以使用本账号.";
        [tuichutextview setFont:[UIFont fontWithName:KUIFont size:12]];
        tuichutextview.textColor = [UIColor grayColor];
        tuichutextview.userInteractionEnabled =NO;
        tuichutextview.textAlignment = UITextAlignmentCenter;
        [self.sheet addView:tuichutextview];
        UIButton * option1 = [[UIButton alloc]init];
        
        //[self produceButtonWithTitle:@"退出登录"];
       [option1 addTarget:self action:@selector(show2) forControlEvents:UIControlEventTouchDown];
        option1.frame=CGRectMake(50, 75, 230, 38);
        option1.alpha=1;

        [option1 setBackgroundImage:[UIImage imageNamed:@"tuideng"] forState: UIControlStateNormal];
        
        [self.sheet addView:option1];
        
        UIButton * option2 =[[UIButton alloc]init];
//        [self produceButtonWithTitle:@"取消"];
        option2.frame=CGRectMake(50, 125, 230, 38);
        [option2 addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
        [option2 setBackgroundImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
        [self.sheet addView:option2];
        [self.sheet show];

    }
}
-(void)show2
{
      [self.sheet hide];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"dontconnect"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [backmyview setHidden:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0"forKey:@"nosave"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downsoket" object:nil];
    [Utils changeViewControllerWithTabbarIndex:4];
    [[UserInfo sharedManager] setIslogin:NO];

}
-(void)hide
{
   [self.sheet hide];
    [backmyview setHidden:YES];
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
