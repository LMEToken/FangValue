//
//  ProjectFinanceRightAddViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-18.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//点融资时程主页面右侧，添加机构页面

#import "ProjectFinanceRightAddViewController.h"
#import "ProjectFinanceCompanyFlagViewController.h"
#import "ProjectFinanceBasicInformationGroupViewController.h"
#import "projectFinanceBasicInformationStateViewController.h"
#import "ProjectFinanceTabelViewController.h"


@implementation ProjectFinanceRightAddViewController
@synthesize organizationNameTextField;
@synthesize basiInformationContactContentTextField;
@synthesize basicInformationStateMustTextField;
@synthesize basiInformationMeetContentTextField;
@synthesize basicInformationGroupMustTextField;
@synthesize psTextView;
@synthesize companyFlagTextField;
@synthesize companyFlagString;
@synthesize wherefrom;
@synthesize proID;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //标题
    [self setTitle:@"新增机构"];
    
    //返回按钮
    [self addBackButton];
    
    //右侧按钮
    [self initRightButton];
    
    //整体布局
    [self initBackGroundView];
    
    //使工具栏显示
    [self setTabBarIndex:1];
}
#pragma -mark -functions
-(void)initBackGroundView
{
    //背景UIScrollerView
   
    backScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [backScrollerView setBackgroundColor:[UIColor clearColor]];
    [backScrollerView setShowsVerticalScrollIndicator:YES];
    [backScrollerView setContentSize:CGSizeMake(320, 700)];
    [backScrollerView setDelegate:self];
    backScrollerView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:backScrollerView];
    
    
    //机构名称Label
    organizationNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 0, 50, 30)];
    organizationNameLabel.text=@"机构名称";
    organizationNameLabel.textColor=[UIColor grayColor];
    organizationNameLabel.backgroundColor=[UIColor clearColor];
    organizationNameLabel.font=[UIFont fontWithName:KUIFont size:11];
    [backScrollerView addSubview:organizationNameLabel];
    
    //请输入机构名称背景UIView
    organizationNameContentView=[[UIView alloc]initWithFrame:CGRectMake(0, organizationNameLabel.frame.origin.y+organizationNameLabel.frame.size.height, self.contentView.frame.size.width, 50)];
    organizationNameContentView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:organizationNameContentView];
    
    //请输入机构名称UITextField
    organizationNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x, 15, 280, 20)];
    organizationNameTextField.placeholder=@"请输入机构名称";
    
    if ([wherefrom isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
       organizationNameTextField.text=@"";
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:@"" forKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_NAME];
        [currency synchronize];
        
    }else{
        
        NSString *companyStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_NAME];
        if (!companyStr) {
            companyStr=@"";
        }
       organizationNameTextField.text=companyStr;
    }
    organizationNameTextField.textColor=[UIColor grayColor];
    organizationNameTextField.font=[UIFont fontWithName:KUIFont size:10];
    organizationNameTextField.backgroundColor=[UIColor clearColor];
    organizationNameTextField.delegate=self;
    [organizationNameContentView addSubview:organizationNameTextField];
    
    
    //公司标签Label
    companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x, organizationNameContentView.frame.origin.y+organizationNameContentView.frame.size.height, 50, 30)];
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
    companyAddButton.frame=CGRectMake(organizationNameLabel.frame.origin.x, 10, 50, 30);
    [companyAddButton setTitle:@"+添加" forState:UIControlStateNormal];
    companyAddButton.titleLabel.font=[UIFont fontWithName:KUIFont size:10];
    [companyAddButton setBackgroundImage:[UIImage imageNamed:@"organization-company-add-button"] forState:UIControlStateNormal];
    [companyAddButton addTarget:self action:@selector(dOClickCompanyAddButton:) forControlEvents:UIControlEventTouchUpInside];
    [companyAddButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [companyContentView addSubview:companyAddButton];
    
    
    
    if ([wherefrom isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
        companyFlagString=@"";
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:@"" forKey:CLH_DEFAULT_FINANCE_ADD_FLAG];
        [currency synchronize];
        
    }else{
        
        NSString *companyStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_ADD_FLAG];
        if (!companyStr) {
            companyStr=@"";
        }
        companyFlagString=companyStr;
    }
    
    NSLog(@"--text--%@",companyFlagString);
    if (companyFlagString.length==0) {
        ;
    }else{
        NSArray *companyTextArray=[companyFlagString componentsSeparatedByString:@" "];
        NSLog(@"---companyTextArray-%@--",companyTextArray);
        NSLog(@"--companyTextArray-%i",companyTextArray.count);
        if (companyTextArray.count==0) {
            return;
        }else {
            if (companyTextArray.count<3||companyTextArray.count==3) {
                
                for (int i=0; i<companyTextArray.count; i++) {
                    
                    UILabel *companyFlagLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x+organizationNameLabel.frame.size.width+15+70*i, companyAddButton.frame.origin.y+2, 54, 26)];
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
                    
                    UILabel *companyFlagLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x+organizationNameLabel.frame.size.width+15+70*i, companyAddButton.frame.origin.y+2, 54, 26)];
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
    basicInformationLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x, companyContentView.frame.origin.y+companyContentView.frame.size.height, 50, 30)];
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
    basicInformationContactLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x, 10, 50, 20)];
    basicInformationContactLabel.text=@"联系人:";
    basicInformationContactLabel.textColor=[UIColor grayColor];
    basicInformationContactLabel.backgroundColor=[UIColor clearColor];
    basicInformationContactLabel.font=[UIFont fontWithName:KUIFont size:12];
    [basicInformationContactView addSubview:basicInformationContactLabel];
    
    //联系人请输入姓名UITextField
    basiInformationContactContentTextField=[[UITextField alloc]initWithFrame:CGRectMake(240, 15,75, 20)];
    basiInformationContactContentTextField.placeholder=@"请输入姓名";
    
    if ([wherefrom isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
        organizationNameTextField.text=@"";
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:@"" forKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_CONTRACT];
        [currency synchronize];
        
    }else{
        
        NSString *companyStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_CONTRACT];
        if (!companyStr) {
            companyStr=@"";
        }
        basiInformationContactContentTextField.text=companyStr;
    }
    basiInformationContactContentTextField.textColor=[UIColor grayColor];
    basiInformationContactContentTextField.font=[UIFont fontWithName:KUIFont size:10];
    basiInformationContactContentTextField.backgroundColor=[UIColor clearColor];
    basiInformationContactContentTextField.delegate=self;
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
    basicInformationStateLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x, 10, 50, 20)];
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
    
    [backScrollerView addSubview:basicInformationStateButton];
    
    //状态必选
    basicInformationStateMustTextField=[[UITextField alloc]initWithFrame:CGRectMake(240, 10, 50, 20)];
    
    if ([wherefrom isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
        basicInformationStateMustTextField.text=@"";
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:@"" forKey:CLH_DEFAULT_FINANCE_STATE];
        [currency synchronize];

    }else{
        NSString *stateStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_STATE];
        if (!stateStr) {
            stateStr=@"";
        }
        basicInformationStateMustTextField.text=stateStr;
    }
    basicInformationStateMustTextField.placeholder=@"          必选";
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
    basicInformationMeetLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x, 10, 60, 20)];
    basicInformationMeetLabel.text=@"见面次数:";
    basicInformationMeetLabel.textColor=[UIColor grayColor];
    basicInformationMeetLabel.backgroundColor=[UIColor clearColor];
    basicInformationMeetLabel.font=[UIFont fontWithName:KUIFont size:12];
    [basicInformationMeetView addSubview:basicInformationMeetLabel];
    
    //联系人请输入见面次数UITextField
    basiInformationMeetContentTextField=[[UITextField alloc]initWithFrame:CGRectMake(270, 15,40, 20)];
    basiInformationMeetContentTextField.placeholder=@"必填";
    if ([wherefrom isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
        basiInformationMeetContentTextField.text=@"";
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:@"" forKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_MEET ];
        [currency synchronize];
        
    }else{
        
        NSString *companyStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_MEET ];
        if (!companyStr) {
            companyStr=@"";
        }
        basiInformationMeetContentTextField.text=companyStr;
    }
    basiInformationMeetContentTextField.textColor=[UIColor grayColor];
    basiInformationMeetContentTextField.font=[UIFont fontWithName:KUIFont size:10];
    basiInformationMeetContentTextField.backgroundColor=[UIColor clearColor];
    basiInformationMeetContentTextField.delegate=self;
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
    [backScrollerView addSubview:basicInformationGroupButton];
    
    //组别Label
    basicInformationGroupLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x, 10, 60, 20)];
    basicInformationGroupLabel.text=@"组别:";
    basicInformationGroupLabel.textColor=[UIColor grayColor];
    basicInformationGroupLabel.backgroundColor=[UIColor clearColor];
    basicInformationGroupLabel.font=[UIFont fontWithName:KUIFont size:12];
    [basicInformationGroupView addSubview:basicInformationGroupLabel];
    
    //组别必选
    basicInformationGroupMustTextField=[[UITextField alloc]initWithFrame:CGRectMake(240, 10, 50, 20)];
    if ([wherefrom isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
        basicInformationGroupMustTextField.text=@"";
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:@"" forKey:CLH_DEFAULT_FINANCE_GROUP];
        [currency synchronize];
    }else{
        NSString *groupStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_GROUP];
        if (!groupStr) {
            groupStr=@"";
        }
        basicInformationGroupMustTextField.text=groupStr;
    }
    basicInformationGroupMustTextField.placeholder=@"          必选";
    basicInformationGroupMustTextField.textColor=[UIColor grayColor];
    basicInformationGroupMustTextField.backgroundColor=[UIColor clearColor];
    basicInformationGroupMustTextField.textColor=[UIColor grayColor];
    basicInformationGroupMustTextField.font=[UIFont fontWithName:KUIFont size:10];
    basicInformationGroupMustTextField.enabled=NO;
    basicInformationGroupMustTextField.delegate=self;
    [basicInformationGroupView addSubview:basicInformationGroupMustTextField];
    
    //箭头
    GroupArrowImageView=[[UIImageView alloc]initWithFrame:CGRectMake(basicInformationGroupMustTextField.frame.origin.x+basicInformationGroupMustTextField.frame.size.width+10, 13, 8, 12)];
    GroupArrowImageView.image=[UIImage imageNamed:@"project-finance-arrow"];
    [basicInformationGroupView addSubview:GroupArrowImageView];
    
    
    
    //线
    lineGroupView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 37.5, 320, 0.5)];
    lineGroupView.image=[UIImage imageNamed:@"organization-line-view.png"];
    [basicInformationGroupView addSubview:lineGroupView];
    
    
    //psLabel
    psLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x, basicInformationGroupView.frame.origin.y+basicInformationGroupView.frame.size.height, 50, 30)];
    psLabel.text=@"Ps";
    psLabel.textColor=[UIColor grayColor];
    psLabel.backgroundColor=[UIColor clearColor];
    psLabel.font=[UIFont fontWithName:KUIFont size:11];
    [backScrollerView addSubview:psLabel];
    
    //PS背景UIView
    psView=[[UIView alloc]initWithFrame:CGRectMake(0, psLabel.frame.origin.y+psLabel.frame.size.height, self.contentView.frame.size.width, 90)];
    psView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:psView];
    
    //请输入备注UITextView
    psTextView=[[UITextView alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x, 15, 280, 60)];
    
    
    if ([wherefrom isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_CELL]) {
        psTextView.text=@"";
        
        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:@"" forKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_PS ];
        [currency synchronize];
        
    }else{
        
        NSString *companyStr=[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_PS ];
        if (!companyStr) {
            companyStr=@"";
        }
        psTextView.text=companyStr;
    }

    psTextView.textColor=[UIColor grayColor];
    psTextView.font=[UIFont fontWithName:KUIFont size:10];
    psTextView.backgroundColor=[UIColor clearColor];
    psTextView.delegate=self;
    [psView addSubview:psTextView];
    
    
    pslabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x+5, 19, 280, 20)];
    if (psTextView.text.length==0) {
        pslabel.text=@"请输入备注信息";
    }else{
        pslabel.hidden=YES;
    }
    pslabel.font=[UIFont fontWithName:KUIFont size:10];
    pslabel.textColor=[UIColor grayColor];
    pslabel.enabled=NO;
    pslabel.backgroundColor=[UIColor clearColor];
    [psView addSubview:pslabel];
    
    
    
    
    
    //会议记录Label
    recordMeetLabel=[[UILabel alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x, psView.frame.origin.y+psView.frame.size.height, 50, 30)];
    recordMeetLabel.text=@"会议记录";
    recordMeetLabel.textColor=[UIColor grayColor];
    recordMeetLabel.backgroundColor=[UIColor clearColor];
    recordMeetLabel.font=[UIFont fontWithName:KUIFont size:11];
    [backScrollerView addSubview:recordMeetLabel];
    
    
    
    //会议记录UIView
    recordView=[[UIView alloc]initWithFrame:CGRectMake(0, recordMeetLabel.frame.origin.y+recordMeetLabel.frame.size.height, self.contentView.frame.size.width, 55)];
    recordView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:recordView];
    
    //请于系统后台上传会议记录UILabel
    recordTextField=[[UITextField alloc]initWithFrame:CGRectMake(organizationNameLabel.frame.origin.x, 15, 280, 20)];
    recordTextField.placeholder=@"请于系统后台上传会议记录";
    recordTextField.font=[UIFont fontWithName:KUIFont size:10];
    recordTextField.backgroundColor=[UIColor clearColor];
    recordTextField.textColor=[UIColor grayColor];
    recordTextField.enabled=NO;
    recordTextField.delegate=self;
    [recordView addSubview:recordTextField];
    

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
//保存机构名字，联系人，见面次数，PS到本地
-(void)SaveNameContactMeetPsDefault
{
    //将机构名保存到本地
    NSLog(@"------organizationNameTextField.text-%@",organizationNameTextField.text);
    NSUserDefaults *currencyName=[NSUserDefaults standardUserDefaults];
    [currencyName setObject:organizationNameTextField.text forKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_NAME];
    [currencyName synchronize];
    
    //将联系人保存到本地
    NSUserDefaults *currencyContact=[NSUserDefaults standardUserDefaults];
    [currencyContact setObject:basiInformationContactContentTextField.text forKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_CONTRACT];
    [currencyContact synchronize];
    
    //将见面次数保存到本地
    
    NSUserDefaults *currencyMeet=[NSUserDefaults standardUserDefaults];
    [currencyMeet setObject:basiInformationMeetContentTextField.text forKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_MEET ];
    [currencyMeet synchronize];
    
    //将ps保存到本地
    NSUserDefaults *currencyPS=[NSUserDefaults standardUserDefaults];
    [currencyPS setObject:psTextView.text forKey:CLH_DEFAULT_FINANCE_RIGHT_ADD_PS ];
    [currencyPS synchronize];

}
#pragma -mark -doClickActions
-(void)doClickRightButton:(UIButton *)btn
{
    NSLog(@"--doClickRightButton--");
    
    //保存前检查合法性
    if (organizationNameTextField.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入机构名称" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }else if (companyFlagString.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请添加公司标签" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }else if (basiInformationContactContentTextField.text.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入联系人" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if (basicInformationStateMustTextField.text.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请选择状态" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if (basiInformationMeetContentTextField.text.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入见面次数" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if (basicInformationGroupMustTextField.text.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请选择组别" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if (psTextView.text.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入备注信息" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    
    //把机构名称，公司标签，联系人，状态，见面次数，组别，备注信息，传送到服务器。服务器保存。
    //返回到融资进程，同时刷新融资进程页面。
    ProjectFinanceTabelViewController *financeView=[[ProjectFinanceTabelViewController alloc]init];
    financeView.projectID=proID;
    [self.navigationController pushViewController:financeView animated:NO];
    
}
//公司标签添加按钮
-(void)dOClickCompanyAddButton:(UIButton *)btn
{
    NSLog(@"--doClickCompanyAddButton--");
    
    //保存机构名字，联系人，见面次数，PS到本地
    [self SaveNameContactMeetPsDefault];
    
    ProjectFinanceCompanyFlagViewController *companyView=[[ProjectFinanceCompanyFlagViewController alloc]init];
    companyView.jumpFlagString=CLH_NSSTRING_FINANCE_RIGHT_ADD_COMPANY_FLAG;
    companyView.jumpStr=companyFlagString;
    [self.navigationController pushViewController:companyView animated:NO];
    
}
-(void)doClickBasicInformationStateButton:(UIButton *)btn
{
    NSLog(@"-doClickBasicInformationStateButton-");
    
    //保存机构名字，联系人，见面次数，PS到本地
    [self SaveNameContactMeetPsDefault];
    
    projectFinanceBasicInformationStateViewController *stateView=[[projectFinanceBasicInformationStateViewController alloc]init];
    stateView.jumpFlagString=CLH_NSSTRING_FINANCE_RIGHT_ADD_STATE_FLAG;
    stateView.jumpStr= basicInformationStateMustTextField.text;
    [self.navigationController pushViewController:stateView animated:NO];
}
-(void)doClickBasicInformationGroupButton:(UIButton *)btn
{
    NSLog(@"-doClickBasicInformationGroupButton-");
    
    //保存机构名字，联系人，见面次数，PS到本地
    [self SaveNameContactMeetPsDefault];
    
    ProjectFinanceBasicInformationGroupViewController *groupView=[[ProjectFinanceBasicInformationGroupViewController alloc]init];
    groupView.jumpFlagString=CLH_NSSTRING_FINANCE_RIGHT_ADD_GROUP_FLAG;
    groupView.jumpStr=basicInformationGroupMustTextField.text;
    [self.navigationController pushViewController:groupView animated:NO];
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
            backScrollerView.frame=CGRectMake(0, -210, 320, self.contentViewHeight+210);
        }];
    }
    
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   
    if (text.length>0) {
        pslabel.hidden=YES;
    }
    
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

@end
