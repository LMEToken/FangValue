//
//  QiYeTuanDuiViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-2.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//团队

#import "QiYeTuanDuiViewController.h"
#import "JianJieViewController.h"
#import "MineInFoemationViewController.h"
#import "CacheImageView.h"
@interface QiYeTuanDuiViewController ()

@end

@implementation QiYeTuanDuiViewController
@synthesize proid=_proid;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadData
{
 [[NetManager sharedManager]getproteamWithUsername:[[UserInfo sharedManager] username]
                                         projectid:self.proid
                                            hudDic:Nil
                                           success:^(id responseDic) {
                                               dataArray=[[NSMutableArray alloc]initWithArray:[[responseDic objectForKey:@"data"] objectForKey:@"proteam"]];
                                               [haoYoutableView reloadData];
                                           }
                                              fail:^(id errorString) {
                                                  
                                              } ];


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleLabel setText:@"团队"];
    [self setTabBarHidden:YES];
    [self addBackButton];
    [self loadData];
    
    //UITableView
    currentPage = 1;
    haoYoutableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) pullingDelegate:self];
    [haoYoutableView setBackgroundColor:[UIColor clearColor]];
    [haoYoutableView setShowsVerticalScrollIndicator:NO];
    haoYoutableView.dataSource=self;
    haoYoutableView.delegate=self;
    [self.contentView addSubview:haoYoutableView];
    
    [haoYoutableView setHeaderOnly:YES];
    
    array=[NSArray arrayWithObjects:@"企业团队",@"方创团队",@"投资人", nil];
}
#pragma  -mark -PullingRefreshTabelView Delegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [haoYoutableView tableViewDidEndDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [haoYoutableView tableViewDidScroll:scrollView];
}
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    currentPage++;
    //[self loadData];
    [tableView tableViewDidFinishedLoading];
}
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    currentPage=1;
    //[self loadData];
    [tableView tableViewDidFinishedLoading];
}
#pragma  -mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
    //    return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellString=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellString];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellString];
        
        //背景图片
        UIImage* bcImg = [UIImage imageNamed:@"60_kuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];

        
       // [[dataArray objectAtIndex:indexPath.row] objectForKey:@"picurl"]
        //添加头像
        UIImage *image=[UIImage imageNamed:@"61_touxiang_1"];
        UIImageView *headerImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        [headerImage setImage:image];
        [cell.contentView addSubview:headerImage];

        //头像点击不用
//        
//        UIButton *headBut=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
//        [headBut setBackgroundColor:[UIColor clearColor]];
//        [headBut addTarget:self action:@selector(JianJieEvent:) forControlEvents:UIControlEventTouchUpInside];
//        headBut.tag=indexPath.row;
//        [cell.contentView addSubview:headBut];
//        [headBut release];
        
        //ID Label
        UILabel *idlab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 5, 25, 20)];
        [idlab setBackgroundColor:[UIColor clearColor]];
        [idlab setText:@"ID:"];
        [Utils setDefaultFont:idlab size:16];
        [idlab setTextColor:[UIColor orangeColor]];
        [cell.contentView addSubview:idlab];

        //姓名 Label
        UILabel *xingminglab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 25, 40, 20)];
        [xingminglab setBackgroundColor:[UIColor clearColor]];
        [xingminglab setText:@"姓名:"];
        [Utils setDefaultFont:xingminglab size:16];
        [xingminglab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:xingminglab];

        //英文名 Label
        UILabel *yingwenlab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 45, 60, 20)];
        [yingwenlab setBackgroundColor:[UIColor clearColor]];
        [yingwenlab setText:@"英文名:"];
        [Utils setDefaultFont:yingwenlab size:16];
        [yingwenlab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:yingwenlab];

        //ID内容Label
        UILabel *iDlab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(idlab.frame)+5, 5, 120, 20)];
        [iDlab setBackgroundColor:[UIColor clearColor]];
        [iDlab setTextColor:[UIColor clearColor]];
        [iDlab setText:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"id"]];
        [Utils setDefaultFont:idlab size:16];
        [iDlab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:iDlab];

        //姓名内容Label
        UILabel *xingmlab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(xingminglab.frame)+5, 25, 120, 20)];
        [xingmlab setBackgroundColor:[UIColor clearColor]];
        [xingmlab setText:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
        [Utils setDefaultFont:xingmlab size:16];
        [xingmlab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:xingmlab];

        //英文名内容Label
        UILabel *yingwenmlab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yingwenlab.frame)+5, 45, 120, 20)];
        [yingwenmlab setBackgroundColor:[UIColor clearColor]];
        [yingwenmlab setText:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"ename"]];
        [Utils setDefaultFont:yingwenmlab size:16];
        [yingwenmlab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:yingwenmlab];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineInFoemationViewController *view=[[MineInFoemationViewController alloc]init];
    view.dic=[dataArray objectAtIndex:indexPath.row];
    //把编辑按钮去掉
    [view removeEditButton];
    [self.navigationController pushViewController:view animated:YES];

//    NSLog(@"row=%d ,section=%d",indexPath.row,indexPath.section);
//    
//    LianXiRenViewController *view=[[LianXiRenViewController alloc]init];
//    [self.navigationController pushViewController:view animated:YES];
//    [view release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
