//
//  ProjectMainTableViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//项目主页面

//项目部分主页面
#import "ProjectMainTableViewController.h"
//筛选页面
#import "ProjectMainRightSearchViewController.h"
//单元格页面
#import "ProjectMainTableViewCell.h"
//详细页面
#import "FvaProCellDetailVC.h"
//缓存图片
#import "UIImageView+WebCache.h"


@interface ProjectMainTableViewController ()
@end

@implementation ProjectMainTableViewController
@synthesize whereFlag;
@synthesize searchString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    //开始进入时，刷新界面，默认为关注
   
    NSLog(@"--currentPage--%i",currentPage);

    NSString *indexString=[[NSUserDefaults standardUserDefaults]objectForKey:@"index"];
    if (!indexString) {
        
        indexString=@"1";
 
        NSUserDefaults *indexDefault=[NSUserDefaults standardUserDefaults];
        [indexDefault setObject:@"1" forKey:@"index"];
        [indexDefault synchronize];
       
    }
    NSLog(@"-11-indexString--%@",indexString);
    
    //0 不筛选 1筛选
    if ([whereFlag isEqualToString:@"1"]) {
        [self loadData:indexString WithRflag:@"1" WithRpara:searchString WithCurrentPage:[NSString stringWithFormat:@"%i",currentPage]];
    }else{
        [self loadData:indexString WithRflag:@"0" WithRpara:@"0" WithCurrentPage:[NSString stringWithFormat:@"%i",currentPage]];
    }
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //标题
    [self setTitle:@"项目"];
    
    //右侧按钮
    [self initRightButton];
    
    //添加切换栏
    [self initTopButtonView];
    
    //UITableView
    [self initTableView];
    
    //使工具栏显示
    [self setTabBarIndex:1];
}

#pragma -mark -functions
//项目部分右侧按钮
-(void)initRightButton
{
       
    UIButton *enLargeRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [enLargeRightButton setFrame:CGRectMake(200, -14, 120, 59)];
    [enLargeRightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    enLargeRightButton.backgroundColor=[UIColor clearColor];
    [self addRightButton:enLargeRightButton isAutoFrame:NO];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(66, 28, 19, 16)];
    [rightButton setImage:[UIImage imageNamed:@"project-right-button"] forState:UIControlStateNormal];
    rightButton.backgroundColor=[UIColor clearColor];
    [rightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [enLargeRightButton addSubview:rightButton];
    

}
//添加切换栏
-(void)initTopButtonView
{
    TopButtonView = [[ProjectMainTopButtonView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) delegate:self];
    [self.contentView addSubview:TopButtonView];
}
-(void)initTableView
{
    
    myTableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, TopButtonView.frame.origin.y+TopButtonView.frame.size.height, self.contentView.frame.size.width, self.contentView.frame.size.height-TopButtonView.frame.size.height)];
   [myTableView setHeaderOnly:YES];
    myTableView.backgroundColor=[UIColor whiteColor];
    myTableView.separatorStyle=UITableViewCellSelectionStyleNone;
    myTableView.dataSource=self;
    myTableView.delegate=self;
    currentPage=1;
    [self.contentView addSubview:myTableView];
}
//下载数据
-(void)loadData:(NSString *)index WithRflag:(NSString *)rflag WithRpara:(NSString *)rpara WithCurrentPage:(NSString *)page
{
    NSLog(@"--loadData---");
    
    //从服务器取数据。从服务器返回项目的题目，内容，地点，性质，约见的内容，粉丝的内容，浏览的内容，团队人数的内容。
    //从服务器返回的项目中要区分，关注，融资，并购的参数。
    
    
    NSLog(@"-----username--%@",[[UserInfo sharedManager] username]);
    NSLog(@"-----apptoken--%@",[[UserInfo sharedManager] apptoken]);
    
    [[NetManager sharedManager] getProjectListWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken]   tabflag:index rflag:rflag rpara:rpara perpage:@"20" pagenum:page hudDic:nil success:^(id responseDic) {
        NSLog(@"-project--responseDic--%@",responseDic);
        NSDictionary *dic = [responseDic objectForKey:@"data"];
        dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"projectlist"]];
        NSLog(@"-project-dataArray--%@",dataArray);
        NSLog(@"--project-dataArray.count---%i",dataArray.count);
        
        [myTableView reloadData];
        
    } fail:^(id errorString) {
        NSLog(@"-project--errString-%@",errorString);
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:errorString delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
    
}
#pragma -mark -doClickAction
-(void)doClickRightButton:(UIButton *)btn
{
    
    ProjectMainRightSearchViewController *searchView=[[ProjectMainRightSearchViewController alloc]init];
    searchView.whereFromString=CLH_NSSTRING_PROJECT_RIGHT_SEARCH_VIEW;
    [self.navigationController pushViewController:searchView animated:NO];
    
 }

