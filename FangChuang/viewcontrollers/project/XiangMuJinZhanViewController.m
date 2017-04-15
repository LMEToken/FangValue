//
//  XiangMuJinZhanViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//项目进展
#import "XiangMuJinZhanViewController.h"
#import "JinZhanXiangQingViewController.h"
#import "SQLite.h"
#define KUIFont  "FZLanTingHeiS-R-GB"
@interface XiangMuJinZhanViewController ()

@end

@implementation XiangMuJinZhanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self setTitle:@"项目进展"];
	
    currentPage = 1;
    haoYoutableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) pullingDelegate:self];
    [haoYoutableView setBackgroundColor:[UIColor clearColor]];
    [haoYoutableView setShowsVerticalScrollIndicator:NO];
    haoYoutableView.dataSource=self;
    haoYoutableView.delegate=self;
    [self.contentView addSubview:haoYoutableView];

    array = [[NSMutableArray alloc] init];
    [[NetManager sharedManager] getallproboardWithuserid:[[UserInfo sharedManager] username]
                                                 perpage:@"20"
                                                  pageid:[NSString stringWithFormat:@"%d",currentPage]
                                                  hudDic:nil
                                                 success:^(id responseDic) {
                                                     NSLog(@"response=%@",responseDic);
                                                     if ([responseDic objectForKey:@"data"]) {
                                                         NSArray* data = [responseDic objectForKey:@"data"];
                                                         
                                                         
                                                         //存储到本地
                                                         for (int i = 0; i < data.count; i++) {
                                                             
                                                             NSDictionary* dic = [data objectAtIndex:i];
                                                             
                                                             [SQLite setProjectName:[dic objectForKey:@"name"]
                                                                              order:[dic objectForKey:@"order"]
                                                                            is_read:[dic objectForKey:@"is_read"]
                                                                            plan_id:[dic objectForKey:@"plan_id"]
                                                                               date:[dic objectForKey:@"date"]];
                                                             
                                                         }
                                                         
                                                         
                                                         
                                                            [array addObjectsFromArray:[SQLite getProject]] ;
                                                         [haoYoutableView reloadData];
                                                     }
                                                     
                                                 } fail:^(id errorString) {
                                                     
                                                     [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
                                                     
                                                 }];
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
#pragma -mark  -UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
    //    return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellString=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellString];
    
    NSDictionary* dic = nil;
    if (array.count > indexPath.row) {
        dic = [array objectAtIndex:indexPath.row];
    }
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
        //cell背景框
        UIImage* bcImg = [UIImage imageNamed:@"74fangchuangguwen_sousuo_bg"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];

        //日期
        NSString *date = [dic objectForKey:@"date"];
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"- "];
        NSString *riQi = [[date componentsSeparatedByCharactersInSet:set] objectAtIndex:2];
        
        UILabel *riqilab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
        [riqilab setBackgroundColor:[UIColor clearColor]];
        [riqilab setText:riQi];
        [Utils setDefaultFont:riqilab size:26];
        [riqilab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:riqilab];

        
        
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
        
        //月份
        UILabel *yuefenlab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(riqilab.frame), 18, 40, 15)];
        [yuefenlab setBackgroundColor:[UIColor clearColor]];
        [Utils setDefaultFont:yuefenlab size:13];
        [yuefenlab setText:yue];
        [yuefenlab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:yuefenlab];
        
        //内容背景框
        UIImage* bcimage = [UIImage imageNamed:@"ic_frame_bg5"];
        UIImageView* bcImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(190/2, 25/2, 425/2, 90/2)];
        [bcImg1 setImage:bcimage];
        [cell.contentView addSubview:bcImg1];

        //项目进展内容
        NSString *content = [NSString stringWithFormat:@"【项目进展】%@",[dic objectForKey:@"name"]];
        CGSize contentSize = [content sizeWithFont:[UIFont fontWithName:@KUIFont size:14] constrainedToSize:CGSizeMake(425/2-10, 9999) lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *xingminglab=[[UILabel alloc]initWithFrame:CGRectMake(190/2+5, 25/2+5, contentSize.width, contentSize.height)];
        [xingminglab setBackgroundColor:[UIColor clearColor]];
        [xingminglab setNumberOfLines:0];
        [xingminglab setLineBreakMode:NSLineBreakByWordWrapping];
        //        //[Utils setDefaultFont:xingminglab size:14];
        [xingminglab setFont:[UIFont fontWithName:@KUIFont size:14]];
        [xingminglab setText:content];
        [xingminglab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:xingminglab];
        /*
         未读状态
         */
        
        if ([[dic objectForKey:@"is_read"] intValue]) {
            //未读
          //  UIImage *image2=[UIImage imageNamed:@"ic_unread"];
             UIImage *image2=[UIImage imageNamed:@"isRead"];
            UIImageView *ztImage2=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(riqilab.frame)+5, 67/2, 19/2)];
            [ztImage2 setImage:image2];
            [cell.contentView addSubview:ztImage2];
        }
        else
        {
            //2014.07.04 chenlihua 
            //已读 (黄色已经是已读了，为切图的时候，忘记把未读改成已读）
          //  UIImage *image=[UIImage imageNamed:@"ic_read"];
            UIImage *image=[UIImage imageNamed:@"ic_unread"];
            
            UIImageView *ztImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(riqilab.frame)+5, 67/2, 19/2)];
            [ztImage setImage:image];
            [cell.contentView addSubview:ztImage];

        }
        /*
         已读状态
         */
    }
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"row=%d ,section=%d",indexPath.row,indexPath.section);
    
    NSMutableDictionary* dic = [array objectAtIndex:indexPath.row];
    [dic setObject:@"1" forKey:@"is_read"];
    [SQLite setReadWithPlan_id:[dic objectForKey:@"plan_id"]];
    
    [haoYoutableView reloadData];
    
    JinZhanXiangQingViewController* vc = [[JinZhanXiangQingViewController alloc] init];
    vc.proid = [[array objectAtIndex:indexPath.row] objectForKey:@"plan_id"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
