//
//  NotifyVC.m
//  FangChuang
//
//  Created by weiping on 14-11-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "NotifyVC.h"
#import "FangChuangInsiderViewController.h"
@interface NotifyVC ()

@end

@implementation NotifyVC

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
    [self setTitle:@"通知"];
    [self setTabBarHidden:YES];
    [self addTableView];
    [self addBackButton];
//    [self addbackview];
    // Do any additional setup after loading the view.
}
-(void)addTableView
{
    self.Notiftytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height) style:UITableViewStylePlain];
    [self.Notiftytableview setDelegate:self];
    [ self.Notiftytableview setDataSource:self];
    [self.contentView addSubview:self.Notiftytableview];
    
   [self.Notiftytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *dename = [NSArray arrayWithObjects:@"gongsigonggao",@"xiangmutongz",@"rcheng",@"renwu",@"dongtai", nil];
    NSArray *typename = [NSArray arrayWithObjects:@"公司公告",@"项目通知",@"日程",@"任务",@"通告", nil];
    FaFinancierWelcomeItemCell *cell=[[FaFinancierWelcomeItemCell alloc]init];
    cell.bcImgV.hidden = NO;
    [cell.titleLab setText:[typename objectAtIndex:indexPath.row]];
    [cell.avatar setImage:[UIImage imageNamed:[dename objectAtIndex:indexPath.row]]];
    cell.subTitleLab.text=@"";
//    [cell.unReadLabel setHidden:NO];
//    UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 1)];
//    myview.image = [UIImage imageNamed:@"celllin@2x"];
//    [cell addSubview:myview];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
