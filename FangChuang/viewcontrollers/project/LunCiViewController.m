//
//  LunCiViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-31.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//
//轮次
#import "LunCiViewController.h"

@interface LunCiViewController ()

@end

@implementation LunCiViewController
- (void)loadData
{
    [[NetManager sharedManager]getRoundsWithProjectid:self.proid roundid:[[NSUserDefaults standardUserDefaults]objectForKey:@"turn"] username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
        NSLog(@"dataDic=%@",dataDic);
        
        [self initContentView];
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
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
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:16]];
    [self setTitle:@"轮次"];
    
    [self loadData];
}
#pragma -mark -functions
- (void)initContentView
{
    UILabel* typeLb  =[[UILabel alloc] initWithFrame:CGRectMake(10, (40 - 15) / 2., 50, 20)];
    [typeLb setBackgroundColor:[UIColor clearColor]];
    [typeLb setTextColor:GRAY];
    [typeLb setText:@"轮次"];
    [typeLb setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:typeLb];
    
    //轮次选择后边的图标
    UIImage *chooseKuang = [UIImage imageNamed:@"15_anniu_1.png"];
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn setFrame:CGRectMake(CGRectGetMaxX(typeLb.frame)-5, 12, chooseKuang.size.width/2-20, chooseKuang.size.height/2)];
    [chooseBtn setBackgroundImage:chooseKuang forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(chooseYear:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:chooseBtn];
    
    //轮选择框的Label
    turnLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(typeLb.frame), 12, 70, chooseKuang.size.height/2)];
    [turnLabel setBackgroundColor:[UIColor clearColor]];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"turn"]) {
        [turnLabel setText:@"第一轮"];
    }else{
        [turnLabel setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"turn"]];
    }
    [turnLabel setFont:[UIFont systemFontOfSize:14]];
    [turnLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:turnLabel];

    //
    UIImage *kuang = [UIImage imageNamed:@"38_shurukuang_1"];
    NSArray *array = [[NSArray alloc]initWithObjects:@"【 名单数 】",@"【 录用人 】",@"【 企业同意 】",@"【 审核时间 】",@"【 状态 】",@"【 方创审核 】" ,nil];
    NSArray *array2 = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"member"]],[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"enter_people"]],[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"agree"]],[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"check_time"]],[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"status"]],[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"fc_check"]], nil];
    
    //第一部分背景图
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(typeLb.frame)+15, 310, kuang.size.height/2+20)];
    [backView setImage:kuang];
    [self.contentView addSubview:backView];
    
    int height = 0;
    int height2 = 10;
    for (int i = 0; i < array.count; i++) {
        height = i*(20+5);
        
        RTLabel *textLabel = [[RTLabel alloc]initWithFrame:CGRectMake(0, 10+height, 200, 20)];
        if (i >= 4) {
            [textLabel setFrame:CGRectMake(156, height2, 155, 20)];
            height2 += 25;
        }
        [textLabel setText:[NSString stringWithFormat:
                            @"<font face='Helvetica' size=15 color=%@>%@</font> <font face=Helvetica size=15 color=%@>%@</font> ",@"orange",[array objectAtIndex:i],@"gray",[array2 objectAtIndex:i]]];
        //第一部分里面的内容
        [textLabel setBackgroundColor:[UIColor clearColor]];
        [backView addSubview:textLabel];
    }

    //具体详情显示Label
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(backView.frame)+20, 150, 30)];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setFont:[UIFont boldSystemFontOfSize:18]];
    [titleLable setText:@"具体详情显示如下:"];
    [titleLable setTextColor:ORANGE];
    [self.contentView addSubview:titleLable];

    //第二部分背景图
    UIImageView *xiaimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backView.frame)+55,320, 360/2+5)];
    [xiaimageView setImage:[UIImage imageNamed:@"028_wenzikuang_2.png"]];
    [self.contentView addSubview:xiaimageView];

    //第二部分内容
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLable.frame)+10, 320, 180) style:UITableViewStylePlain];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [self.contentView addSubview:myTableView];
}
#pragma -mark -UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[dataDic objectForKey:@"detail_list"] count] ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellString=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        
        UILabel *gongsiLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 85, 20)];
        [gongsiLable setBackgroundColor:[UIColor clearColor]];
        [gongsiLable setTextAlignment:NSTextAlignmentLeft];
        [gongsiLable setTextColor:[UIColor orangeColor]];
        [Utils setDefaultFont:gongsiLable size:14];
        [gongsiLable setText:@"【投资公司】"];
        [cell.contentView addSubview:gongsiLable];

        UILabel *touzilab3=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(gongsiLable.frame), 5, 85, 20)];
        [touzilab3 setBackgroundColor:[UIColor clearColor]];
        [touzilab3 setText:[[[dataDic objectForKey:@"detail_list"] objectAtIndex:indexPath.row] objectForKey:@"inc"]];
        [touzilab3 setTextColor:[UIColor grayColor]];
        [Utils setDefaultFont:touzilab3 size:14];
        [touzilab3 setTag:10004];
        [cell.contentView addSubview:touzilab3];

        UILabel *renLable=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(gongsiLable.frame)+5, 70, 20)];
        [renLable setBackgroundColor:[UIColor clearColor]];
        [renLable setTextAlignment:NSTextAlignmentLeft];
        [renLable setTextColor:[UIColor orangeColor]];
        [Utils setDefaultFont:renLable size:14];
        [renLable setText:@"【投资人】"];
        [cell.contentView addSubview:renLable];

        UILabel *touzirenlab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(renLable.frame), CGRectGetMaxY(gongsiLable.frame)+5, 85, 20)];
        [touzirenlab setBackgroundColor:[UIColor clearColor]];
        [touzirenlab setText:[[[dataDic objectForKey:@"detail_list"] objectAtIndex:indexPath.row] objectForKey:@"inv"]];
        [touzirenlab setTextColor:[UIColor grayColor]];
        [Utils setDefaultFont:touzirenlab size:14];
        [touzirenlab setTag:10000];
        [cell.contentView addSubview:touzirenlab];
        
        //线
        UIImageView *xianNextIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0,60-1, 320, 1)];
        [xianNextIMG setImage:[UIImage imageNamed:@"004_fengexian_1"]];
        [cell.contentView addSubview:xianNextIMG];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
#pragma -mark -doClickAction
- (void)chooseYear:(UIButton*)sender
{
    turnArray = [[NSArray alloc]initWithObjects:@"第一轮",@"第二轮",@"第三轮", nil];
    myPickerView = [[APickerView alloc]initWithData:turnArray];
    myPickerView.delegate = self;
    [self.contentView addSubview:myPickerView];

    [myPickerView setSelectRow:[[[NSUserDefaults standardUserDefaults]objectForKey:@"turnIndex"]intValue] inComponent:0 animated:YES];
}
#pragma -mark -APickerViewDelegate
- (void) pickerViewSelectObject : (id) object index : (NSInteger) index
{
    [[NSUserDefaults standardUserDefaults]setObject:[turnArray objectAtIndex:index] forKey:@"turn"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",index] forKey:@"turnIndex"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //    [UIView animateWithDuration:.5f delay:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        [myPickerView setFrame:CGRectMake(0, self.contentViewHeight+216, 320, 216)];
    //    } completion:nil];
    turnLabel.text = [turnArray objectAtIndex:index];
    [self loadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
