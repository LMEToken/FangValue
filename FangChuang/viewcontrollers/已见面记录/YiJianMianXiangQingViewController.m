//
//  YiJianMianXiangQingViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//
//已见面详情
#import "YiJianMianXiangQingViewController.h"
#import "RTLabel.h"
@interface YiJianMianXiangQingViewController ()

@end

@implementation YiJianMianXiangQingViewController

@synthesize titleArray;
@synthesize contentArray;
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
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.titleLabel setText:@"已见面详情"];
	[self addBackButton];
    [self setTabBarHidden:YES];
    [self loadData];
    
}
#pragma -mark -functions
- (void)loadData
{
    [[NetManager sharedManager]getMeetingDetailWithMeetid:self.meetid username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
        NSLog(@"dataDic=%@",dataDic);
        
        [self initContentView];
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
//初始化内容
- (void)initContentView
{
    //初始化标题
    self.titleArray = [NSArray arrayWithObjects:
                       @"【日期】:",
                       @"【地点】:",
                       @"【IR类型】:",
                       @"【推荐反馈】:",
                       @"【记录描述】:",
                       @"【项目方反馈】:",
                       @"【投资人反馈】:",nil];
    
    self.contentArray = [NSArray arrayWithObjects:
                         [dataDic objectForKey:@"rdate"],
                         [dataDic objectForKey:@"address"],
                         [dataDic objectForKey:@"irtype"],
                         [dataDic objectForKey:@"irfb"],
                         [dataDic objectForKey:@"recordinfo"],
                         [dataDic objectForKey:@"profb"],
                         [dataDic objectForKey:@"invfb"],nil];
    
    //添加列表
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:myTableView];
}

#pragma mark - tableview delegate and dataSoucre

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        
        //cell白色背景
        UIImage* bcImg = [UIImage imageNamed:@"60_kuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.contentView.frame))];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];
        
        //cell中的内容
        RTLabel* nameLabel = [[RTLabel alloc] initWithFrame:CGRectMake( 10, 15, 300 , 15)];
        [nameLabel setText:[NSString stringWithFormat:@"<font face='Helvetica' size=14 color=orange> %@ </font> <font face=AmericanTypewriter size=14 color=gray> %@ </font> ",[self.titleArray objectAtIndex:indexPath.row],[self.contentArray objectAtIndex:indexPath.row]]];
        CGSize optimumSize = [nameLabel optimumSize];
        [nameLabel setFrame:CGRectMake( 10, 15, 300 , optimumSize.height)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:nameLabel];
        
        [bcImgV setFrame:CGRectMake(0, 0, 320, 30 + optimumSize.height)];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(10,10,300,100)];
	//[label setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20]];
    [label setParagraphReplacement:@""];
    [label setText:[NSString stringWithFormat:@"<font face='Helvetica' size=14 color=orange> %@ </font> <font face=AmericanTypewriter size=14 color=gray> %@ </font> ",[self.titleArray objectAtIndex:indexPath.row],[self.contentArray objectAtIndex:indexPath.row]]];
    CGSize optimumSize = [label optimumSize];

    return 30 + optimumSize.height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
