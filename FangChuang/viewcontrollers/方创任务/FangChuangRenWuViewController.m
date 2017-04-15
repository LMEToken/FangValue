//
//  FangChuangRenWuViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//方创任务
#import "FangChuangRenWuViewController.h"
#import "FangChuangRenwuOKViewController.h"
#import "SQLite.h"
@interface FangChuangRenWuViewController ()

@end

@implementation FangChuangRenWuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadData
{
    [[NetManager sharedManager]getAllTaskWithUsername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        NSLog(@"responseDic=%@",responseDic);
        if([responseDic isKindOfClass:[NSDictionary class]])
        {
            NSArray* arr = [responseDic objectForKey:@"data"];
            for (int i = 0; i < arr.count; i ++) {
                NSDictionary* dic = [arr objectAtIndex:i];
               [SQLite setRenWuName:[dic objectForKey:@"name"]
                              order:[dic objectForKey:@"order"]
                            is_read:[dic objectForKey:@"is_check"]
                            plan_id:[dic objectForKey:@"plan_id"]
                               date:[dic objectForKey:@"date"]];
            }
        }
        [dataArray addObjectsFromArray:[SQLite getRenWu]];
        [haoYoutableView reloadData];
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [[NetManager sharedManager] getrecenttaskWithuserid:[[UserInfo sharedManager] userid]
//                                                 hudDic:nil
//                                                success:^(id responseDic) {
//                                                    NSLog(@"responseDic=%@",responseDic);
//                                                } fail:^(id errorString) {
//
//                                                }];
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self setTitle:@"方创任务"];
	
    dataArray = [[NSMutableArray alloc]init];
    [self loadData];
    
    currentPage = 1;
    haoYoutableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) pullingDelegate:self];
    [haoYoutableView setBackgroundColor:[UIColor clearColor]];
    [haoYoutableView setShowsVerticalScrollIndicator:NO];
    haoYoutableView.dataSource=self;
    haoYoutableView.delegate=self;
    [self.contentView addSubview:haoYoutableView];
    
