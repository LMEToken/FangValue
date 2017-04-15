//
//  ProjectFinanceTableViewCellDetailViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-20.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//融资进程点击cell进的页面

#import "ProjectFinanceTableViewCellDetailViewController.h"
#import "ProjectFinanceCompanyFlagViewController.h"
#import "ProjectFinanceBasicInformationGroupViewController.h"
#import "projectFinanceBasicInformationStateViewController.h"
#import "ProjectFinanceTabelViewController.h"
//缓存图片
#import "UIImageView+WebCache.h"

@interface ProjectFinanceTableViewCellDetailViewController ()

@end

@implementation ProjectFinanceTableViewCellDetailViewController
@synthesize basiInformationContactContentTextField;
@synthesize basicInformationStateMustTextField;
@synthesize basiInformationMeetContentTextField;
@synthesize basicInformationGroupMustTextField;
@synthesize psTextView;
@synthesize companyFlagString;
@synthesize whereFromString;
@synthesize proID;
@synthesize piid;
@synthesize beforeDic;
@synthesize group;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    NSLog(@"--beforeDic--%@",beforeDic);
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetPDFDocment:) name:PDFDOCMENTDIDGOT object:nil];
    
     [self loadData];
    
}
-(void)loadData
{
    NSLog(@"--beforeDic--%@",beforeDic);
    
    [[NetManager sharedManager] getpipinfoWithUsername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] projectid:proID piid:piid hudDic:nil success:^(id responseDic) {
        NSLog(@"---financeDetail---responseDic--%@",responseDic);
        dic=[NSDictionary dictionaryWithDictionary:[responseDic objectForKey:@"data"]];
        NSLog(@"--dic--%@",dic);
        
        
        if ([[dic objectForKey:@"minutes"] count]>1) {
            
            NSDictionary *minuteFirst=[[dic objectForKey:@"minutes"]objectAtIndex:0];
            NSDictionary *minuteSecond=[[dic objectForKey:@"minutes"]objectAtIndex:1];
            
            NSString *minuteFirstStr=[NSString stringWithFormat:@"%@\n%@\n%@",[minuteFirst objectForKey:@"fbtype"],[minuteFirst objectForKey:@"pdate"],[minuteFirst objectForKey:@"vfeedback"]];
            NSString *minuteSecondStr=[NSString stringWithFormat:@"%@\n%@\n%@",[minuteSecond objectForKey:@"fbtype"],[minuteSecond objectForKey:@"pdate"],[minuteSecond objectForKey:@"vfeedback"]];
            
            NSUserDefaults *dicDefault=[NSUserDefaults standardUserDefaults];
            [dicDefault setObject:[dic objectForKey:@"meets"] forKey:@"finance-detail-meet"];
            [dicDefault setObject:minuteFirstStr forKey:@"finance-detail-minutes-first"];
            [dicDefault setObject:minuteSecondStr forKey:@"finance-detail-minutes-second"];
            [dicDefault synchronize];
            
            
            NSLog(@"--meet--%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-meet"]);
            NSLog(@"--first--%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-minutes-first"]);
            NSLog(@"--second--%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-minutes-second"]);
            
        }else if ([[dic objectForKey:@"minutes"] count]==1){
            
            NSDictionary *minuteFirst=[[dic objectForKey:@"minutes"]objectAtIndex:0];
            
            NSString *minuteFirstStr=[NSString stringWithFormat:@"%@\n%@\n%@",[minuteFirst objectForKey:@"fbtype"],[minuteFirst objectForKey:@"pdate"],[minuteFirst objectForKey:@"vfeedback"]];
          
            
            NSUserDefaults *dicDefault=[NSUserDefaults standardUserDefaults];
            [dicDefault setObject:[dic objectForKey:@"meets"] forKey:@"finance-detail-meet"];
            [dicDefault setObject:minuteFirstStr forKey:@"finance-detail-minutes-first"];
            [dicDefault setObject:@"" forKey:@"finance-detail-minutes-second"];
            [dicDefault synchronize];
            
            
            NSLog(@"--meet--%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-meet"]);
            NSLog(@"--first--%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-minutes-first"]);
            NSLog(@"--second--%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-minutes-second"]);
        }else if ([[dic objectForKey:@"minutes"] count]==0){
            
            NSUserDefaults *dicDefault=[NSUserDefaults standardUserDefaults];
            [dicDefault setObject:[dic objectForKey:@"meets"] forKey:@"finance-detail-meet"];
            [dicDefault setObject:@"" forKey:@"finance-detail-minutes-first"];
            [dicDefault setObject:@"" forKey:@"finance-detail-minutes-second"];
            [dicDefault synchronize];
            
            
            NSLog(@"--meet--%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-meet"]);
            NSLog(@"--first--%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-minutes-first"]);
            NSLog(@"--second--%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-minutes-second"]);
        }

       
        
        
    } fail:^(id errorString) {
        NSLog(@"---financeDetail-error--%@--",errorString);
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PDFDOCMENTDIDGOT object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题
    [self setTitle:@"跟进信息"];
    
    //返回按钮
    [self addBackButton];
    
    //右侧按钮
    //编辑模块暂时去掉
    // [self initRightButton];
    
    //初始化界面
    [self initBackGroundView];
    
    //使工具栏显示
    [self setTabBarIndex:1];
    

}
#pragma -mark -functions
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
    
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL])
    {
         [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    }else if (([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP])){
        [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"出错了，亲" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    rightButton.titleLabel.font=[UIFont fontWithName:KUIFont size:16];
    [rightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor=[UIColor clearColor];
    [enLargeRightButton addSubview:rightButton];
    
}
-(void)initBackGroundView
{
    //背景UIScrollerView
    backScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [backScrollerView setBackgroundColor:[UIColor clearColor]];
    [backScrollerView setShowsVerticalScrollIndicator:YES];
    [backScrollerView setContentSize:CGSizeMake(320,700)];
    [backScrollerView setDelegate:self];
    backScrollerView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:backScrollerView];
    
    
    
    //标题所在的背景
    organizationNameContentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 90)];
    organizationNameContentView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:organizationNameContentView];
    
    //公司图标
    organizationHeadImageView=[[UIImageView alloc]initWithFrame:CGRectMake(23, 15, 65, 65)];
   // organizationHeadImageView.image=[UIImage imageNamed:@"project-finance-cell-detail-headImageView"];
    [organizationHeadImageView setImageWithURL:[NSURL URLWithString:[beforeDic objectForKey:@"picurl"]] placeholderImage:[UIImage imageNamed:@"project-finance-new-headImage"]];
    
    [organizationNameContentView addSubview:organizationHeadImageView];
    
    //机构名称Label
    organizationNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x+organizationHeadImageView.frame.size.width+25, organizationHeadImageView.frame.origin.y+15, 150, 30)];
    organizationNameLabel.text=[beforeDic objectForKey:@"name"];
    organizationNameLabel.textColor=[UIColor grayColor];
    organizationNameLabel.backgroundColor=[UIColor clearColor];
    organizationNameLabel.font=[UIFont fontWithName:KUIFont size:15];
    [organizationNameContentView addSubview:organizationNameLabel];
    
    
    
    //公司标签Label
    companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x, organizationNameContentView.frame.origin.y+organizationNameContentView.frame.size.height, 50, 30)];
    companyLabel.text=@"公司标签";
    companyLabel.textColor=[UIColor grayColor];
    companyLabel.backgroundColor=[UIColor clearColor];
    companyLabel.font=[UIFont fontWithName:KUIFont size:11];
    [backScrollerView addSubview:companyLabel];
    
    //公司标签UIView
    companyContentView=[[UIView alloc]initWithFrame:CGRectMake(0, companyLabel.frame.origin.y+companyLabel.frame.size.height, self.contentView.frame.size.width, 50)];
    companyContentView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:companyContentView];
    
    
    //公司标签添加
    companyAddButton=[UIButton buttonWithType:UIButtonTypeCustom];
    companyAddButton.frame=CGRectMake(organizationHeadImageView.frame.origin.x+210, 10, 50, 30);
    [companyAddButton setTitle:@"+添加" forState:UIControlStateNormal];
    companyAddButton.titleLabel.font=[UIFont fontWithName:KUIFont size:10];
    [companyAddButton setBackgroundImage:[UIImage imageNamed:@"organization-company-add-button"] forState:UIControlStateNormal];
    [companyAddButton addTarget:self action:@selector(dOClickCompanyAddButton:) forControlEvents:UIControlEventTouchUpInside];
    [companyAddButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL])
    {
        companyAddButton.hidden=YES;
    }else if (([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP])){
        companyAddButton.hidden=NO;
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"出错了，亲" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }

    [companyContentView addSubview:companyAddButton];
    
    
    //公司标签显示
       
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
       // companyFlagString=@"互联网 不限";
        companyFlagString=[beforeDic objectForKey:@"industry"];
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:companyFlagString forKey:CLH_DEFAULT_FINANCE_DETAIL_ADD_FLAG];
        [currency synchronize];

        
        
    }else if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP]){
        
        NSString *companyStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_DETAIL_ADD_FLAG];
        if (!companyStr) {
            companyStr=@"";
        }
        companyFlagString=companyStr;
    }

    NSLog(@"--text--%@",companyFlagString);
    if (companyFlagString.length==0) {
        ;
    }else{
        NSArray *companyTextArray=[companyFlagString componentsSeparatedByString:@","];
        NSLog(@"---companyTextArray-%@--",companyTextArray);
        NSLog(@"--companyTextArray-%i",companyTextArray.count);
        if (companyTextArray.count==0) {
            ;
        }else{
            if (companyTextArray.count<3||companyTextArray.count==3) {
                
                for (int i=0; i<companyTextArray.count; i++) {
                    
                    UILabel *companyFlagLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x+70*i, companyAddButton.frame.origin.y+5, 54, 26)];
                    if (i==0) {
                        companyFlagLabel.backgroundColor=[UIColor colorWithRed:238/255.0 green:205/255.0 blue:93/255.0 alpha:1.0];
                        
                    }else if (i==1){
                        companyFlagLabel.backgroundColor=[UIColor colorWithRed:164/255.0 green:215/255.0 blue:35/255.0 alpha:1.0];
                    }else if (i==2){
                        companyFlagLabel.backgroundColor=[UIColor colorWithRed:255/255.0 green:0/255.0 blue:150/255.0 alpha:1.0];
                    }
                    companyFlagLabel.text=[companyTextArray objectAtIndex:i];
                    companyFlagLabel.textColor=[UIColor whiteColor];
                    companyFlagLabel.textAlignment=NSTextAlignmentCenter;
                    companyFlagLabel.font=[UIFont fontWithName:KUIFont size:9];
                    [companyContentView addSubview:companyFlagLabel];
                    
                }
                
            }else if(companyTextArray.count>3){
                
                for (int i=0; i<3; i++) {
                    
                    UILabel *companyFlagLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x+70*i, companyAddButton.frame.origin.y+5, 54, 26)];
                    if (i==0) {
                        companyFlagLabel.backgroundColor=[UIColor colorWithRed:238/255.0 green:205/255.0 blue:93/255.0 alpha:1.0];
                        
                    }else if (i==1){
                        companyFlagLabel.backgroundColor=[UIColor colorWithRed:164/255.0 green:215/255.0 blue:35/255.0 alpha:1.0];
                    }else if (i==2){
                        companyFlagLabel.backgroundColor=[UIColor colorWithRed:255/255.0 green:0/255.0 blue:150/255.0 alpha:1.0];
                    }
                    companyFlagLabel.text=[companyTextArray objectAtIndex:i];
                    companyFlagLabel.textColor=[UIColor whiteColor];
                    companyFlagLabel.textAlignment=NSTextAlignmentCenter;
                    companyFlagLabel.font=[UIFont fontWithName:KUIFont size:9];
                    [companyContentView addSubview:companyFlagLabel];
                    
                }
                
            }

        }
        
    }
    
    
    //基本信息Label
    basicInformationLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x, companyContentView.frame.origin.y+companyContentView.frame.size.height, 50, 30)];
    basicInformationLabel.text=@"基本信息";
    basicInformationLabel.textColor=[UIColor grayColor];
    basicInformationLabel.backgroundColor=[UIColor clearColor];
    basicInformationLabel.font=[UIFont fontWithName:KUIFont size:11];
    [backScrollerView addSubview:basicInformationLabel];
    
    //联系人所在UIView
    basicInformationContactView=[[UIView alloc]initWithFrame:CGRectMake(0, basicInformationLabel.frame.origin.y+basicInformationLabel.frame.size.height, self.contentView.frame.size.width, 38)];
    basicInformationContactView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:basicInformationContactView];
    
    //联系人Label
    basicInformationContactLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x, 10, 50, 20)];
    basicInformationContactLabel.text=@"联系人:";
    basicInformationContactLabel.textColor=[UIColor grayColor];
    basicInformationContactLabel.backgroundColor=[UIColor clearColor];
    basicInformationContactLabel.font=[UIFont fontWithName:KUIFont size:12];
    [basicInformationContactView addSubview:basicInformationContactLabel];
    
    
    //联系人请输入姓名UITextField
    basiInformationContactContentTextField=[[UITextField alloc]initWithFrame:CGRectMake(240, 15,75, 20)];
    
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
       // basiInformationContactContentTextField.text=@"康梁";
        basiInformationContactContentTextField.text=[beforeDic objectForKey:@"a_investors"];
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:basiInformationContactContentTextField.text forKey:CLH_DEFAULT_FINANCE_DETAIL_ADD_CONTRACT];
        [currency synchronize];
        
        
        
    }else if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP]){
        
        NSString *companyStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_DETAIL_ADD_CONTRACT];
        if (!companyStr) {
            companyStr=@"";
        }
         basiInformationContactContentTextField.text=companyStr;
    }

    basiInformationContactContentTextField.textColor=[UIColor grayColor];
    basiInformationContactContentTextField.font=[UIFont fontWithName:KUIFont size:10];
    basiInformationContactContentTextField.backgroundColor=[UIColor clearColor];
    basiInformationContactContentTextField.delegate=self;
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL])
    {
        basiInformationContactContentTextField.enabled=NO;
    }else if (([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP])){
       basiInformationContactContentTextField.enabled=YES;
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"出错了，亲" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }

    [basicInformationContactView addSubview:basiInformationContactContentTextField];
    
    
    //线
    lineContactView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 37.5, 320, 0.5)];
    lineContactView.image=[UIImage imageNamed:@"organization-line-view.png"];
    [basicInformationContactView addSubview:lineContactView];
    
    
    //状态所在UIView
    
    basicInformationStateView=[[UIView alloc]initWithFrame:CGRectMake(0, basicInformationContactView.frame.origin.y+basicInformationContactView.frame.size.height, self.contentView.frame.size.width, 38)];
    basicInformationStateView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:basicInformationStateView];
    
    
    //状态Label
    basicInformationStateLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x, 10, 50, 20)];
    basicInformationStateLabel.text=@"状态:";
    basicInformationStateLabel.textColor=[UIColor grayColor];
    basicInformationStateLabel.backgroundColor=[UIColor clearColor];
    basicInformationStateLabel.font=[UIFont fontWithName:KUIFont size:12];
    [basicInformationStateView addSubview:basicInformationStateLabel];
    
    //状态button
    basicInformationStateButton=[UIButton buttonWithType:UIButtonTypeCustom];
    basicInformationStateButton.frame=basicInformationStateView.frame;
    basicInformationStateButton.backgroundColor=[UIColor clearColor];
    [basicInformationStateButton addTarget:self action:@selector(doClickBasicInformationStateButton:) forControlEvents:UIControlEventTouchUpInside];
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL])
    {
        basicInformationStateButton.enabled=NO;
    }else if (([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP])){
        basicInformationStateButton.enabled=YES;
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"出错了，亲" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }

    [backScrollerView addSubview:basicInformationStateButton];
    
    //状态必选
    basicInformationStateMustTextField=[[UITextField alloc]initWithFrame:CGRectMake(240, 10, 50, 20)];
    
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
       // basicInformationStateMustTextField.text=@"上会10%";
        basicInformationStateMustTextField.text=[beforeDic objectForKey:@"fbtype"];
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:basicInformationStateMustTextField.text forKey:CLH_DEFAULT_FINANCE_DETAIL_STATE];
        [currency synchronize];
        
    }else if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP]){
        NSString *stateStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_DETAIL_STATE];
        if (!stateStr) {
            stateStr=@"";
        }
        basicInformationStateMustTextField.text=stateStr;
    }
    basicInformationStateMustTextField.placeholder=@"必选";
    basicInformationStateMustTextField.textColor=[UIColor grayColor];
    basicInformationStateMustTextField.backgroundColor=[UIColor clearColor];
    basicInformationStateMustTextField.textColor=[UIColor grayColor];
    basicInformationStateMustTextField.font=[UIFont fontWithName:KUIFont size:10];
    basicInformationStateMustTextField.enabled=NO;
    basicInformationStateMustTextField.delegate=self;
    [basicInformationStateView addSubview:basicInformationStateMustTextField];
    
    //箭头
    stateArrowImageView=[[UIImageView alloc]initWithFrame:CGRectMake(basicInformationStateMustTextField.frame.origin.x+basicInformationStateMustTextField.frame.size.width+10, 13, 8, 12)];
    stateArrowImageView.image=[UIImage imageNamed:@"project-finance-arrow"];
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL])
    {
        stateArrowImageView.hidden=YES;
    }else if (([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP])){
        stateArrowImageView.hidden=NO;
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"出错了，亲" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }

    [basicInformationStateView addSubview:stateArrowImageView];
    
    
    //线
    lineStateView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 37.5, 320, 0.5)];
    lineStateView.image=[UIImage imageNamed:@"organization-line-view.png"];
    [basicInformationStateView addSubview:lineStateView];
    
    
    //见面次数所在UIView
    
    basicInformationMeetView=[[UIView alloc]initWithFrame:CGRectMake(0, basicInformationStateView.frame.origin.y+basicInformationStateView.frame.size.height, self.contentView.frame.size.width, 38)];
    basicInformationMeetView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:basicInformationMeetView];
    
    
    //见面次数Label
    basicInformationMeetLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x, 10, 60, 20)];
    basicInformationMeetLabel.text=@"见面次数:";
    basicInformationMeetLabel.textColor=[UIColor grayColor];
    basicInformationMeetLabel.backgroundColor=[UIColor clearColor];
    basicInformationMeetLabel.font=[UIFont fontWithName:KUIFont size:12];
    [basicInformationMeetView addSubview:basicInformationMeetLabel];
    
    
    //联系人请输入见面次数UITextField
    basiInformationMeetContentTextField=[[UITextField alloc]initWithFrame:CGRectMake(240, 15,40, 20)];
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
    
        NSLog(@"-meet-%@---",[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-meet"]);
               
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-meet"]) {
            
            basiInformationMeetContentTextField.text=@"0";
            
        }else{
            basiInformationMeetContentTextField.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-meet"]];

        }
        
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:basiInformationMeetContentTextField.text forKey:CLH_DEFAULT_FINANCE_DETAIL_ADD_MEET];
        [currency synchronize];
        
        
        
    }else if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP]){

        NSString *companyStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_DETAIL_ADD_MEET];
        if (!companyStr) {
            companyStr=@"";
        }
        basiInformationMeetContentTextField.text=companyStr;
    }

    basiInformationMeetContentTextField.textColor=[UIColor grayColor];
    basiInformationMeetContentTextField.font=[UIFont fontWithName:KUIFont size:10];
    basiInformationMeetContentTextField.backgroundColor=[UIColor clearColor];
    basiInformationMeetContentTextField.delegate=self;
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL])
    {
        basiInformationMeetContentTextField.enabled=NO;
    }else if (([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP])){
        basiInformationMeetContentTextField.enabled=YES;
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"出错了，亲" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }

    [basicInformationMeetView addSubview:basiInformationMeetContentTextField];
     

    //线
    lineMeetView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 37.5, 320, 0.5)];
    lineMeetView.image=[UIImage imageNamed:@"organization-line-view.png"];
    [basicInformationStateView addSubview:lineMeetView];
    
    
    //组别所在UIView
    basicInformationGroupView=[[UIView alloc]initWithFrame:CGRectMake(0, basicInformationMeetView.frame.origin.y+basicInformationMeetView.frame.size.height+0.5, self.contentView.frame.size.width, 38)];
    basicInformationGroupView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:basicInformationGroupView];
    
    //组别button
    basicInformationGroupButton=[UIButton buttonWithType:UIButtonTypeCustom];
    basicInformationGroupButton.frame=basicInformationGroupView.frame;
    basicInformationGroupButton.backgroundColor=[UIColor clearColor];
    [basicInformationGroupButton addTarget:self action:@selector(doClickBasicInformationGroupButton:) forControlEvents:UIControlEventTouchUpInside];
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL])
    {
        basicInformationGroupButton.enabled=NO;
    }else if (([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP])){
        basicInformationGroupButton.enabled=YES;

    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"出错了，亲" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }

    [backScrollerView addSubview:basicInformationGroupButton];
    
    //组别Label
    basicInformationGroupLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x, 10, 60, 20)];
    basicInformationGroupLabel.text=@"组别:";
    basicInformationGroupLabel.textColor=[UIColor grayColor];
    basicInformationGroupLabel.backgroundColor=[UIColor clearColor];
    basicInformationGroupLabel.font=[UIFont fontWithName:KUIFont size:12];
    [basicInformationGroupView addSubview:basicInformationGroupLabel];
    
    
    //组别必选
    basicInformationGroupMustTextField=[[UITextField alloc]initWithFrame:CGRectMake(240, 10, 50, 20)];
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
        basicInformationGroupMustTextField.text=group;
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject: basicInformationGroupMustTextField.text forKey:CLH_DEFAULT_FINANCE_DETAIL_GROUP];
        [currency synchronize];
        
    }else if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP]){
        NSString *groupStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_DETAIL_GROUP];
        if (!groupStr) {
            groupStr=@"";
        }
        basicInformationGroupMustTextField.text=groupStr;
    }
    basicInformationGroupMustTextField.placeholder=@"必选";
    basicInformationGroupMustTextField.backgroundColor=[UIColor clearColor];
    basicInformationGroupMustTextField.textColor=[UIColor grayColor];
    basicInformationGroupMustTextField.font=[UIFont fontWithName:KUIFont size:10];
    basicInformationGroupMustTextField.enabled=NO;
    basicInformationGroupMustTextField.delegate=self;
    [basicInformationGroupView addSubview:basicInformationGroupMustTextField];
    
    //箭头
    GroupArrowImageView=[[UIImageView alloc]initWithFrame:CGRectMake(basicInformationGroupMustTextField.frame.origin.x+basicInformationGroupMustTextField.frame.size.width+10, 13, 8, 12)];
    GroupArrowImageView.image=[UIImage imageNamed:@"project-finance-arrow"];
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL])
    {
        GroupArrowImageView.hidden=YES;
    }else if (([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP])){
         GroupArrowImageView.hidden=NO;
        
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"出错了，亲" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }

    [basicInformationGroupView addSubview:GroupArrowImageView];
    
    
    
    //线
    lineGroupView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 37.5, 320, 0.5)];
    lineGroupView.image=[UIImage imageNamed:@"organization-line-view.png"];
    [basicInformationGroupView addSubview:lineGroupView];
    
    
    //psLabel
    psLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x, basicInformationGroupView.frame.origin.y+basicInformationGroupView.frame.size.height, 50, 30)];
    psLabel.text=@"Ps";
    psLabel.textColor=[UIColor grayColor];
    psLabel.backgroundColor=[UIColor clearColor];
    psLabel.font=[UIFont fontWithName:KUIFont size:11];
    [backScrollerView addSubview:psLabel];
    
    //PS背景UIView
    psView=[[UIView alloc]initWithFrame:CGRectMake(0, psLabel.frame.origin.y+psLabel.frame.size.height, self.contentView.frame.size.width, 90)];
    psView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:psView];
    
    //请输入备注UITextField
    psTextView=[[UITextView alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x, 15, 280, 60)];
   
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
        // psTextView.text=@"项目方目前比较认可方向，但是对市场空间还需要时间去研读，后续会签订一个NDA，然后做一些初步的DD，项目方目前比较认可方向，但是对市场空间还需要时间去研读，项目方目前比较认可方向，但是对市场空间还需要时间去研读,项目方目前比较认可方向，但是对市场空间还需要时间去研读，后续会签订一个NDA，然后做一些初步的DD，项目方目前比较认可方向，但是对市场空间还需要时间去研读，项目方目前比较认可方向，但是对市场空间还需要时间去研读";
        NSLog(@"--pstextview.text--%@",[beforeDic objectForKey:@"vfeedback"]);
        psTextView.text=[beforeDic objectForKey:@"vfeedback"];
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:psTextView.text forKey:CLH_DEFAULT_FINANCE_DETAIL_ADD_PS];
        [currency synchronize];
        
        
        
    }else if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP]){
        
        NSString *companyStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_DETAIL_ADD_PS];
        if (!companyStr) {
            companyStr=@"";
        }
        psTextView.text=companyStr;
    }

    psTextView.font=[UIFont fontWithName:KUIFont size:10];
    psTextView.backgroundColor=[UIColor clearColor];
    psTextView.textColor=[UIColor grayColor];
    if ([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL])
    {
        psTextView.editable=NO;
    }else if (([whereFromString isEqualToString:CLH_NSSTRING_FINANCE_ADD_STATE_GROUP])){
        psTextView.editable=YES;
        
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"出错了，亲" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }

    psTextView.delegate=self;
    [psView addSubview:psTextView];
    
    
    //会议记录Label
    recordMeetLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationHeadImageView.frame.origin.x, psView.frame.origin.y+psView.frame.size.height, 50, 30)];
    recordMeetLabel.text=@"会议记录";
    recordMeetLabel.textColor=[UIColor grayColor];
    recordMeetLabel.backgroundColor=[UIColor clearColor];
    recordMeetLabel.font=[UIFont fontWithName:KUIFont size:11];
    [backScrollerView addSubview:recordMeetLabel];
    
    
    
    //会议记录UIView
    recordView=[[UIView alloc]initWithFrame:CGRectMake(0, recordMeetLabel.frame.origin.y+recordMeetLabel.frame.size.height, self.contentView.frame.size.width,130)];
    recordView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:recordView];
    
    
    /*
     //将按钮暂时去掉。修改成直接显示字。
    recordFirstButton=[UIButton buttonWithType:UIButtonTypeCustom];
    recordFirstButton.frame=CGRectMake(organizationHeadImageView.frame.origin.x+10, 15, 90, 88);
    [recordFirstButton setImage:[UIImage imageNamed:@"project-finance-cell-detail-record"] forState:UIControlStateNormal];
    [recordFirstButton addTarget:self action:@selector(doclickRecordFirstButton:) forControlEvents:UIControlEventTouchUpInside];
    [recordView addSubview:recordFirstButton];
    
    
    recordSecondButton=[UIButton buttonWithType:UIButtonTypeCustom];
    recordSecondButton.frame=CGRectMake(recordFirstButton.frame.origin.x+recordFirstButton.frame.size.width+25, 15, 90, 88);
    [recordSecondButton setImage:[UIImage imageNamed:@"project-finance-cell-detail-record"] forState:UIControlStateNormal];
    [recordSecondButton addTarget:self action:@selector(doclickRecordSecondButton:) forControlEvents:UIControlEventTouchUpInside];
    [recordView addSubview:recordSecondButton];
    */
    
    
    recordFirstView=[[UITextView alloc]init];
    recordFirstView.frame=CGRectMake(organizationHeadImageView.frame.origin.x+10, 15, 90, 88);
    recordFirstView.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-minutes-first"];
    recordFirstView.backgroundColor=[UIColor yellowColor];
    recordFirstView.scrollEnabled=YES;
    recordFirstView.editable=NO;
    [recordView addSubview:recordFirstView];
    
    
    recordSecondView=[[UITextView alloc]init];
    recordSecondView.frame=CGRectMake(recordFirstView.frame.origin.x+recordFirstView.frame.size.width+25, 15, 90, 88);
    recordSecondView.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"finance-detail-minutes-second"];
    recordSecondView.scrollEnabled=YES;
    recordSecondView.editable=NO;
    recordSecondView.backgroundColor=[UIColor yellowColor];
    [recordView addSubview:recordSecondView];

}
//将联系人，见面次数，ps保存到本地
-(void)defaultOfContactMeetPs
{
    //保存联系人到本地
    NSUserDefaults *currencyContract=[NSUserDefaults standardUserDefaults];
    [currencyContract setObject:basiInformationContactContentTextField.text forKey:CLH_DEFAULT_FINANCE_DETAIL_ADD_CONTRACT];
    [currencyContract synchronize];
    
    //保存见面次数到本地
    NSUserDefaults *currencyMeet=[NSUserDefaults standardUserDefaults];
    [currencyMeet setObject:basiInformationMeetContentTextField.text forKey:CLH_DEFAULT_FINANCE_DETAIL_ADD_MEET];
    [currencyMeet synchronize];
    
    //保存PS到本地
    NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
    [currency setObject:psTextView.text forKey:CLH_DEFAULT_FINANCE_DETAIL_ADD_PS];
    [currency synchronize];
    

}
#pragma -mark -doClickActions
-(void)doClickRightButton:(UIButton *)btn
{
    NSLog(@"--doClickRightButton-");
    
    if ([btn.titleLabel.text isEqualToString:@"编辑"]) {
        
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        //公司标签添加
        companyAddButton.hidden=NO;
        //联系人
        basiInformationContactContentTextField.enabled=YES;
        //状态
        basicInformationStateButton.enabled=YES;
        //箭头
        stateArrowImageView.hidden=NO;
        //见面交数
        basiInformationMeetContentTextField.enabled=YES;
        //组别
        basicInformationGroupButton.enabled=YES;
        //箭头
        GroupArrowImageView.hidden=NO;
        //ps
        psTextView.editable=YES;
        
    }else if ([btn.titleLabel.text isEqualToString:@"保存"]){
        
        //保存前检查
        if (basiInformationContactContentTextField.text.length==0){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入联系人" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
            
        }else if (basiInformationMeetContentTextField.text.length==0){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入见面次数" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
            
        }else if (psTextView.text.length==0){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入备注信息" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
 
        
        //传给服务器编辑后的公司标签，联系人，状态，见面次数，组别，ps,上传到服务器，返回到主页面。
        ProjectFinanceTabelViewController *financeView=[[ProjectFinanceTabelViewController alloc]init];
        financeView.projectID=proID;
        [self.navigationController pushViewController:financeView animated:NO];

    }
    
}

-(void)dOClickCompanyAddButton:(UIButton *)btn
{
    NSLog(@"--doClickCompanyAddButton--");
    
    //将联系人，见面次数，PS保存到本地
    [self defaultOfContactMeetPs];
    
    ProjectFinanceCompanyFlagViewController *companyView=[[ProjectFinanceCompanyFlagViewController alloc]init];
    companyView.jumpFlagString=CLH_NSSTRING_FINANCE_DETAIL_ADD_COMPANY_FLAG;
    companyView.jumpStr=companyFlagString;
    [self.navigationController pushViewController:companyView animated:NO];
    
}
-(void)doClickBasicInformationStateButton:(UIButton *)btn
{
    NSLog(@"-doClickBasicInformationStateButton-");
    
    //将联系人，见面次数，PS保存到本地
    [self defaultOfContactMeetPs];
    
    projectFinanceBasicInformationStateViewController *stateView=[[projectFinanceBasicInformationStateViewController alloc]init];
    stateView.jumpFlagString=CLH_NSSTRING_FINANCE_DETAIL_ADD_STATE_FLAG;
    stateView.jumpStr=basicInformationStateMustTextField.text;
    [self.navigationController pushViewController:stateView animated:NO];
}
-(void)doClickBasicInformationGroupButton:(UIButton *)btn
{
    NSLog(@"-doClickBasicInformationGroupButton-");
    
    //将联系人，见面次数，PS保存到本地
    [self defaultOfContactMeetPs];
    
    ProjectFinanceBasicInformationGroupViewController *groupView=[[ProjectFinanceBasicInformationGroupViewController alloc]init];
    groupView.jumpFlagString=CLH_NSSTRING_FINANCE_DETAIL_ADD_GROUP_FLAG;
    groupView.jumpStr=basicInformationGroupMustTextField.text;
    [self.navigationController pushViewController:groupView animated:NO];
}
-(void)doclickRecordFirstButton:(UIButton *)btn
{
    NSLog(@"--doclickRecordFirstButton--");
    
    [[NetManager sharedManager] GetPDFWithUrl:recordUrl];

}
-(void)doclickRecordSecondButton:(UIButton *)btn
{
    NSLog(@"--doclickRecordSecondButton--");
    
    [[NetManager sharedManager] GetPDFWithUrl:recordUrl];
}
- (void) backButtonAction : (id) sender
{
    ProjectFinanceTabelViewController *finance=[[ProjectFinanceTabelViewController alloc]init];
    finance.projectID=proID;
    [self.navigationController pushViewController:finance animated:NO];
    
}

#pragma -mark -UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:basiInformationMeetContentTextField]||[textField isEqual:basiInformationContactContentTextField]) {
        
        [UIView animateWithDuration:0.2 animations:^{
            backScrollerView.frame=CGRectMake(0, 0, 320, self.contentViewHeight);
        }];
        
    }
    
    [textField resignFirstResponder];
    
    return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:basiInformationMeetContentTextField]) {
        [UIView animateWithDuration:0.2 animations:^{
            backScrollerView.frame=CGRectMake(0, -210, 320, self.contentViewHeight+210);
        }];
    }
    if ([textField isEqual:basiInformationContactContentTextField]) {
        [UIView animateWithDuration:0.2 animations:^{
            backScrollerView.frame=CGRectMake(0, -150, 320, self.contentViewHeight+150);
        }];
    }
    
    return YES;
}
#pragma -mark -UITextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView isEqual:psTextView]) {
        
        [UIView animateWithDuration:0.3 animations:^{
            backScrollerView.frame=CGRectMake(0, -220, 320, self.contentViewHeight+220);
        }];
    }

     return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [UIView animateWithDuration:0.5 animations:^{
            backScrollerView.frame=CGRectMake(0, 0, 320, self.contentViewHeight);
        }];
        [textView resignFirstResponder];
        
        return NO;
    }

     return YES;
}
#pragma -mark -UIScrollerView Delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
 
    if ([scrollView isEqual:backScrollerView]) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
             backScrollerView.frame=CGRectMake(0, 0, 320, self.contentViewHeight);
             [basiInformationMeetContentTextField resignFirstResponder];
            [basiInformationContactContentTextField resignFirstResponder];
            [psTextView resignFirstResponder];
            
           
            
        }];

    }
    
}
#pragma -mark -电子书
//获取到路径的通知
- (void)didGetPDFDocment:(NSNotification*)noti
{
    NSString* path = (NSString*)noti.object;
    
    NSLog(@"------path---%@",path);
    
    if ([path isEqualToString:@"error"]) {
        NSLog(@"--获取文档失败---");
        return ;
    }
    
	ReaderDocument *document = [ReaderDocument withDocumentFilePath:path password:nil];
    
    NSLog(@"------document-----%@----",document);
    
	if (document != nil)
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
		readerViewController.delegate = (id<ReaderViewControllerDelegate>)self;
        
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        
		[self.navigationController pushViewController:readerViewController animated:YES];
        
#else
        
		readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
	//	[self presentModalViewController:readerViewController animated:YES];
        [self.navigationController presentViewController:readerViewController animated:NO completion:nil];
        
#endif
        
	}
    else
    {
        NSLog(@"读取文件失败");
    }
}

#pragma  -mark -ReaderViewControllerDelegate methods
- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
    
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
	[self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    
	//[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
    
#endif // DEMO_VIEW_CONTROLLER_PUSH
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
