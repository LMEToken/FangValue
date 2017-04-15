//
//  ProjectFinanceTabelViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-18.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//融资进程UITableView
#import "ProjectFinanceTabelViewController.h"
//增加
#import "ProjectFinanceRightAddViewController.h"
//单元格页面
#import "ProjectFinanceTableViewCell.h"
//详细信息页面
#import "ProjectFinanceTableViewCellDetailViewController.h"
//返回按钮
#import "FvaProCellDetailVC.h"
//缓存图片
#import "UIImageView+WebCache.h"



@implementation ProjectFinanceTabelViewController
@synthesize projectID;



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    
    NSString *indexString=[[NSUserDefaults standardUserDefaults]objectForKey:@"index-finance"];
    if (!indexString) {
        
        indexString=@"1";
        
        NSUserDefaults *indexDefault=[NSUserDefaults standardUserDefaults];
        [indexDefault setObject:@"1" forKey:@"index-finance"];
        [indexDefault synchronize];
        
    }

    //10084有数据
    [self loadData:projectID WithTabFlag:indexString];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //标题
    [self setTitle:@"融资进程"];
    
    //返回按钮
    [self addBackButton];
    
    //右侧按钮
    //新增模块暂时去掉
    //[self initRightButton];
    
    //添加切换栏
    [self initTopButtonView];
    
    //UITableView
    [self initTableView];
    
 
    
}

#pragma -mark -functions
//右侧按钮
-(void)initRightButton
{
    
    //右侧添加按钮
    
    UIButton *enLargeRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [enLargeRightButton setFrame:CGRectMake(200, -14, 120, 59)];
    [enLargeRightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    enLargeRightButton.backgroundColor=[UIColor clearColor];
    [self addRightButton:enLargeRightButton isAutoFrame:NO];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(66, 17, 44, 44)];
    [rightButton setTitle:@"新增" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont fontWithName:KUIFont size:16];
    [rightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor=[UIColor clearColor];
    [enLargeRightButton addSubview:rightButton];
    
}
//上面的栏中的数字
-(void)initNumberOfLabel
{
    if (!labelFirst) {
        labelFirst=[[UILabel alloc]initWithFrame:CGRectMake(68, 6, 25, 15)];
        labelFirst.backgroundColor=[UIColor clearColor];
        labelFirst.text=[NSString stringWithFormat:@"(%@)",[dic objectForKey:@"keynum"]];
        labelFirst.font=[UIFont fontWithName:KUIFont size:9];
        labelFirst.textColor=[UIColor orangeColor];
        [TopButtonView addSubview:labelFirst];
    }
    
    if (!labelSecond) {
        labelSecond=[[UILabel alloc]initWithFrame:CGRectMake(60+80, 6, 25, 15)];
        labelSecond.backgroundColor=[UIColor clearColor];
        labelSecond.text=[NSString stringWithFormat:@"(%@)",[dic objectForKey:@"rs"]];
        labelSecond.font=[UIFont fontWithName:KUIFont size:9];
        labelSecond.textColor=[UIColor orangeColor];
        [TopButtonView addSubview:labelSecond];
    }
   
    if (!labelThree) {
        labelThree=[[UILabel alloc]initWithFrame:CGRectMake(60+160, 6, 25, 15)];
        labelThree.backgroundColor=[UIColor clearColor];
        labelThree.text=[NSString stringWithFormat:@"(%@)",[dic objectForKey:@"invnum"]];
        labelThree.font=[UIFont fontWithName:KUIFont size:9];
        labelThree.textColor=[UIColor orangeColor];
        [TopButtonView addSubview:labelThree];

    }
    if (!labelFour) {
        labelFour=[[UILabel alloc]initWithFrame:CGRectMake(60+240, 6, 25, 15)];
        labelFour.backgroundColor=[UIColor clearColor];
        labelFour.text=[NSString stringWithFormat:@"(%@)",[dic objectForKey:@"refuse2"]];
        labelFour.font=[UIFont fontWithName:KUIFont size:9];
        labelFour.textColor=[UIColor orangeColor];
        [TopButtonView addSubview:labelFour];
    }
 }
//添加切换栏
-(void)initTopButtonView
{
    TopButtonView = [[ProjectFinanceTopButtonView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) delegate:self];
    [self.contentView addSubview:TopButtonView];
}
//初始化tableView
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
-(void)loadData:(NSString *)proectid WithTabFlag:(NSString *)tabFlag
{
    NSLog(@"-finance-loadData---");
    
    //从服务器取数据。从服务器返回项目的头像，详情，题目，属性；联系人；状态；上次联系；
    //从服务器返回的项目中要区分，重点跟进，已见面，已推时，已否决，的参数。
    
    [[NetManager sharedManager] getProjectInvestorWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] projectid:proectid tabflag:tabFlag hudDic:nil success:^(id responseDic) {
        NSLog(@"-finance-responseDic---%@--",responseDic);
        dic=[NSDictionary dictionaryWithDictionary:[responseDic objectForKey:@"data"]];
        dataArray=[[NSArray alloc]initWithArray:[dic objectForKey:@"retlist"]];
        NSLog(@"-finance-dic--%@--",dic);
        NSLog(@"-finance-dataArray--%@",dataArray);
        
        [myTableView reloadData];
        [self initNumberOfLabel];
                /*
         -finance-responseDic---{
         data =     {
         invnum = 0;
         keynum = 0;
         refuse2 = 1;
         retlist =         (  {
         "a_investors" = "\U8d3e\U5dcd ";
         focus = "<null>";
         name = "<null>";
         order = 1;
         pdate = "<null>";
         vfeedback = "<null>";
         },

         );
         rs = 0;
         };
         msg = ok;
         status = 0;
         }--       */
        
    } fail:^(id errorString) {
        NSLog(@"--finance-errorStrng---%@-",errorString);
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网络不太稳定，请稍等" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];

    }];
    
}
#pragma -mark -doClickAction
-(void)doClickRightButton:(UIButton *)btn
{
    ProjectFinanceRightAddViewController *addView=[[ProjectFinanceRightAddViewController alloc]init];
    addView.wherefrom=CLH_NSSTRING_FINANCE_DETAIL_CELL;
    addView.proID=projectID;
    [self.navigationController pushViewController:addView animated:NO];
}
- (void) backButtonAction : (id) sender
{
    
    FvaProCellDetailVC *detail=[[FvaProCellDetailVC alloc]init];
    detail.projectId=projectID;
    [self.navigationController pushViewController:detail animated:NO];
}

