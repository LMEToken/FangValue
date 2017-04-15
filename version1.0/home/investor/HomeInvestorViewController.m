//
//  HomeInvestorViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-10-9.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//投资者
#import "HomeInvestorViewController.h"
//请选择身份
#import "HomeChooseIdentifyViewController.h"
//投资者cell
#import "HomeInvestorViewTableViewCell.h"
//币种
#import "HomeInVestorCurrencyViewController.h"
//额度
#import "HomeInvestorMoneyViewController.h"
//轮次
#import "HomeInvestorTurnViewController.h"
//领域
#import "HomeInvestorZoneViewController.h"
//认证页面
#import "HomeApproveViewController.h"
//公司介绍
#import "HomeInvestorInstructionViewController.h"

@interface HomeInvestorViewController ()
@end

@implementation HomeInvestorViewController
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
    [self setTitle:@"完善投资者信息"];
    
    //返回按钮
    [self addBackButton];
    
     
    //右侧按钮
    //保存按钮暂时去掉
    //[self initRightButton];
    
    //tableView
    [self initTableView];
    
    //searchData
    [self initSearchData];
    
    //隐藏工具条
    [self setTabBarHidden:YES];
    

}
#pragma -mark -funcitons
//tableView
-(void)initTableView
{
   
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    //背景UIScrollerView
    backScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [backScrollerView setBackgroundColor:[UIColor clearColor]];
    [backScrollerView setShowsVerticalScrollIndicator:NO];
    [backScrollerView setContentSize:CGSizeMake(320,700)];
    [backScrollerView setDelegate:self];
    backScrollerView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:backScrollerView];

    //背景图
    backGroundView=[[UIView alloc]init];
    backGroundView.frame=CGRectMake(0, 0, 320, 700);
    backGroundView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:backGroundView];
    
    
    //机构信息
    imageView=[[UIImageView alloc]init];
    imageView.frame=CGRectMake(0, 0, 320, 32);
    imageView.image=[UIImage imageNamed:@"homeInvestorOrganization"];
    [backGroundView addSubview:imageView];
    
    
    //tableView
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 32, backGroundView.frame.size.width,52*4 )];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.separatorStyle=UITableViewCellSelectionStyleNone;
    myTableView.backgroundColor=[UIColor clearColor];
    myTableView.scrollEnabled=NO;
    [backGroundView addSubview:myTableView];
    
    
    //下一步按钮
    nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame=CGRectMake(20, myTableView.frame.origin.y+myTableView.frame.size.height+162, 275, 37) ;
    [nextButton setImage:[UIImage imageNamed:@"homeEntreNext"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(doClickNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:nextButton];
    
}
//右侧按钮
-(void)initRightButton
{
    
    //右侧添加按钮
    
    UIButton *enLargeRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [enLargeRightButton setFrame:CGRectMake(200, -14, 120, 59)];
    [enLargeRightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    enLargeRightButton.backgroundColor=[UIColor clearColor];
    [self addRightButton:enLargeRightButton isAutoFrame:NO];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(66, 17, 44, 44)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont fontWithName:KUIFont size:16];
    [rightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor=[UIColor clearColor];
    [enLargeRightButton addSubview:rightButton];
    
}

//searchData
-(void)initSearchData
{
    searchNameArray=[[NSMutableArray alloc]initWithObjects:@"币种:",@"额度:",@"轮次:",@"领域:",nil];
    searchHeadImageArray=[[NSMutableArray alloc]initWithObjects:@"homeInvestorCurrency",@"homeInvestorMoney",@"homeInvestorTurn",@"homeInvestorZone",nil];
    searchDic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:searchNameArray,@"search_name",searchHeadImageArray,@"search_head", nil];

    
    
    if ([whereFromString isEqualToString: CLH_NSSTRING_HOME_INVEST_DETAIL]) {
        
        
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"money-i"]){
           // alreadyChooseArr=[[NSMutableArray alloc]initWithObjects:@"不限",@"不限",@"不限",@"不限", nil];
            alreadyChooseArr=[[NSMutableArray alloc]initWithObjects:@"必选",@"必选",@"必选",@"必选", nil];
            
        }else{
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"money-i"] isEqualToString:@""]) {
              //  alreadyChooseArr=[[NSMutableArray alloc]initWithObjects:@"不限",@"不限",@"不限",@"不限", nil];
                alreadyChooseArr=[[NSMutableArray alloc]initWithObjects:@"必选",@"必选",@"必选",@"必选", nil];
            }else{
                alreadyChooseArr=[[NSMutableArray alloc]initWithObjects:[[NSUserDefaults standardUserDefaults]objectForKey:@"scale-i"] ,[[NSUserDefaults standardUserDefaults]objectForKey:@"money-i"],[[NSUserDefaults standardUserDefaults]objectForKey:@"stage-i"],[[NSUserDefaults standardUserDefaults]objectForKey:@"business-i"],nil];
            }
            
            
        }
        
        NSUserDefaults *currency0=[NSUserDefaults standardUserDefaults];
        [currency0 setObject:[alreadyChooseArr objectAtIndex:0] forKey:CLH_DEFAULT_INVEST_CURRENCY];
        [currency0 synchronize];
        
        
        NSUserDefaults *currency1=[NSUserDefaults standardUserDefaults];
        [currency1 setObject:[alreadyChooseArr objectAtIndex:1] forKey:CLH_DEFAULT_INVEST_MONEY];
        [currency1 synchronize];
        
        NSUserDefaults *currency2=[NSUserDefaults standardUserDefaults];
        [currency2 setObject:[alreadyChooseArr objectAtIndex:2] forKey:CLH_DEFAULT_INVEST_TURN ];
        [currency2 synchronize];
        
        NSUserDefaults *currency3=[NSUserDefaults standardUserDefaults];
        [currency3 setObject:[alreadyChooseArr objectAtIndex:3] forKey:CLH_DEFAULT_INVEST_BUSINESS];
        [currency3 synchronize];
        
    }else{
        //每个条目上显示的内容
        NSString *turnStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_INVEST_CURRENCY];
        if (!turnStr) {
            //turnStr=@"不限";
            turnStr=@"必选";
        }
        NSString *currenStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_INVEST_MONEY];
        if (!currenStr) {
           // currenStr=@"不限";
            currenStr=@"必选";
        }
        NSString *stageStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_INVEST_TURN];
        if (!stageStr) {
           // stageStr=@"不限";
            stageStr=@"必选";
        }
        NSString *businessStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_INVEST_BUSINESS];
        if (!businessStr) {
           // businessStr=@"不限";
            businessStr=@"必选";
        }
        
        alreadyChooseArr=[[NSMutableArray alloc]initWithObjects:turnStr,currenStr,stageStr,businessStr,nil];
    }
    

}
#pragma -mark -doClickAction
//保存按钮
-(void)doClickRightButton:(UIButton *)btn
{
    NSLog(@"--doClickRightButton--");
 
    //完善投资者资料
    NSUserDefaults *investDefault = [NSUserDefaults standardUserDefaults];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:0] forKey:@"scale-i"];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:1] forKey:@"money-i"];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:2] forKey:@"stage-i"];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:3] forKey:@"business-i"];
    [investDefault synchronize];
    
}
//下一步
-(void)doClickNextButton:(UIButton *)btn
{
    NSLog(@"--doClickNextButton--");
    
    
    if ([[alreadyChooseArr objectAtIndex:0]isEqualToString:@"必选"]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请选择币种" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }else if ([[alreadyChooseArr objectAtIndex:1]isEqualToString:@"必选"]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请选择额度" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if ([[alreadyChooseArr objectAtIndex:2]isEqualToString:@"必选"]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请选择轮次" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if ([[alreadyChooseArr objectAtIndex:3]isEqualToString:@"必选"]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请选择领域" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }
    
      
    //完善投资者资料
    NSUserDefaults *investDefault = [NSUserDefaults standardUserDefaults];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:0] forKey:@"scale-i"];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:1] forKey:@"money-i"];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:2] forKey:@"stage-i"];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:3] forKey:@"business-i"];
    [investDefault synchronize];
    
    HomeInvestorInstructionViewController *investor=[[HomeInvestorInstructionViewController alloc]init];
    [self.navigationController pushViewController:investor animated:NO];
}
//返回按钮
- (void) backButtonAction : (id) sender
{
    NSLog(@"--backButtonAction--");
    
    //完善投资者资料
    NSUserDefaults *investDefault = [NSUserDefaults standardUserDefaults];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:0] forKey:@"scale-i"];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:1] forKey:@"money-i"];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:2] forKey:@"stage-i"];
    [investDefault setObject:[alreadyChooseArr objectAtIndex:3] forKey:@"business-i"];
    [investDefault synchronize];

     HomeChooseIdentifyViewController *homeView=[[HomeChooseIdentifyViewController alloc]init];
    [self.navigationController pushViewController:homeView animated:NO];
    
}
#pragma -mark -UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *strID=@"cell";
    HomeInvestorViewTableViewCell *cell=(HomeInvestorViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:strID];
    if (nil==cell) {
        cell=[[HomeInvestorViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
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
        HomeInVestorCurrencyViewController *turnView=[[HomeInVestorCurrencyViewController alloc]init];
        turnView.aleadyString=[alreadyChooseArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:turnView animated:NO];
    }else if (indexPath.row==1){
        HomeInvestorMoneyViewController *currencyView=[[HomeInvestorMoneyViewController alloc]init];
        currencyView.aleadyString=[alreadyChooseArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:currencyView animated:NO];
    }else if (indexPath.row==2){
        HomeInvestorTurnViewController*stageView=[[HomeInvestorTurnViewController alloc]init];
        stageView.aleadyString=[alreadyChooseArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:stageView animated:NO];
    }else if (indexPath.row==3){
        HomeInvestorZoneViewController *bussinessView=[[HomeInvestorZoneViewController alloc]init];
        bussinessView.aleadyString=[alreadyChooseArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:bussinessView animated:NO];
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