//    array = [[NSMutableArray alloc] init];
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
#pragma  -mark UITableView Delegate
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
    NSDictionary *dic =[dataArray objectAtIndex:indexPath.row];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellString];
        //cell背景图片
        UIImage* bcImg = [UIImage imageNamed:@"74fangchuangguwen_sousuo_bg"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];
        
        
        NSString *date = [dic objectForKey:@"date"];
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"- "];
        NSString *riQi = [[date componentsSeparatedByCharactersInSet:set] objectAtIndex:2];
        //日期
        UILabel *riqilab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
        [riqilab setBackgroundColor:[UIColor clearColor]];
        [riqilab setText:riQi];
        [Utils setDefaultFont:riqilab size:26];
        [riqilab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:riqilab];
        
        //月份
        NSString *yueFen = [[date componentsSeparatedByCharactersInSet:set] objectAtIndex:1];
        NSString *yue = [[yueFen componentsSeparatedByString:@"0"] lastObject];
        //int yue = [yueFen intValue];
        switch ([yue intValue]) {
            case 1:
                yue = [NSString stringWithFormat:@"%@",@"一月"];
                break;
            case 2:
                yue = [NSString stringWithFormat:@"%@",@"二月"];
                break;
            case 3:
                yue = [NSString stringWithFormat:@"%@",@"三月"];
                break;
            case 4:
                yue = [NSString stringWithFormat:@"%@",@"四月"];
                break;
            case 5:
                yue = [NSString stringWithFormat:@"%@",@"五月"];
                break;
            case 6:
                yue = [NSString stringWithFormat:@"%@",@"六月"];
                break;
            case 7:
                yue = [NSString stringWithFormat:@"%@",@"七月"];
                break;
            case 8:
                yue = [NSString stringWithFormat:@"%@",@"八月"];
                break;
            case 9:
                yue = [NSString stringWithFormat:@"%@",@"九月"];
                break;
                
            case 11:
                yue = [NSString stringWithFormat:@"%@",@"十一月"];
                break;
            case 12:
                yue = [NSString stringWithFormat:@"%@",@"十二月"];
                break;
            default:
                break;
        }
        switch ([yueFen intValue]) {
            case 10:
                yue = [NSString stringWithFormat:@"%@",@"十月"];
                break;
            default:
                break;
        }
        
        //月份Label
        UILabel *yuefenlab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(riqilab.frame), 18, 40, 15)];
        [yuefenlab setBackgroundColor:[UIColor clearColor]];
        [Utils setDefaultFont:yuefenlab size:13];
        [yuefenlab setText:yue];
        [yuefenlab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:yuefenlab];

        //任务内容背景框
        UIImage* bcimage = [UIImage imageNamed:@"shangdaohangtiao_1"];
        UIImageView* bcImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(190/2, 25/2, 425/2, 90/2)];
        [bcImg1 setImage:bcimage];
        [cell.contentView addSubview:bcImg1];

        //任务内容Label
        UILabel *xingminglab=[[UILabel alloc]initWithFrame:CGRectMake(190/2, 25/2, 425/2, 90/2)];
        [xingminglab setBackgroundColor:[UIColor clearColor]];
        [xingminglab setNumberOfLines:0];
        //        [Utils setDefaultFont:xingminglab size:12];
        [xingminglab setFont:[UIFont fontWithName:KUIFont size:14]];
        [xingminglab setText:[NSString stringWithFormat:@"【方创任务】:%@",[[dataArray objectAtIndex:indexPath.row] objectForKey:@"name"]] ];
        [xingminglab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:xingminglab];

        //已审核背景图
        UIImage *image=[UIImage imageNamed:@"09_tiao_1"];
        UIImageView *ztImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(riqilab.frame)+5, 67/2, 19/2)];
        [ztImage setImage:image];
        [cell.contentView addSubview:ztImage];

        //审核Label
        UILabel *wdztlab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(riqilab.frame)+5, 67/2, 19/2)];
        [wdztlab setBackgroundColor:[UIColor clearColor]];
        [wdztlab setTextColor:[UIColor whiteColor]];
        [Utils setDefaultFont:wdztlab size:10];
        if([[[dataArray objectAtIndex:indexPath.row] objectForKey:@"is_check"]isEqualToString:@"0"])
        {
          [wdztlab setText:@"待审核"];
        }
        else
          [wdztlab setText:@"已审核"];
        [cell.contentView addSubview:wdztlab];
        //        已读状态
        //        UIImage *image2=[UIImage imageNamed:@"09_tiao_2"];
        //        UIImageView *ztImage2=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(riqilab.frame)+5, 67/2, 19/2)];
        //        [ztImage2 setImage:image2];
        //        [cell.contentView addSubview:ztImage2];
        //        [ztImage2 release];
        //
        //        UILabel *ztlab2=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(riqilab.frame)+5, 67/2, 19/2)];
        //        [ztlab2 setBackgroundColor:[UIColor clearColor]];
        //        [ztlab2 setTextColor:[UIColor whiteColor]];
        //        [Utils setDefaultFont:ztImage2 size:10];
        //        [ztlab2 setText:@"待审核"];
        //        [cell.contentView addSubview:ztlab2];
        //        [ztlab2 release];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"row=%d ,section=%d",indexPath.row,indexPath.section);
    
    NSMutableDictionary* dic = [dataArray objectAtIndex:indexPath.row];
    [dic setObject:@"1" forKey:@"is_check"];
    [tableView reloadData];
    
    [SQLite setCheckWithPlan_id:[dic objectForKey:@"plan_id"]];
    
     FangChuangRenwuOKViewController* viewController = [[FangChuangRenwuOKViewController alloc] init];
    viewController.taskid = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"plan_id"];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