#pragma -mark -ProjectMainTopButtonViewDelegate
- (void)buttonViewSelectIndex:(int)index buttonView:(ProjectMainTopButtonView *)view
{
    NSLog(@"------index---%d---",index);
    
    NSString *indexStr=[NSString stringWithFormat:@"%i",index+1] ;
    
    NSUserDefaults *indexDefault=[NSUserDefaults standardUserDefaults];
    [indexDefault setObject:indexStr forKey:@"index"];
    [indexDefault synchronize];
    
    [self loadData:indexStr WithRflag:@"0" WithRpara:@"0" WithCurrentPage:[NSString stringWithFormat:@"%i",currentPage]];
}
#pragma -mark -UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"---dataArray.count--%d",dataArray.count);
    return dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strID=@"cell";
    ProjectMainTableViewCell *cell=(ProjectMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:strID];
    if (nil==cell) {
        cell=[[ProjectMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    /*
     browse = 0;
     city = "";
     fans = 0;
     frounds = A;
     frounds2 = "<null>";
     id = 10068;
     projectclicknum = 0;
     projectindustry = "";
     projectmoney = "$1000.00\U4e07";
     projectname = "XX\U4e16\U5bb6";
     projectpicture = "";
     projectposition = "\U662f\U8282\U80fd\U964d\U8017\U6574\U4f53\U89e3\U51b3\U65b9\U6848\U63d0\U4f9b\U5546\Uff0c\U4e3b\U8425\U5de5\U4e1a\U81ea\U52a8\U5316\U884c\U4e1a\U7684\U7cfb\U7edf\U96c6\U6210\U53ca\U76f8\U5173\U4eea\U5668\U4eea\U8868\U7684\U7814\U53d1\U3001\U751f\U4ea7\U548c\U9500\U552e";
     projectstatus = 0;
     rs = 0;
     statge = 1;
     teams = 0;
*/
   [cell.headImageView setImageWithURL:[NSURL URLWithString:[[dataArray objectAtIndex:indexPath.row]objectForKey:@"projectpicture"]] placeholderImage:[UIImage imageNamed:@"project-main-headImage"]];
    cell.projectTitleLabel.text=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"projectname"];
    cell.contentLabel.text=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"projectposition"];
    cell.placeLabel.text=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"city"];
       [cell propertyWith:[[dataArray objectAtIndex:indexPath.row]objectForKey:@"projectindustry"]];
    cell.meetContentLabel.text=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"rs"];
    cell.funsContentLabel.text=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"fans"];
    cell.lookContentLabel.text=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"browse"];
    cell.teamMemberConentLabel.text=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"teams"];
    cell.placeLabel.text=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"city"];
    NSString *islike=[NSString stringWithFormat:@"%@",[[dataArray objectAtIndex:indexPath.row]objectForKey:@"islike"]];
    
    cell.attentionLabel.text=[islike isEqualToString:@"0"]?@"未关注":@"已关注";
    //当时投资者的时候可以点击，当时创业者的时候不能点击
    if ([[[UserInfo sharedManager] diffID]isEqualToString:@"1"])
    {
        cell.attentionLabel.userInteractionEnabled=YES;

    }else{
        cell.attentionLabel.userInteractionEnabled=NO;
    }
    cell.attentionLabel.tag=indexPath.row;
    
    //单击的手势
    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap: )];
    tapRecognize.numberOfTapsRequired = 1;
    tapRecognize.delegate = self;
    [tapRecognize setEnabled :YES];
    [tapRecognize delaysTouchesBegan];
    [tapRecognize cancelsTouchesInView];
    
    [cell.attentionLabel addGestureRecognizer:tapRecognize];
    
    
    return cell;
    
}
//单击手势的添加
-(void) handleTap:(UITapGestureRecognizer *)recognizer{
    NSLog(@"---单击手势-------");
    
   
    UIView *tapView = recognizer.view;
    NSLog(@"--tapView.tag--%i",tapView.tag);
    
    NSLog(@"---username--%@",[[UserInfo sharedManager] username]);
    NSLog(@"---apptoken--%@",[[UserInfo sharedManager] apptoken]);
    NSLog(@"--rflag--%@",[[dataArray objectAtIndex:tapView.tag]objectForKey:@"islike"]);
    NSLog(@"--projectid--%@",[[dataArray objectAtIndex:tapView.tag]objectForKey:@"id"]);
    
    //先判断是不是投资人，若是，调用接口。若不是，弹出提示，说不能点击。
    
    //调用服务器的接口
    //必须是以i打头的用户.i001，投资人
    if ([[[dataArray objectAtIndex:tapView.tag]objectForKey:@"islike"] isEqualToString:@"1"]) {
        
        [[NetManager sharedManager] getProjectLikeWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"0"  projectid:[[dataArray objectAtIndex:tapView.tag]objectForKey:@"id"]  hudDic:nil success:^(id responseDic)
         {
             NSLog(@"---getlike responsedDic---%@",responseDic);
             
            NSString *indexString=[[NSUserDefaults standardUserDefaults]objectForKey:@"index"];
             
            [self loadData:indexString WithRflag:@"0" WithRpara:@"0" WithCurrentPage:[NSString stringWithFormat:@"%i",currentPage]];
             
         } fail:^(id errorString) {
             NSLog(@"---errorString---%@",errorString);
         }];

    }else{
        [[NetManager sharedManager] getProjectLikeWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"1"  projectid:[[dataArray objectAtIndex:tapView.tag]objectForKey:@"id"]  hudDic:nil success:^(id responseDic)
         {
             NSLog(@"---getlike responsedDic---%@",responseDic);
             
             NSString *indexString=[[NSUserDefaults standardUserDefaults]objectForKey:@"index"];
             
             [self loadData:indexString WithRflag:@"0" WithRpara:@"0" WithCurrentPage:[NSString stringWithFormat:@"%i",currentPage]];
             
         } fail:^(id errorString) {
             NSLog(@"---errorString---%@",errorString);
         }];

    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FvaProCellDetailVC  *detailView=[[FvaProCellDetailVC alloc]init];
    detailView.projectId=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"id"];
   [self.navigationController pushViewController:detailView animated:NO];
}
#pragma  -mark -pullingrefreshTableView delegate
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    currentPage++;
    
    NSString *indexString=[[NSUserDefaults standardUserDefaults]objectForKey:@"index"];
    if ([whereFlag isEqualToString:@"1"]) {
        [self loadData:indexString WithRflag:@"1" WithRpara:searchString WithCurrentPage:[NSString stringWithFormat:@"%i",currentPage]];
    }else{
        [self loadData:indexString WithRflag:@"0" WithRpara:@"0" WithCurrentPage:[NSString stringWithFormat:@"%i",currentPage]];
    }

    [myTableView tableViewDidFinishedLoading];
}
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    currentPage=1;
    
    NSString *indexString=[[NSUserDefaults standardUserDefaults]objectForKey:@"index"];
    if ([whereFlag isEqualToString:@"1"]) {
        [self loadData:indexString WithRflag:@"1" WithRpara:searchString WithCurrentPage:[NSString stringWithFormat:@"%i",currentPage]];
    }else{
        [self loadData:indexString WithRflag:@"0" WithRpara:@"0" WithCurrentPage:[NSString stringWithFormat:@"%i",currentPage]];
    }

    [myTableView tableViewDidFinishedLoading];
}
#pragma -mark -UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [myTableView tableViewDidEndDragging:scrollView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [myTableView tableViewDidScroll:scrollView];
}

@end
