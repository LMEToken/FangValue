//
//  FvaProCompanInVC.m
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaProCompanInVC.h"

@interface FvaProCompanInVC ()

@end

@implementation FvaProCompanInVC

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
    [self setTitle:@"公司简介"];
    
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self addTableview];
    // Do any additional setup after loading the view.
}
- (void)addTableview
{
    self.CompanTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 500) style:UITableViewStylePlain];
    //UITableViewStylePlain];
    [self.CompanTableview setDelegate:self];
    [ self.CompanTableview setDataSource:self];
    [self.CompanTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.contentView addSubview:self.CompanTableview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark -doClickAction
//返回
//- (void)backButtonAction:(UIButton*)sender
//{
//
//    [self.navigationController popViewControllerAnimated:NO];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - TableVIewDelegete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.datadic);
    NSArray *cellarr = [NSArray arrayWithObjects:@"项目介绍 :",@"投资亮点:",@"公司阶段 :",@"团队介绍 :",nil];
    FvaProDetailCell *cell = [[FvaProDetailCell alloc]init];
    UIImageView *cellline = [[UIImageView alloc]initWithFrame:CGRectMake(90, 0, 300, 1)];
    cellline.image = [UIImage imageNamed:@"cellfenge"];
    [cell addSubview:cellline];
    
//    
//    cell.detailetext.text = @"动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据";
   cell.heradlable.text = [cellarr objectAtIndex:indexPath.row];

//    if (indexPath.row ==3) {
//    cell.detailetext.text = @"动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据动态数据";

    if (indexPath.row==0) {
        cell.detailetext.text = [self.datadic objectForKey:@"position"];
    }
    if (indexPath.row==1) {
        cell.detailetext.text =  [self.datadic objectForKey:@"factor"];
    }
    if (indexPath.row==2) {
        cell.detailetext.text =  [self.datadic objectForKey:@"statge"];
    }
    if (indexPath.row ==3) {
        cell.detailetext.text =  [self.datadic objectForKey:@"proteam"];
    }
//    cell.detailetext.frame=CGRectMake(90, 5, 230, cell.detailetext.text.length+10);
    cell.detailetext.frame=CGRectMake(90, 5, 230, cell.detailetext.text.length+30);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *a = [self.datadic objectForKey:@"proteam"];
    if (indexPath.row==3) {
        return a.length+30;
    }
    return 80;
}



@end
