//
//  ProjectMainRightSearchViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//右侧筛选界面

#import "ProjectMainRightSearchViewController.h"
#import "ProjectMainSearchViewTableViewCell.h"
#import "SearchBusinessViewController.h"
#import "SearchCurrencyViewController.h"
#import "SearchMoneyViewController.h"
#import "SearchTurnViewController.h"
#import "SearchStageViewController.h"
#import "ProjectMainTableViewController.h"
#import "Reachability.h"


@interface ProjectMainRightSearchViewController ()

@end

@implementation ProjectMainRightSearchViewController
@synthesize whereFromString;

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
    [self setTitle:@"筛选"];
    
    //返回按钮
    [self addBackButton];
    
    //右侧按钮
    [self initRightButton];
    
    //使工具栏显示
    [self setTabBarIndex:1];
    
    //tableView
    [self initTableView];
    
    //searchData
    [self initSearchData];
    
   
}
#pragma -mark -funcitons
//筛选部分右侧按钮
-(void)initRightButton
{
    
    UIButton *enLargeRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [enLargeRightButton setFrame:CGRectMake(200, -14, 120, 59)];
    [enLargeRightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    enLargeRightButton.backgroundColor=[UIColor clearColor];
    [self addRightButton:enLargeRightButton isAutoFrame:NO];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(66, 19, 44, 44)];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont fontWithName:KUIFont size:16];
    [rightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor=[UIColor clearColor];
    [enLargeRightButton addSubview:rightButton];

    
}
//tableView
-(void)initTableView
{
    UIView *backGroundView=[[UIView alloc]init];
    backGroundView.frame=CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    backGroundView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:backGroundView];
    
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, backGroundView.frame.size.width,52*5 )];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.separatorStyle=UITableViewCellSelectionStyleNone;
    myTableView.backgroundColor=[UIColor clearColor];
    myTableView.scrollEnabled=NO;
    [backGroundView addSubview:myTableView];

}
//searchData
-(void)initSearchData
{
    searchNameArray=[[NSMutableArray alloc]initWithObjects:@"轮次:",@"币种:",@"阶段:",@"行业:",@"金额:", nil];
    searchHeadImageArray=[[NSMutableArray alloc]initWithObjects:@"project_search_turn",@"project_search_currency",@"project_search_stage",@"project_search_business",@"project_search_money", nil];
    searchDic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:searchNameArray,@"search_name",searchHeadImageArray,@"search_head", nil];
    
    if ([whereFromString isEqualToString:CLH_NSSTRING_PROJECT_RIGHT_SEARCH_VIEW]) {
        alreadyChooseArr=[[NSMutableArray alloc]initWithObjects:@"不限",@"不限",@"不限",@"不限",@"不限", nil];
        
        NSUserDefaults *currency0=[NSUserDefaults standardUserDefaults];
        [currency0 setObject:@"不限" forKey:CLH_DEFAULT_SEARCH_TURN];
        [currency0 synchronize];
        
        
        NSUserDefaults *currency1=[NSUserDefaults standardUserDefaults];
        [currency1 setObject:@"不限" forKey:CLH_DEFAULT_SEARCH_CURRENCY];
        [currency1 synchronize];
        
        NSUserDefaults *currency2=[NSUserDefaults standardUserDefaults];
        [currency2 setObject:@"不限" forKey:CLH_DEFAULT_SEARCH_STAGE];
        [currency2 synchronize];
        
        NSUserDefaults *currency3=[NSUserDefaults standardUserDefaults];
        [currency3 setObject:@"不限" forKey:CLH_DEFAULT_SEARCH_BUSINESS];
        [currency3 synchronize];
        
        NSUserDefaults *currency4=[NSUserDefaults standardUserDefaults];
        [currency4 setObject:@"不限" forKey:CLH_DEFAULT_SEARCH_MONEY];
        [currency4 synchronize];
        
        
        //第一次进入的时候，所有的选择项目
        for (int i=1; i<6; i++) {
            
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:[NSString stringWithFormat:@"%i",i] hudDic:nil success:^(id responseDic) {
                
                NSLog(@"-turn--responseDic--%@",responseDic);
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray--%@",dataArray);
                
                NSUserDefaults *server=[NSUserDefaults standardUserDefaults];
                if (i==1) {
                     [server setObject:[NSString stringWithFormat:@"%i",dataArray.count-1] forKey:@"server-turn"];
                }else if (i==2){
                      [server setObject:[NSString stringWithFormat:@"%i",dataArray.count-1] forKey:@"server-currency"];
                }else if (i==3){
                    [server setObject:[NSString stringWithFormat:@"%i",dataArray.count-1] forKey:@"server-stage"];
                }
                else if (i==4){
                    [server setObject:[NSString stringWithFormat:@"%i",dataArray.count-1] forKey:@"server-business"];
                }
                else if (i==5){
                    [server setObject:[NSString stringWithFormat:@"%i",dataArray.count-1] forKey:@"server-money"];
                }
                [server synchronize];
                
           }fail:^(id errorString) {
               
                /*
                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:errorString delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                     [alert show];
               
                    */

            }];

        }
       
    }else{
        //每个条目上显示的内容
        NSString *turnStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_SEARCH_TURN];
        if (!turnStr) {
            turnStr=@"不限";
        }
        NSString *currenStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_SEARCH_CURRENCY];
        if (!currenStr) {
            currenStr=@"不限";
        }
        NSString *stageStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_SEARCH_STAGE];
        if (!stageStr) {
            stageStr=@"不限";
        }
        NSString *businessStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_SEARCH_BUSINESS];
        if (!businessStr) {
            businessStr=@"不限";
        }
        NSString *moneyStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_SEARCH_MONEY];
        if (!moneyStr) {
            moneyStr=@"不限";
        }

       alreadyChooseArr=[[NSMutableArray alloc]initWithObjects:turnStr,currenStr,stageStr,businessStr,moneyStr, nil];
    }
    
    
}
#pragma -mark -doClickAction
-(void)doClickRightButton:(UIButton *)btn
{
    NSLog(@"--rightButton-");
    //上传服务器轮次，币种，阶段，行业，金额的内容。服务器返回结果。
    
    if (![self isConnectionAvailable]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网络已断开" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;

    }
    
    NSMutableArray *serverArray=[[NSMutableArray alloc]init];
       
    NSUserDefaults *server=[NSUserDefaults standardUserDefaults];
 
    [serverArray addObject:[server objectForKey:@"server-turn"]];
    [serverArray addObject:[server objectForKey:@"server-currency"]];
    [serverArray addObject:[server objectForKey:@"server-stage"]];
    [serverArray addObject:[server objectForKey:@"server-business"]];
    [serverArray addObject:[server objectForKey:@"server-money"]];
    NSLog(@"----serverArray--%@",serverArray);
    
    NSString *serverStr = [serverArray componentsJoinedByString:@"-"];
    NSLog(@"-server-%@--",serverStr);
    
    
    ProjectMainTableViewController *mainView=[[ProjectMainTableViewController alloc]init];
    mainView.whereFlag=@"1";
    mainView.searchString=serverStr;
    [self.navigationController pushViewController:mainView animated:NO];

}
- (void) backButtonAction : (id) sender
{
    ProjectMainTableViewController *mainView=[[ProjectMainTableViewController alloc]init];
    [self.navigationController pushViewController:mainView animated:NO];
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

#pragma -mark -UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *strID=@"cell";
    ProjectMainSearchViewTableViewCell *cell=(ProjectMainSearchViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:strID];
    if (nil==cell) {
        cell=[[ProjectMainSearchViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    cell.nameLabel.text=[[searchDic objectForKey:@"search_name"]objectAtIndex:indexPath.row];
    cell.headImageView.image=[UIImage imageNamed:[[searchDic objectForKey:@"search_head"]objectAtIndex:indexPath.row]];
    //单元格中内空显示
    cell.contentLabel.text=[alreadyChooseArr objectAtIndex:indexPath.row];
    
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---indexPath-row-%i",indexPath.row);
    if (indexPath.row==0) {
        SearchTurnViewController *turnView=[[SearchTurnViewController alloc]init];
       turnView.aleadyString=[alreadyChooseArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:turnView animated:NO];
    }else if (indexPath.row==1){
        SearchCurrencyViewController *currencyView=[[SearchCurrencyViewController alloc]init];
        currencyView.aleadyString=[alreadyChooseArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:currencyView animated:NO];
    }else if (indexPath.row==2){
        SearchStageViewController *stageView=[[SearchStageViewController alloc]init];
        stageView.aleadyString=[alreadyChooseArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:stageView animated:NO];
    }else if (indexPath.row==3){
        SearchBusinessViewController *bussinessView=[[SearchBusinessViewController alloc]init];
        bussinessView.aleadyString=[alreadyChooseArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:bussinessView animated:NO];
    }else if (indexPath.row==4){
        SearchMoneyViewController *moneyView=[[SearchMoneyViewController alloc]init];
        moneyView.aleadyString=[alreadyChooseArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:moneyView animated:NO];
    }

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
