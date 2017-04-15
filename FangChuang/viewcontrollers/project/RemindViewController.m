//
//  RemindViewController.m
//  FangChuang
//
//  Created by 顾 思谨 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//提醒

#import "RemindViewController.h"

@interface RemindViewController ()
@end

@implementation RemindViewController
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
    [self setTabBarHidden:YES];
    self.title = @"提醒";
    [self addBackButton];
    
    
    nowIndex = [[[NSUserDefaults standardUserDefaults]objectForKey:@"RemindIndex"]intValue];
    //右侧完成按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rightButton isAutoFrame:NO];

    //背景图
    UIImage *back = [UIImage imageNamed:@"28_shurukuang_1.png"];
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 1, 320, self.contentViewHeight)];
    [backView setImage:back];
    
    //UITableView
    remindTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, 320, self.contentViewHeight)];
    [remindTable setBackgroundView:backView];
    [remindTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [remindTable setScrollEnabled:NO];
    [remindTable setDataSource:self];
    [remindTable setDelegate:self];
    [self.contentView addSubview:remindTable];
}
#pragma  -mark -UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    textArray = [[NSArray alloc]initWithObjects:@"无",@"5分钟前",@"15分钟",@"30分钟前",@"1小时前",@"两小时前",@"1天前",@"2天前",@"事件发生日",nil];
    cell.textLabel.text = [textArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor orangeColor];
    
    //分割线
    UIImage *line = [UIImage imageNamed:@"31_fengexian_1.png"];
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(5,cell.contentView.frame.size.height-1 , 310, 1)];
    [lineView setImage:line];
    [cell.contentView addSubview:lineView];
    
    //勾的图片
    UIImage *check = [UIImage imageNamed:@"28_gou_1.png"];
    UIImageView *checkView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, check.size.width/2, check.size.height/2)];
    [checkView setImage:check];
    if (indexPath.row == nowIndex) {
        cell.accessoryView = checkView;
    }
    else if (indexPath.row == lastIndex){
        cell.accessoryView = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    lastIndex = nowIndex;
    nowIndex = indexPath.row;
    
    NSLog(@"====%d",nowIndex);
    NSLog(@"----%d",lastIndex);
    [remindTable reloadData];
}
#pragma  -mark -doClickAction
- (void)done:(UIButton*)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:nowIndex] forKey:@"RemindIndex"];
    [[NSUserDefaults standardUserDefaults]setObject:[textArray objectAtIndex:nowIndex] forKey:@"RemindTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
