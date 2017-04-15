//
//  CaiWuMoXingViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-31.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//财务模型界面
#import "CaiWuMoXingViewController.h"
#import "AppDelegate.h"
#import "BorderLabel.h"
#import "CaiWuMoXingBianJiViewController.h"


@interface CaiWuMoXingViewController ()

@end

@implementation CaiWuMoXingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    //    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
    //        [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
    //                                       withObject:(id)UIInterfaceOrientationPortrait];
    //    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
    //        [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
    //                                       withObject:(id)UIInterfaceOrientationLandscapeRight];
    //    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self .titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.titleLabel setText:@"财务信息"];
    [self setTabBarHidden:YES];
    //[self addBackButton];
    
    //返回按钮
    UIImage *backImage = [UIImage imageNamed:@"01_anniu_3"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, (navigationHeight  - backImage.size.height/2)/2, backImage.size.width/2, backImage.size.height/2)];
    [backButton setTag:backButtonTag];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton setBackgroundColor:[UIColor clearColor]];
  //  [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:backButton];
    
    //2014.08.23 chenlihua 修改返回按钮的触碰区域
    UIButton *newBackButton=[UIButton buttonWithType:UIButtonTypeCustom];
    newBackButton.frame=CGRectMake(0, -20, 70, 70);
    newBackButton.backgroundColor=[UIColor clearColor];
    [newBackButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:newBackButton];
    
    
    
    
    //重制父类坐标
    // 开启横屏
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    
    self.view.transform = CGAffineTransformMakeRotation(M_PI / 2. );
    //
    //
    NSLog(@"scrh = %f,sw = %f",screenHeight,screenWidth);
    
    [self.statusBarBackgroundView setHidden:YES];
    
    [self.view setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width)];
    CGRect frame = self.navigationView.frame;
    [self.navigationView setFrame:CGRectMake(CGRectGetMinX(frame), 0, [[UIScreen mainScreen] bounds].size.height, CGRectGetHeight(frame))];
    
    frame = self.titleLabel.frame;
    [self.titleLabel setFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), [[UIScreen mainScreen] bounds].size.height, CGRectGetHeight(frame))];
    frame = self.contentView.frame;
    [self.contentView setFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(self.navigationView.frame), [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width  - CGRectGetMaxY(self.navigationView.frame)) ];
    
    //添加导航右按钮
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.height - 10 - 40, (45 - 25) / 2., 40, 25)];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    //2014.08.08 chenlihua 将编辑按钮去掉
    // [self.navigationView addSubview:rightBtn];
    
    [self loadData];
}
#pragma -mark -functions
- (void)loadData
{
    NSLog(@"---loadData---");
    NSLog(@"----self.proid---%@",self.proid);
    NSLog(@"----yaar---%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"year"]);
    NSLog(@"-----username--%@",[[UserInfo sharedManager]username]);
    
    [[NetManager sharedManager]getFinancialPlanWithProjectid:self.proid cyear:[[NSUserDefaults standardUserDefaults]objectForKey:@"year"] username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        NSLog(@"---responseDic---%@",responseDic);
        [self analyseData:responseDic];
    }
                                                        fail:^(id errorString) {
                                                            NSLog(@"----errorString---%@",errorString);
                                                            [self.view showActivityOnlyLabelWithOneMiao:errorString];
                                                        }];
}
-(void)analyseData:(NSDictionary *)responseDic
{
    NSLog(@"----responseDic--%@",responseDic);
    NSDictionary *dataDic = [responseDic objectForKey:@"data"];
    NSLog(@"dataDic=%@",dataDic);
    
    NSMutableArray *listArray = [dataDic objectForKey:@"list"];
    //NSLog(@"listArray=%@",listArray);
    NSDictionary *myDic = [[NSDictionary alloc]initWithDictionary:[dataDic objectForKey:@"row"]];
    NSDictionary *colDic=[[NSDictionary alloc]initWithDictionary:[dataDic objectForKey:@"col"]];
    
    dataArray = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < [listArray count]+1; i++)
    {
        if(i==0)
        {
            NSMutableArray *array=[[NSMutableArray alloc]init];
            for(int j=1;j<8;j++)
            {
                [array addObject:[colDic objectForKey:[NSString stringWithFormat:@"col%d",j]]];
            }
            [dataArray addObject:array];
            
        }
        else
        {
            NSMutableArray *array=[[NSMutableArray alloc]init];
            
            for(int z=0;z<7;z++)
            {
                if(z==0)
                {
                    [array addObject:[myDic objectForKey:[NSString stringWithFormat:@"row%d",i]]];
                    
                }
                else
                {
                    for(NSDictionary *dic in listArray)
                    {
                        if([[dic objectForKey:@"order"]intValue]==i)
                        {
                            [array addObject:[dic objectForKey:[NSString stringWithFormat:@"col%d",z]]];
                            break;
                            //[listArray removeObject:dic];
                        }
                        
                    }
                    
                }
                
            }
            [dataArray addObject:array];
        }
    }
    
    NSLog(@"---dataArray--%@",dataArray);
    [self initContentView];
    
}
- (void)initContentView
{
    //制作表格
    //融资信息Label
    UILabel* titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 15)];
    [titleLb setBackgroundColor:[UIColor clearColor]];
    [titleLb setText:@"融资信息"];
    [titleLb setTextColor:ORANGE];
    [titleLb setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:titleLb];
    
    //年度选择Label
    UILabel* nianDuLb = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLb.frame) + 5, 60, 10)];
    [nianDuLb setFont:[UIFont systemFontOfSize:11]];
    [nianDuLb setBackgroundColor:[UIColor clearColor]];
    [nianDuLb setTextColor:GRAY];
    [nianDuLb setText:@"年度选择"];
    [self.contentView addSubview:nianDuLb];
    
    //年度选择内容背景图
    UIImage *chooseKuang = [UIImage imageNamed:@"15_anniu_1.png"];
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn setFrame:CGRectMake(CGRectGetMaxX(nianDuLb.frame)-5, 20, chooseKuang.size.width/2-20, chooseKuang.size.height/2-5)];
    [chooseBtn setBackgroundImage:chooseKuang forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(chooseYear:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:chooseBtn];
    
   //年Label
    yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nianDuLb.frame), 18, 70, chooseKuang.size.height/2)];
    [yearLabel setBackgroundColor:[UIColor clearColor]];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"year"]) {
        [yearLabel setText:@"2014（今年）"];
    }else{
        [yearLabel setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"year"]];
    }
    [yearLabel setFont:[UIFont systemFontOfSize:11]];
    [yearLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:yearLabel];
    
    //我已阅读使用条款Label
    UIButton* tiaoKuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tiaoKuanBtn setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.height - 80 - 20, CGRectGetMinY(nianDuLb.frame), 80, 10)];
    [tiaoKuanBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [tiaoKuanBtn setTitle:@"我已阅读使用条款" forState:UIControlStateNormal];
    [tiaoKuanBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [tiaoKuanBtn addTarget:self action:@selector(readTiaoKian:) forControlEvents:UIControlEventTouchUpInside];
   // tiaoKuanBtn.backgroundColor=[UIColor blueColor];
    //2014.07.18 chenlihua 将我已阅读使用条款去掉
   // [self.contentView addSubview:tiaoKuanBtn];

    //初始化数组
    
    //        dataArray = [[NSArray alloc] initWithObjects:
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"},
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"},
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"},
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"},
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"},
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"},
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"},
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"},
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"},
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"},
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"},
    //      @{@"title": @"罚款单法兰克到付件阿打发打发大大飞",@"year":@"2013"}, nil];
    
    //表格UITableView
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(nianDuLb.frame) + 5, [[UIScreen mainScreen] bounds].size.height - 20, [[UIScreen mainScreen] bounds].size.width - CGRectGetMaxY(nianDuLb.frame) - 5 - 45)];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [self.contentView addSubview:myTableView];
}
//画表格的时候用到
-(NSString *)getString:(id) str
{
    
    if (![str isKindOfClass:[NSNull class]]) {
        
        NSString *st=[NSString stringWithFormat:@"%@",str];
        if ([st isEqualToString:@"(null)"]||[st isEqualToString:@"<null>"] || [st isEqualToString:@"null"]) {
            return @"";
        }
        else
            return st;
    }
    
    return @"";
}

