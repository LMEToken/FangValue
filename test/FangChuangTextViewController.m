//
//  FangChuangTextViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-8-12.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FangChuangTextViewController.h"

@interface FangChuangTextViewController ()

@end

@implementation FangChuangTextViewController

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
    
    [self initView];
    
}

#pragma -mark -functions

-(void)initView
{
    self.view.backgroundColor=[UIColor orangeColor];
    
    [self initBackButton];
    [self initTestTitle];
    [self initTableView];
    [self initDataArray];
}
-(void)initBackButton
{
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame=CGRectMake(10, 10, 50, 50);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget: self action:@selector(doClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}
-(void)initTestTitle
{
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.frame=CGRectMake(130, 10, 100, 50);
    titleLabel.text=@"单元测试";
    [self.view addSubview:titleLabel];

}
-(void)initTableView
{
    UITableView *listTabel=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, 320, 640)];
    listTabel.delegate=self;
    listTabel.dataSource=self;
    [self.view addSubview:listTabel];
}

-(void)initDataArray
{
    testDataArr=[[NSMutableArray alloc]initWithObjects:@"1,网络连接正常，消息发送成功，服务器返回接收成功的消息",@"2,网络连接正常，消息发送成功，服务器无返回信息（或强制清除返回的信息）",@"3,网络连接异常（断网或输入非法连接参数），让消息发送失败",@"4,恢复网络连接设置，点击发送失败的消息标志，重发失败的消息", nil];
}

#pragma -mark -doClickButton
-(void)doClickBackButton:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma -mark -UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [testDataArr count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(nil==cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[testDataArr objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines=0;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        oneViewController=[[TestOneViewController alloc]init];
        [self.navigationController pushViewController:oneViewController animated:YES];
    }else if(indexPath.row==1){
        twoViewController=[[TestTwoViewController alloc]init];
        [self.navigationController pushViewController:twoViewController animated:YES];
    }else if (indexPath.row==2){
        threeViewController=[[TestThreeViewController alloc]init];
        [self.navigationController pushViewController:threeViewController animated:YES];
    }else if(indexPath.row==3){
        fourViewController=[[TestFourViewController alloc]init];
        [self.navigationController pushViewController:fourViewController animated:YES];
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