#pragma -mark -ProjectMainTopButtonViewDelegate
- (void)buttonViewSelectIndex:(int)index buttonView:(ProjectFinanceTopButtonView *)view
{
    NSLog(@"------index---%d---",index);
    
    NSString *indexStr=[NSString stringWithFormat:@"%i",index+1];
    
    
    NSUserDefaults *indexDefault=[NSUserDefaults standardUserDefaults];
    [indexDefault setObject:indexStr forKey:@"index-finance"];
    [indexDefault synchronize];

    [self loadData:projectID WithTabFlag:indexStr];
    
    
}
#pragma -mark -UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strID=@"cell";
   ProjectFinanceTableViewCell *cell=(ProjectFinanceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:strID];
    if (nil==cell) {
        cell=[[ProjectFinanceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    /*
     @property (nonatomic,strong) UIImageView *headImageView;
     @property (nonatomic,strong) UILabel *detailLabel;
     @property (nonatomic,strong) UILabel *TitleLabel;
     @property (nonatomic,strong) NSString *propertyString;
     @property (nonatomic,strong) NSMutableArray *propertyArray;
     @property (nonatomic,strong) UILabel *contactContentLabel;
     @property (nonatomic,strong) UILabel *stateContentLabel;
     @property (nonatomic,strong) UILabel *lastContactContentLabel;
     @property (nonatomic,strong) UILabel *psContentLabel;
     */
    /*
     "a_investors" = "\U5218\U7545 ";
     focus = "\U80fd\U6e90\U3001\U77ff\U4ea7\U3001\U519c\U4e1a\U98df\U54c1\U3001\U5148\U8fdb\U5236\U9020\U4e1a\U3001\U533b\U836f\U3001\U533b\U7597\U8bbe\U5907\U3001\U6709\U7ebf\U7f51\U7edc\U3001\U6587\U5316\U4f20\U5a92\U3001\U65b0\U80fd\U6e90\U3001\U65b0\U6750\U6599\U3001\U5efa\U7b51\U5efa\U6750\U3001\U4fe1\U606f\U6280\U672f\U3001\U5546\U4e1a\U8fde\U9501\U3001\U6d88\U8d39\U54c1\U3001\U5546\U4e1a\U94f6\U884c\U7b49";
     name = "\U4e2d\U79d1\U62db\U5546";
     order = 1;
     pdate = "2012-08-22";
     vfeedback = "\U6881\U603b\U672c\U4eba\U770b\U597d\U8fd9\U4e2a\U9879\U76ee\Uff0c\U4f46\U51fa\U4ef7\U662f\U6309\U71672012\U5e74\U5ba1\U8ba1\U540e\U51c0\U5229\U6da6\U76848\U500d\U3002\U5177\U4f53\U64cd\U4f5c\U5c42\U9762\U5c06\U7528\U5317\U4eac\U6587\U5316\U4ea7\U4e1a\U6295\U8d44\U57fa\U91d1\U8fdb\U884c\U6295\Uff0c\U8be5\U57fa\U91d1\U7684\U51fa\U8d44\U65b9\U662f\U56fd\U5bb6\U65b0\U95fb\U51fa\U7248\U603b\U7f72\U3002";
     },
    },*/
    cell.contactContentLabel.text=[[dataArray objectAtIndex:indexPath.row] objectForKey:@"a_investors"];
    cell.lastContactContentLabel.text=[[dataArray objectAtIndex:indexPath.row] objectForKey:@"pdate"];
    cell.psContentLabel.text=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"vfeedback"];
    cell.TitleLabel.text=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    [cell propertyWith:[[dataArray objectAtIndex:indexPath.row]objectForKey:@"industry"]];
    [cell.headImageView setImageWithURL:[NSURL URLWithString:[[dataArray objectAtIndex:indexPath.row]objectForKey:@"picurl"]] placeholderImage:[UIImage imageNamed:@"project-finance-new-headImage"]];
    cell.stateContentLabel.text=[[dataArray objectAtIndex:indexPath.row]objectForKey:@"fbtype"];
       
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ProjectFinanceTableViewCellDetailViewController *detailView=[[ProjectFinanceTableViewCellDetailViewController alloc]init];
    detailView.whereFromString=CLH_NSSTRING_FINANCE_DETAIL_CELL;
    detailView.proID=projectID;
    detailView.piid=[[dataArray objectAtIndex:indexPath.row] objectForKey:@"piid"];
    detailView.beforeDic=[dataArray objectAtIndex:indexPath.row];
    
    //组别
    NSString *indexString=[[NSUserDefaults standardUserDefaults]objectForKey:@"index-finance"];
    NSLog(@"--didselect--indexString-%@",indexString);
    
    if ([indexString isEqualToString:@"1"]) {
        detailView.group=@"重点跟进";
    }else if ([indexString isEqualToString:@"2"]){
         detailView.group=@"已见面";
    }else if ([indexString isEqualToString:@"3"]){
        detailView.group=@"已推进";
    }else if ([indexString isEqualToString:@"4"]){
        detailView.group=@"已否决";
    }
    
     //将服务器返回的数据。要传到下个页面。
    [self.navigationController pushViewController:detailView animated:NO];
 }


#pragma  -mark -pullingrefreshTableView delegate
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    currentPage++;
    
    NSString *indexString=[[NSUserDefaults standardUserDefaults]objectForKey:@"index-finance"];
       //10084有数据
    [self loadData:projectID WithTabFlag:indexString];
    
    [myTableView tableViewDidFinishedLoading];
}
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    currentPage=1;
    
    NSString *indexString=[[NSUserDefaults standardUserDefaults]objectForKey:@"index-finance"];
    //10084有数据
    [self loadData:projectID WithTabFlag:indexString];

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