#pragma -mark -doClickAction
//返回
- (void)backButtonAction:(UIButton*)sender
{
    NSLog(@"------开始点击返回按钮-----Parent中-----");
    [myPickerView setHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
//编辑
- (void)rightButton:(UIButton*)button
{
    printf(__FUNCTION__);
    CaiWuMoXingBianJiViewController *viewControlelr = [[CaiWuMoXingBianJiViewController alloc] init];
    [self.navigationController pushViewController:viewControlelr animated:YES];
}
//阅读使用条款
- (void)readTiaoKian:(UIButton*)button
{
    printf(__FUNCTION__);
}
//选择年
- (void)chooseYear:(UIButton*)sender
{
    yearArray = [[NSArray alloc]initWithObjects:@"2013（去年）",@"2014（今年）",@"2015（明年）", nil];
    myPickerView = [[APickerView alloc]initWithData:yearArray :YES];
    myPickerView.delegate = self;
    [self.contentView addSubview:myPickerView];
    
    [myPickerView setSelectRow:[[[NSUserDefaults standardUserDefaults]objectForKey:@"yearIndex"]intValue] inComponent:0 animated:YES];
}
#pragma -mark -APickerViewDelegate
- (void) pickerViewSelectObject : (id) object index : (NSInteger) index
{
    [[NSUserDefaults standardUserDefaults]setObject:[yearArray objectAtIndex:index] forKey:@"year"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",index] forKey:@"yearIndex"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //    [UIView animateWithDuration:.5f delay:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        [myPickerView setFrame:CGRectMake(0, self.contentViewHeight+216, 320, 216)];
    //    } completion:nil];
    yearLabel.text = [yearArray objectAtIndex:index];
    [self loadData];
    [myTableView reloadData];
}

#pragma  -mark -UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = nil;
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // NSArray *array = [dataArray objectAtIndex:indexPath.row];
    if (cell == nil) {
         int width = [[UIScreen mainScreen] bounds].size.height == 568 ? 284 : 200;
        
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        //NSString* titleStr = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
        NSString *titleStr = [[dataArray objectAtIndex:indexPath.row] objectAtIndex:0];
        CGSize size = [titleStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(width / 2., MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        
        //左侧的指标/年度(竖的)
        BorderLabel* headLb = [[BorderLabel alloc] initWithFrame:CGRectMake(0, 0, width / 2., size.height+10)];
        [headLb setText:titleStr];
        [headLb setTextAlignment:NSTextAlignmentCenter];
        [headLb setFont:[UIFont systemFontOfSize:14]];
        [headLb setLineBreakMode:NSLineBreakByCharWrapping];
        [cell.contentView addSubview:headLb];
        
        //2012竖行
        BorderLabel* firYLb = [[BorderLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headLb.frame), CGRectGetMinY(headLb.frame), ([[UIScreen mainScreen] bounds].size.height - width  - 20) / 5. , CGRectGetHeight(headLb.frame))];
        [firYLb setFont:[UIFont systemFontOfSize:14]];
        [cell.contentView addSubview:firYLb];
        
        
        [firYLb setTextAlignment:NSTextAlignmentCenter];
        [firYLb setText:[self getString:[[dataArray objectAtIndex:indexPath.row] objectAtIndex:1]]];
        
        //2013年竖行
        BorderLabel* secYLb = [[BorderLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firYLb.frame), CGRectGetMinY(firYLb.frame), CGRectGetWidth(firYLb.frame) , CGRectGetHeight(headLb.frame))];
        [secYLb setFont:[UIFont systemFontOfSize:14]];
        [secYLb setTextAlignment:NSTextAlignmentCenter];
        [secYLb setText:[self getString:[[dataArray objectAtIndex:indexPath.row] objectAtIndex:2]]];
        [cell.contentView addSubview:secYLb];
        
        //2014年竖行
        BorderLabel* thrYLb = [[BorderLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(secYLb.frame), CGRectGetMinY(secYLb.frame), CGRectGetWidth(secYLb.frame) , CGRectGetHeight(headLb.frame))];
        [thrYLb setFont:[UIFont systemFontOfSize:14]];
        [thrYLb setTextAlignment:NSTextAlignmentCenter];
        [thrYLb setText:[self getString:[[dataArray objectAtIndex:indexPath.row] objectAtIndex:3]]];
       [cell.contentView addSubview:thrYLb];
        
        //2015年竖行
        BorderLabel* fourYLb = [[BorderLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(thrYLb.frame), CGRectGetMinY(thrYLb.frame), CGRectGetWidth(thrYLb.frame) , CGRectGetHeight(headLb.frame))];
        [fourYLb setFont:[UIFont systemFontOfSize:14]];
        [fourYLb setTextAlignment:NSTextAlignmentCenter];
        [fourYLb setText:[self getString:[[dataArray objectAtIndex:indexPath.row] objectAtIndex:4]]];
        [cell.contentView addSubview:fourYLb];
        
        //2016年竖行
        BorderLabel* fiveYLb = [[BorderLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fourYLb.frame), CGRectGetMinY(fourYLb.frame), CGRectGetWidth(fourYLb.frame) , CGRectGetHeight(headLb.frame))];
        [fiveYLb setFont:[UIFont systemFontOfSize:14]];            [firYLb setTextAlignment:NSTextAlignmentCenter];
        [fiveYLb setText:[self getString:[[dataArray objectAtIndex:indexPath.row] objectAtIndex:5]]];
        [cell.contentView addSubview:fiveYLb];
        
        //最后一行“上市时预计”竖行
         BorderLabel* lastYLb = [[BorderLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fiveYLb.frame), CGRectGetMinY(fiveYLb.frame), CGRectGetWidth(headLb.frame) , CGRectGetHeight(headLb.frame))];
        [lastYLb setFont:[UIFont systemFontOfSize:14]];
        [lastYLb setTextAlignment:NSTextAlignmentCenter];
        [lastYLb setText:[self getString:[[dataArray objectAtIndex:indexPath.row] objectAtIndex:6]]];
        [cell.contentView addSubview:lastYLb];
        
        
        if (indexPath.row == 0) {
            
            [headLb setBackgroundColor:[UIColor colorWithRed:219 / 255. green:219 / 255. blue:219 / 255. alpha:1.f]];
            //[headLb setText:@""];
            [firYLb setBackgroundColor:[UIColor colorWithRed:219 / 255. green:219 / 255. blue:219 / 255. alpha:1.f]];
            [secYLb setBackgroundColor:[UIColor colorWithRed:219 / 255. green:219 / 255. blue:219 / 255. alpha:1.f]];
            [thrYLb setBackgroundColor:[UIColor colorWithRed:219 / 255. green:219 / 255. blue:219 / 255. alpha:1.f]];
            [fourYLb setBackgroundColor:[UIColor colorWithRed:219 / 255. green:219 / 255. blue:219 / 255. alpha:1.f]];
            [fiveYLb setBackgroundColor:[UIColor colorWithRed:219 / 255. green:219 / 255. blue:219 / 255. alpha:1.f]];
            [lastYLb setBackgroundColor:[UIColor colorWithRed:219 / 255. green:219 / 255. blue:219 / 255. alpha:1.f]];
        }
    }
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CaiWuMoXingBianJiViewController* viewController = [[CaiWuMoXingBianJiViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
//    [viewController release];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int width = [[UIScreen mainScreen] bounds].size.height == 568 ? 284 : 200;
    // NSArray *array = [dataArray objectAtIndex:indexPath.row];
    //NSString* titleStr = [rowDic objectForKey:[[rowDic allKeys]objectAtIndex:indexPath.row]];
    NSString* titleStr = [[dataArray objectAtIndex:indexPath.row] objectAtIndex:0];
    CGSize size = [titleStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(width / 2., MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"size->heigth = %f",size.height);
    return size.height+10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

#pragma -mark  -旋转屏幕

/*
 %>_<% 失败啦，娃娃啊
 */

//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
//    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}
////- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
////{
////    return UIInterfaceOrientationMaskLandscape;
////}
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
