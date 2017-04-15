//
//  ProjectFinanceBasicInformationGroupViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-20.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//添加组别页面

#import "ProjectFinanceBasicInformationGroupViewController.h"
#import "ProjectFinanceRightAddViewController.h"
#import "ProjectFinanceTableViewCellDetailViewController.h"

@interface ProjectFinanceBasicInformationGroupViewController ()

@end

@implementation ProjectFinanceBasicInformationGroupViewController
@synthesize jumpFlagString;
@synthesize jumpStr;

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
    
    //背景色
    [self initBackView];
    
    //标题
    [self setTitle:@"组别"];
    
    //返回按钮
    [self addBackButton];
    
    //右侧按钮
    [self initRightButton];
    
    //初始化描述性文字
    [self initExplainTitle];
    
    //初始化按钮
    [self initChooseButton];
    
}
#pragma -mark -funcitons
//背景色
-(void)initBackView
{
    self.contentView.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
}

//筛选部分右侧按钮
-(void)initRightButton
{
    
    //右侧添加按钮
    
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
//描述性文字
-(void)initExplainTitle
{
    UIView *explainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    explainView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:explainView];
    
    UILabel *explainLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 1, 50, 30)];
    explainLabel.text=@"选择组别";
    explainLabel.font=[UIFont fontWithName:KUIFont size:10];
    explainLabel.backgroundColor=[UIColor clearColor];
    [explainLabel setTextColor:[UIColor grayColor]];
    [explainView addSubview:explainLabel];
    
    //选择组别下边的线
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, explainView.frame.size.height-1, explainView.frame.size.width, 0.5)];
    lineView.backgroundColor=[UIColor colorWithRed:197/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
    [explainView addSubview:lineView];
}
//初始化选择框
-(void)initChooseButton{
    turnButtonArray=[[NSMutableArray alloc]initWithObjects:@"重点更进",@"已见面",@"已推进",@"已否决", nil];
    
    UIImage *downImage=[UIImage imageNamed:@"projectFinnanceStateDownImage"];
    UIImage *upImage=[UIImage imageNamed:@"projectFinanceStateUPImage"];
    
    buttonDownImages=[[NSMutableArray alloc]initWithObjects:downImage,downImage,downImage,downImage,downImage,downImage,downImage,nil];
    buttonUpImages=[[NSMutableArray alloc] initWithObjects:upImage,upImage,upImage,upImage,upImage,upImage,upImage,nil];
    
    //添加页面
    if ([jumpFlagString isEqualToString:CLH_NSSTRING_FINANCE_RIGHT_ADD_GROUP_FLAG]) {
        
        if (!chooseIndex) {
            chooseIndex=[[NSMutableArray alloc]init];
        }
        NSLog(@"--jumpStr.length--%i",jumpStr.length);
        if (jumpStr.length==0) {
            
            for (int i=0; i<[turnButtonArray count]; i++) {
                if (i==[turnButtonArray count]-1) {
                    [chooseIndex addObject:@"0"];
                }else{
                    [chooseIndex addObject:@"0"];
                }
            }
            NSLog(@"--chooseIndex-%@",chooseIndex);
            
        }else{
            
            chooseIndex=[[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:CLH_DEFAULT_FINANCE_GROUP_INDEX]];
            if (chooseIndex.count==0) {
                
                for (int i=0; i<[turnButtonArray count]; i++) {
                    if (i==[turnButtonArray count]-1) {
                        [chooseIndex addObject:@"0"];
                    }else{
                        [chooseIndex addObject:@"0"];
                    }
                }
                NSLog(@"--chooseIndex-%@",chooseIndex);
            }
            
            
        }
         NSLog(@"---chooseIndex-%@",chooseIndex);
        //跟踪页面
    }else if ([jumpFlagString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_ADD_GROUP_FLAG]){
        
        if (!chooseIndex) {
            chooseIndex=[[NSMutableArray alloc]init];
        }
        NSLog(@"--jumpStr.length--%i",jumpStr.length);
        if (jumpStr.length==0) {
            
            for (int i=0; i<[turnButtonArray count]; i++) {
                if (i==[turnButtonArray count]-1) {
                    [chooseIndex addObject:@"0"];
                }else{
                    [chooseIndex addObject:@"0"];
                }
            }
            NSLog(@"--chooseIndex-%@",chooseIndex);
            
        }else{
            
            for (int i=0; i<[turnButtonArray count]; i++) {
                if (i==[turnButtonArray count]-1) {
                    [chooseIndex addObject:@"0"];
                }else{
                    [chooseIndex addObject:@"0"];
                }
            }
            NSLog(@"--chooseIndex--%@",chooseIndex);
            NSArray *jumpStrArr=[jumpStr componentsSeparatedByString:@" "];
            NSLog(@"--jumpStrArr-%@",jumpStrArr);
            
            for (int i=0; i<jumpStrArr.count; i++) {
                for (int j=0; j<turnButtonArray.count; j++) {
                    if ([[jumpStrArr objectAtIndex:i] isEqualToString:[turnButtonArray objectAtIndex:j]]) {
                        [chooseIndex replaceObjectAtIndex:j withObject:@"1"];
                        continue;
                    }
                }
            }
        }
        NSLog(@"---chooseIndex-%@",chooseIndex);
      //其它页面
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"未知页面" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];

    }
    
    
    
    for (int i=0; i<4; i++) {
        
        UIButton *turnButton=[UIButton buttonWithType:UIButtonTypeCustom];
        turnButton.frame=CGRectMake(15+100*(i%3), 50+60*(i/3), 90, 39);
        [turnButton setTitle:[turnButtonArray objectAtIndex:i] forState:UIControlStateNormal];
        [turnButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        turnButton.tag=i;
        NSString *str=[chooseIndex objectAtIndex:i];
        if ([str isEqualToString:@"1"]) {
            [turnButton setBackgroundImage:[buttonDownImages objectAtIndex:i] forState:UIControlStateNormal];
            
        }else if([str isEqualToString:@"0"]){
            
            [turnButton setBackgroundImage:[buttonUpImages objectAtIndex:i] forState:UIControlStateNormal];
        }

        turnButton.titleLabel.font=[UIFont fontWithName:KUIFont size:12];
        [turnButton addTarget:self action:@selector(doClickChooseButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:turnButton];
    }
    
}
#pragma -mark -doClickAction
-(void)doClickRightButton:(UIButton *)btn
{
    NSLog(@"--rightButton-");
    NSLog(@"-chooseIndex--%@--",chooseIndex);
    
    
    
    if ([jumpFlagString isEqualToString:CLH_NSSTRING_FINANCE_RIGHT_ADD_GROUP_FLAG]) {
        //将索引保存到本地
        NSUserDefaults *chooseIndexDefault=[NSUserDefaults standardUserDefaults];
        [chooseIndexDefault setObject:chooseIndex forKey:CLH_DEFAULT_FINANCE_GROUP_INDEX];
        [chooseIndexDefault synchronize];
        
        for (int i=0;i<chooseIndex.count;i++) {
            if ([[chooseIndex objectAtIndex:i]isEqualToString:@"1"]) {
                if (!chooseArray) {
                    chooseArray=[[NSMutableArray alloc]init];
                }
                [chooseArray addObject:[turnButtonArray objectAtIndex:i]];
                
            }
        }
        
        if (chooseArray.count==0) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"至少要选择一项" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        NSString *chooseStr = [chooseArray componentsJoinedByString:@" "];
        NSLog(@"-chooseStr-%@--",chooseStr);
        

        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:chooseStr forKey:CLH_DEFAULT_FINANCE_GROUP];
        [currency synchronize];
        
        ProjectFinanceRightAddViewController *rightView=[[ProjectFinanceRightAddViewController alloc]init];
        [self.navigationController pushViewController:rightView animated:NO];
        
    }else if ([jumpFlagString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_ADD_GROUP_FLAG])
    {
        
        for (int i=0;i<chooseIndex.count;i++) {
            if ([[chooseIndex objectAtIndex:i]isEqualToString:@"1"]) {
                if (!chooseArray) {
                    chooseArray=[[NSMutableArray alloc]init];
                }
                [chooseArray addObject:[turnButtonArray objectAtIndex:i]];
                
            }
        }
        
        if (chooseArray.count==0) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"至少要选择一项" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        NSString *chooseStr = [chooseArray componentsJoinedByString:@" "];
        NSLog(@"-chooseStr-%@--",chooseStr);
        

        NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
        [currency setObject:chooseStr forKey:CLH_DEFAULT_FINANCE_DETAIL_GROUP];
        [currency synchronize];
        
        ProjectFinanceTableViewCellDetailViewController *detailView=[[ProjectFinanceTableViewCellDetailViewController alloc]init];
        detailView.whereFromString=CLH_NSSTRING_FINANCE_ADD_STATE_GROUP;
        [self.navigationController pushViewController:detailView animated:NO];
    }
    
}
-(void)doClickChooseButton:(UIButton *)btn
{
    NSLog(@"-before-chooseIndex-%@",chooseIndex);
    
    if ([[chooseIndex objectAtIndex:btn.tag]isEqualToString:@"0"]) {
        [chooseIndex replaceObjectAtIndex:btn.tag withObject:@"1"];
        [btn setBackgroundImage:[buttonDownImages objectAtIndex:btn.tag] forState:UIControlStateNormal];
        
    }else if ([[chooseIndex objectAtIndex:btn.tag]isEqualToString:@"1"])
    {
        [chooseIndex replaceObjectAtIndex:btn.tag withObject:@"0"];
        [btn setBackgroundImage:[buttonUpImages objectAtIndex:btn.tag] forState:UIControlStateNormal];
        
    }
    NSLog(@"-end -chooseIndex--%@",chooseIndex);

}
- (void) backButtonAction : (id) sender
{
    if ([jumpFlagString isEqualToString:CLH_NSSTRING_FINANCE_RIGHT_ADD_GROUP_FLAG]) {
        
        ProjectFinanceRightAddViewController *rightView=[[ProjectFinanceRightAddViewController alloc]init];
        [self.navigationController pushViewController:rightView animated:NO];
    }else if([jumpFlagString isEqualToString:CLH_NSSTRING_FINANCE_DETAIL_ADD_GROUP_FLAG]){
        
        ProjectFinanceTableViewCellDetailViewController *detailView=[[ProjectFinanceTableViewCellDetailViewController alloc]init];
        detailView.whereFromString=CLH_NSSTRING_FINANCE_ADD_STATE_GROUP;
        [self.navigationController pushViewController:detailView animated:NO];
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
