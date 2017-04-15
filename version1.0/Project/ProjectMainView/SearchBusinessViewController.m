//
//  SearchBusinessViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-13.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//行业页面

#import "SearchBusinessViewController.h"
#import "ProjectMainRightSearchViewController.h"

@interface SearchBusinessViewController ()

@end

@implementation SearchBusinessViewController
@synthesize aleadyString;
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
    [self setTitle:@"领域"];
    
    //返回按钮
    [self addBackButton];
    
    //右侧按钮
    [self initRightButton];
    
    //初始化描述性文字
    [self initExplainTitle];
    
    //初始化选择框
    [self initChooseButton];
    
    //使工具栏显示
    [self setTabBarIndex:1];

    
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
-(void)initExplainTitle
{
    UIView *explainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    explainView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:explainView];
    
    UILabel *explainLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 1, 50, 30)];
    explainLabel.text=@"选择领域";
    explainLabel.font=[UIFont fontWithName:KUIFont size:10];
    explainLabel.backgroundColor=[UIColor clearColor];
    [explainLabel setTextColor:[UIColor grayColor]];
    [explainView addSubview:explainLabel];
    
    //线
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, explainView.frame.size.height-1, explainView.frame.size.width, 0.5)];
    lineView.backgroundColor=[UIColor colorWithRed:197/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
    [explainView addSubview:lineView];

    
}
-(void)initChooseButton{
    
      [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"4" hudDic:nil success:^(id responseDic) {
        
        NSLog(@"-turn--responseDic--%@",responseDic);
        NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
        for (NSDictionary *dic in dataArray) {
            if (!turnButtonArray) {
                turnButtonArray=[[NSMutableArray alloc]init];
            }
            [turnButtonArray addObject:[dic objectForKey:@"name"]];
        }
        
        // turnButtonArray=[[NSMutableArray alloc]initWithObjects:@"天使初创期",@"成长发展期",@"成熟期",@"收购",@"不限", nil];
        NSLog(@"--turnButtonArray--%@",turnButtonArray)
        ;
        
        UIImage *downImage=[UIImage imageNamed:@"search-money-middle-DownImage"];
        UIImage *upImage=[UIImage imageNamed:@"search-money-middle-UpImage"];
        
        for (int i=0; i<turnButtonArray.count; i++) {
            if (!buttonDownImages) {
                buttonDownImages=[[NSMutableArray alloc]init];
            }
            [buttonDownImages addObject:downImage];
            if (!buttonUpImages) {
                buttonUpImages=[[NSMutableArray alloc]init];
            }
            [buttonUpImages addObject:upImage];
        }
        
        if (!chooseIndex) {
            chooseIndex=[[NSMutableArray alloc]init];
        }
        for (int i=0; i<[turnButtonArray count]; i++) {
            if (i==[turnButtonArray count]-1) {
                [chooseIndex addObject:@"0"];
            }else{
                [chooseIndex addObject:@"0"];
            }
        }
        NSLog(@"--chooseIndex-%@",chooseIndex);
        
        NSLog(@"--alreadyString--%@",aleadyString);
        NSArray *alreadArr=[[NSArray alloc]initWithArray:[aleadyString componentsSeparatedByString:@"-"]];
        NSLog(@"--alreadArr--%@",alreadArr);
        
        for (int i=0; i<turnButtonArray.count; i++) {
            for (int j=0; j<alreadArr.count; j++) {
                
                if ([[turnButtonArray objectAtIndex:i] isEqualToString:[alreadArr objectAtIndex:j]]) {
                    [chooseIndex replaceObjectAtIndex:i withObject:@"1"];
                    continue;
                }
            }
        }
        
        
        for (int i=0; i<turnButtonArray.count; i++) {
            
            UIButton *turnButton=[UIButton buttonWithType:UIButtonTypeCustom];
            turnButton.frame=CGRectMake(15+100*(i%3), 50+50*(i/3), 90, 39);
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
        
        
    } fail:^(id errorString) {
        NSLog(@"-project--errString-%@",errorString);
       
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:errorString delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
    

}
#pragma -mark -doClickAction
-(void)doClickRightButton:(UIButton *)btn
{
    NSLog(@"--rightButton-");
    NSLog(@"-chooseIndex--%@--",chooseIndex);
    
    
    //选择不限后，在不选择不限，返回的时候，原来的项目也会有记录
    if (chooseArray) {
        [chooseArray removeAllObjects];
    }
    if (serverArray) {
        [serverArray removeAllObjects];
    }

    
    for (int i=0;i<chooseIndex.count;i++) {
        if ([[chooseIndex objectAtIndex:i]isEqualToString:@"1"]) {
            if (!chooseArray) {
                chooseArray=[[NSMutableArray alloc]init];
            }
            [chooseArray addObject:[turnButtonArray objectAtIndex:i]];
            if (!serverArray) {
                serverArray=[[NSMutableArray alloc]init];
            }
            [serverArray addObject:[NSString stringWithFormat:@"%i",i]];
        }
    }
    
    if (chooseArray.count==0) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"至少要选择一项" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    
    //不限不能和其它选项共选
    NSString *lastChoose=[NSString stringWithFormat:@"%@",[chooseArray objectAtIndex:chooseArray.count-1]];
    
    if (chooseArray.count>=2&&[lastChoose isEqualToString:@"不限"] ) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"不限不能和其它选项并选" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }

    
    NSString *chooseStr = [chooseArray componentsJoinedByString:@"-"];
    NSLog(@"-chooseStr-%@--",chooseStr);
    
    
    NSUserDefaults *currency=[NSUserDefaults standardUserDefaults];
    [currency setObject:chooseStr forKey:CLH_DEFAULT_SEARCH_BUSINESS];
    [currency synchronize];
    
    //将选择的坐标，保存在本地
    NSString *serverStr = [serverArray componentsJoinedByString:@","];
    NSLog(@"-serverStr-%@--",serverStr);
    
    NSUserDefaults *server=[NSUserDefaults standardUserDefaults];
    [server setObject:serverStr forKey:@"server-business"];
    [server synchronize];

    ProjectMainRightSearchViewController *searchView=[[ProjectMainRightSearchViewController alloc]init];
    [self.navigationController pushViewController:searchView animated:NO];
    
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
    ProjectMainRightSearchViewController *searchView=[[ProjectMainRightSearchViewController alloc]init];
    [self.navigationController pushViewController:searchView animated:NO];
    
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
