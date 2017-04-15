
//
//  ProjectViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//


//2014.06.25 chenlihua 项目列表 t001,p001,i001
#import "ProjectViewController.h"
#import "AProjectViewController.h"
#import "ChatWithFriendViewController.h"
#import "AddNewProjectFeatureViewController.h"

//2014.05.21 chenlihua 解决项目信息保存在本地。
#import "Reachability.h"
//2014.07.22 chenlihua 修改图片缓存方式
#import "UIImageView+WebCache.h"


@interface ProjectViewController ()
{
    NSTimer *charTimer;
}
@end
@implementation ProjectViewController

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
    
    if ([self.view window] == nil)// 是否是正在使用的视图
    {
        
      self.view = nil;
    }
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        if ([self isConnectionAvailable]) {
//                socketUpdate=[socketNet sharedSocketNet];
//        }
//            socketUpdate.delegate=self;

    
    }
    return self;
}
-(void)viewDidDisappear:(BOOL)animated
{
//    [charTimer invalidate];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//       charTimer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(ConSocket3) userInfo:nil repeats:YES];
    [self.titleLabel setText:@"项目列表"];
    [self setTabBarIndex:1];
    [self loadData];
    
    currentPage=1;
    [self initTableView];
}

//2014.05.22 chenlihua 判断网络是否连接,解决项目部分保存断网可见的问题。
-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    /*
     if (!isExistenceNetwork) {
     
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络未连接，请您一会儿重新发送" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     [alert show];
     }
     */
    return isExistenceNetwork;
}
//2014.08.11 chenlihua 重写loadData代码，使在有网时，也从本地拿数据。
- (void)loadData
{
    
    if ([self isConnectionAvailable]) {
        
        
        NSUserDefaults *ProDefault=[NSUserDefaults standardUserDefaults];
        NSData *proDic=[ProDefault objectForKey:@"PRO_INFO"];
        
        NSLog(@"-----项目保存数据成功后，，，data--%@",[NSKeyedUnarchiver unarchiveObjectWithData:proDic]);
        dataArray = [[NSMutableArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:proDic]];
        
        NSLog(@"----------dataArray-------%@-----",dataArray);
        //2014.05.24 chenlihua 修改第一次登陆后，断网。本地还没有存数据的情况下，点击项目部分会崩溃掉的情况。
        if (dataArray.count==0) {
            
            [[NetManager sharedManager]getProjectListWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
                
                if (currentPage == 1) {
                    if (dataArray) {
                        [dataArray removeAllObjects];
                    }else{
                        dataArray = [[NSMutableArray alloc]init];
                    }
                }
                NSArray* tempArr = nil;
                if ([[responseDic objectForKey:@"data"] isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *dic = [responseDic objectForKey:@"data"];
                    tempArr = [dic objectForKey:@"projectlist"];
                    
                    if (tempArr !=nil && tempArr.count > 0) {
                        
                        [dataArray addObjectsFromArray:tempArr];
                        NSLog(@"dataArray=%@",dataArray);
                        
                        
                        [dataTableView reloadData];
                        
                    }else{
                        
                        currentPage--;
                        
                        [self.view showActivityOnlyLabelWithOneMiao:@"已经没有更多数据"];
                    }
                }
                
                
                NSData *archiveConData = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
                NSUserDefaults *ContactDefaults=[NSUserDefaults standardUserDefaults];
                [ContactDefaults setObject:archiveConData forKey:@"PRO_INFO"];
                [ContactDefaults synchronize];
                
                
            } fail:^(id errorString) {
                [self.view showActivityOnlyLabelWithOneMiao:errorString];
            }];

            
        }else
        {
            [dataTableView reloadData];
        }
        
        
    }
    else
    {
        /*
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络未连接，请您一会儿重新发送" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         [alert show];
         */
        
        NSUserDefaults *ProDefault=[NSUserDefaults standardUserDefaults];
        NSData *proDic=[ProDefault objectForKey:@"PRO_INFO"];
        
        NSLog(@"-----项目保存数据成功后，，，data--%@",[NSKeyedUnarchiver unarchiveObjectWithData:proDic]);
        dataArray = [[NSMutableArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:proDic]];
        
        NSLog(@"----------dataArray-------%@-----",dataArray);
        //2014.05.24 chenlihua 修改第一次登陆后，断网。本地还没有存数据的情况下，点击项目部分会崩溃掉的情况。
        if (dataArray.count==0) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络出现错误，请您一会刷新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
            
        }else
        {
            [dataTableView reloadData];
        }
        
        
        // [dataTableView reloadData];
        
    }
}

//2014.05.22 chenlihua 重写loadData,代码，解决项目部分断网可见的问题。
/*
- (void)loadData
{
    
    if ([self isConnectionAvailable]) {
        
        [[NetManager sharedManager]getProjectListWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
            
            if (currentPage == 1) {
                if (dataArray) {
                    [dataArray removeAllObjects];
                }else{
                    dataArray = [[NSMutableArray alloc]init];
                }
            }
            NSArray* tempArr = nil;
            if ([[responseDic objectForKey:@"data"] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *dic = [responseDic objectForKey:@"data"];
                tempArr = [dic objectForKey:@"projectlist"];
                
                if (tempArr !=nil && tempArr.count > 0) {
                    
                    [dataArray addObjectsFromArray:tempArr];
                    NSLog(@"dataArray=%@",dataArray);
                    
                    
                    [dataTableView reloadData];
                    
                }else{
                    
                    currentPage--;
                    
                    [self.view showActivityOnlyLabelWithOneMiao:@"已经没有更多数据"];
                }
            }
            
            
            NSData *archiveConData = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
            NSUserDefaults *ContactDefaults=[NSUserDefaults standardUserDefaults];
            [ContactDefaults setObject:archiveConData forKey:@"PRO_INFO"];
            [ContactDefaults synchronize];

            
        } fail:^(id errorString) {
            [self.view showActivityOnlyLabelWithOneMiao:errorString];
        }];

    }
    else
    {
         /*
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络未连接，请您一会儿重新发送" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         [alert show];
        */
        /*
        NSUserDefaults *ProDefault=[NSUserDefaults standardUserDefaults];
        NSData *proDic=[ProDefault objectForKey:@"PRO_INFO"];
        
        NSLog(@"-----项目保存数据成功后，，，data--%@",[NSKeyedUnarchiver unarchiveObjectWithData:proDic]);
        dataArray = [[NSMutableArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:proDic]];
        
        NSLog(@"----------dataArray-------%@-----",dataArray);
        //2014.05.24 chenlihua 修改第一次登陆后，断网。本地还没有存数据的情况下，点击项目部分会崩溃掉的情况。
        if (dataArray.count==0) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络出现错误，请您一会刷新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
            
        }else
        {
            [dataTableView reloadData];
        }

        
       // [dataTableView reloadData];

    }
}
*/
#pragma -mark -functions
/*
- (void)loadData
{
    [[NetManager sharedManager]getProjectListWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        
        if (currentPage == 1) {
            if (dataArray) {
                [dataArray removeAllObjects];
            }else{
                dataArray = [[NSMutableArray alloc]init];
            }
        }
        NSArray* tempArr = nil;
        if ([[responseDic objectForKey:@"data"] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dic = [responseDic objectForKey:@"data"];
            tempArr = [dic objectForKey:@"projectlist"];
            
            if (tempArr !=nil && tempArr.count > 0) {
                
                [dataArray addObjectsFromArray:tempArr];
                NSLog(@"dataArray=%@",dataArray);
                
                [dataTableView reloadData];
                
            }else{
                
                currentPage--;
                
                [self.view showActivityOnlyLabelWithOneMiao:@"已经没有更多数据"];
            }
        }
        
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
 */
- (void)initTableView
{
    dataTableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) pullingDelegate:self];
    [dataTableView setBackgroundColor:[UIColor clearColor]];
    [dataTableView setShowsVerticalScrollIndicator:NO];
    [dataTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [dataTableView setDataSource:self];
    [dataTableView setDelegate:self];
    [self.contentView addSubview:dataTableView];
    
    [dataTableView setHeaderOnly:YES];
}
#pragma  -mark -PullingRefreshTabelView Delegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [dataTableView tableViewDidEndDragging:scrollView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [dataTableView tableViewDidScroll:scrollView];
}
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    currentPage++;
    [self loadData];
    [tableView tableViewDidFinishedLoading];
}
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    currentPage=1;
    [self loadData];
    [tableView tableViewDidFinishedLoading];
}

#pragma -mark -UITabelView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[UserInfo sharedManager] isUploadProject]) {
        if ([[[UserInfo sharedManager] usertype] isEqualToString:@"0"]) {
           // return dataArray.count+1;
            //2014.07.18 chenlihua 去掉欢迎添加新项目模块，将count-1.
            return dataArray.count;
        }else{
            return dataArray.count;
        }
    }else{
        return dataArray.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellString = @"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        
        //cell背景图
        UIImage* bcImg = [UIImage imageNamed:@"60_kuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    if ([[UserInfo sharedManager] isUploadProject]) {

        if (dataArray && dataArray.count == indexPath.row) {
            if ([[[UserInfo sharedManager] usertype] isEqualToString:@"0"]) {
                cell.imageView.image = [UIImage imageNamed:@"Reader-Mark-Y"];
                cell.textLabel.text = @"欢迎添加新项目";
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
                cell.textLabel.textColor = [UIColor orangeColor];
                UIImageView *jiantouImage=[[UIImageView alloc]initWithFrame:CGRectMake(320-20-23/2, (80-20.5)/2, 38/2, 41/2)];
                [jiantouImage setImage:[UIImage imageNamed:@"44_anniu_1"]];
                [cell.contentView addSubview:jiantouImage];
            }

        }else{
            dataDic = [dataArray objectAtIndex:indexPath.row];
            
            UIImage *image=[UIImage imageNamed:@"47_anniu_1"];
            
            //项目前面的头像
            CacheImageView *headerImage = [[CacheImageView alloc]initWithImage:image Frame:CGRectMake(10, 15, 50, 50)];
                [headerImage setBackgroundColor:[UIColor clearColor]];
            [headerImage getImageFromURL:[NSURL URLWithString:[dataDic objectForKey:@"projectpicture"]]];
            [cell.contentView addSubview:headerImage];
            
            for (int i =0 ; i < 3; i++) {
                NSArray *array =[NSArray arrayWithObjects:@"定位:",@"行业:",@"融资额:", nil];
                //定位-融资额Label
                UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 10+(20*i), 50, 20)];
                [lab setBackgroundColor:[UIColor clearColor]];
                [lab setFont:[UIFont systemFontOfSize:14]];
                [lab setTextColor:[UIColor orangeColor]];
                [lab setText:[array objectAtIndex:i]];
                [cell.contentView addSubview:lab];
            }
            //定位内容Label
            DWlable=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 150, 20)];
            [DWlable setBackgroundColor:[UIColor clearColor]];
            [DWlable setText:[dataDic objectForKey:@"projectposition"]];
            [DWlable setFont:[UIFont systemFontOfSize:14]];
            [cell.contentView addSubview:DWlable];
            
            //行业内容Label
            HYlable=[[UILabel alloc]initWithFrame:CGRectMake(110, 10+(20*1), 150, 20)];
            [HYlable setBackgroundColor:[UIColor clearColor]];
            [HYlable setText:[dataDic objectForKey:@"projectindustry"]];
            [HYlable setFont:[UIFont systemFontOfSize:14]];
            [cell.contentView addSubview:HYlable];
            
            //融资额Label
            RZElable=[[UILabel alloc]initWithFrame:CGRectMake(130, 10+(20*2), 150, 20)];
            [RZElable setBackgroundColor:[UIColor clearColor]];
            [RZElable setTextColor:[UIColor orangeColor]];
            [RZElable setText:[dataDic objectForKey:@"projectmoney"]];
            [RZElable setFont:[UIFont systemFontOfSize:14]];
            [cell.contentView addSubview:RZElable];
            
            //箭头Label
            UIImageView *jiantouImage=[[UIImageView alloc]initWithFrame:CGRectMake(320-10-23/2, (80-20.5)/2, 23/2, 41/2)];
            [jiantouImage setImage:[UIImage imageNamed:@"45_jiantou_1"]];
            [cell.contentView addSubview:jiantouImage];
        }
    }else if([[[UserInfo sharedManager] usertype] isEqualToString:@"0"]){
        
        cell.imageView.image = [UIImage imageNamed:@"Reader-Mark-Y"];
        cell.textLabel.text = @"欢迎添加新项目";
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        cell.textLabel.textColor = [UIColor orangeColor];
        UIImageView *jiantouImage=[[UIImageView alloc]initWithFrame:CGRectMake(320-20-23/2, (80-20.5)/2, 38/2, 41/2)];
        [jiantouImage setImage:[UIImage imageNamed:@"44_anniu_1"]];
        [cell.contentView addSubview:jiantouImage];
    }
    return cell;
}
 */
//2014.06.25 chenlihua 项目列表：把行业去掉，加上名称，纵列三个项目分别是“名称、一句话定位、融资金额”；
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellString = @"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        
        //cell背景图
        UIImage* bcImg = [UIImage imageNamed:@"60_kuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    if ([[UserInfo sharedManager] isUploadProject]) {
        
        if (dataArray && dataArray.count == indexPath.row) {
            
            //2014.07.18 chenlihua 去掉欢迎添加新项目
            /*
            if ([[[UserInfo sharedManager] usertype] isEqualToString:@"0"]) {
                cell.imageView.image = [UIImage imageNamed:@"Reader-Mark-Y"];
                cell.textLabel.text = @"欢迎添加新项目";
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
                cell.textLabel.textColor = [UIColor orangeColor];
                UIImageView *jiantouImage=[[UIImageView alloc]initWithFrame:CGRectMake(320-20-23/2, (80-20.5)/2, 38/2, 41/2)];
                [jiantouImage setImage:[UIImage imageNamed:@"44_anniu_1"]];
                [cell.contentView addSubview:jiantouImage];
            }
            */
            
        }else{
            dataDic = [dataArray objectAtIndex:indexPath.row];
            
            UIImage *image=[UIImage imageNamed:@"47_anniu_1"];
            
            //项目前面的头像
            /*
            CacheImageView *headerImage = [[CacheImageView alloc]initWithImage:image Frame:CGRectMake(10, 15, 50, 50)];
            [headerImage setBackgroundColor:[UIColor clearColor]];
            [headerImage getImageFromURL:[NSURL URLWithString:[dataDic objectForKey:@"projectpicture"]]];
            [cell.contentView addSubview:headerImage];
            */
            
            //2014.07.22 chenlihua 修改图片缓存方式
            UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
            [headerImage setBackgroundColor:[UIColor clearColor]];
            [headerImage setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"projectpicture"]] placeholderImage:image];
            [cell.contentView addSubview:headerImage];
            
            
            for (int i =0 ; i < 3; i++) {
                NSArray *array =[NSArray arrayWithObjects:@"名称:",@"一句话定位:",@"融资金额:", nil];
                //定位-融资额Label
                UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 10+(20*i), 100, 20)];
                [lab setBackgroundColor:[UIColor clearColor]];
                [lab setFont:[UIFont fontWithName:KUIFont size:14]];
                [lab setTextColor:[UIColor orangeColor]];
                [lab setText:[array objectAtIndex:i]];
                [cell.contentView addSubview:lab];
            }
            //名称内容Label
            DWlable=[[UILabel alloc]initWithFrame:CGRectMake(160, 10, 150, 20)];
            [DWlable setBackgroundColor:[UIColor clearColor]];
            [DWlable setText:[dataDic objectForKey:@"projectname"]];
            [DWlable setFont:[UIFont fontWithName:KUIFont size:14]];
            [cell.contentView addSubview:DWlable];
            
           
            
            //一句话定位Label
            HYlable=[[UILabel alloc]initWithFrame:CGRectMake(160, 10+(20*1), 150, 20)];
            [HYlable setBackgroundColor:[UIColor clearColor]];
            [HYlable setText:[dataDic objectForKey:@"projectposition"]];
            [HYlable setFont:[UIFont fontWithName:KUIFont size:14]];
            [cell.contentView addSubview:HYlable];
            
            
            //融资额Label
            RZElable=[[UILabel alloc]initWithFrame:CGRectMake(160, 10+(20*2), 150, 20)];
            [RZElable setBackgroundColor:[UIColor clearColor]];
            [RZElable setTextColor:[UIColor orangeColor]];
            [RZElable setText:[dataDic objectForKey:@"projectmoney"]];
            [RZElable setFont:[UIFont fontWithName:KUIFont size:14]];
            [cell.contentView addSubview:RZElable];
            
            //箭头Label
            UIImageView *jiantouImage=[[UIImageView alloc]initWithFrame:CGRectMake(320-10-23/2, (80-20.5)/2, 23/2, 41/2)];
            [jiantouImage setImage:[UIImage imageNamed:@"45_jiantou_1"]];
            [cell.contentView addSubview:jiantouImage];
        }
    }else if([[[UserInfo sharedManager] usertype] isEqualToString:@"0"]){
        
        cell.imageView.image = [UIImage imageNamed:@"Reader-Mark-Y"];
        cell.textLabel.text = @"欢迎添加新项目";
        cell.textLabel.font = [UIFont fontWithName:KUIFont size:16];
        cell.textLabel.textColor = [UIColor orangeColor];
        UIImageView *jiantouImage=[[UIImageView alloc]initWithFrame:CGRectMake(320-20-23/2, (80-20.5)/2, 38/2, 41/2)];
        [jiantouImage setImage:[UIImage imageNamed:@"44_anniu_1"]];
        [cell.contentView addSubview:jiantouImage];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[UserInfo sharedManager] isUploadProject]) {
        if (dataArray && dataArray.count == indexPath.row)  {
            if ([[[UserInfo sharedManager] usertype] isEqualToString:@"0"]) {
                AddNewProjectFeatureViewController* viewController = [[AddNewProjectFeatureViewController alloc] init];
                [self.navigationController pushViewController:viewController animated:YES];
            }


        }else{
            dataDic = [dataArray objectAtIndex:indexPath.row];
            NSLog(@"dataDic=%@",dataDic);
            [JumpControl project:self dictionary:dataDic];
        }
        
    }else if([[[UserInfo sharedManager] usertype] isEqualToString:@"0"]){
        AddNewProjectFeatureViewController* viewController = [[AddNewProjectFeatureViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}



//#pragma -mark -AsyncSocketDelegate
//
//-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//    [socketUpdate readDataWithTimeout:-1 tag:200];
//    
//}
//-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
//{
//    
//    
//}
////2014.06.26 chenlihua sokcet断开后无法连接的问题
//-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
//{
//    
//    
//    // [chatSocket connectToHost:@"42.121.132.104" onPort:8480 error:nil];
//}
//-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
//{
//    NSLog(@"连接服务器成功");
//    [socketUpdate readDataWithTimeout:-1 tag:200];
//    
//}
//- (BOOL)onSocketWillConnect:(AsyncSocket *)sock {
//    if (![self isConnectionAvailable])
//    {
//        return NO;
//    }
//    if ([socketUpdate isConnected]) {
//        return NO;
//    }
//    return YES;
//}
//- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket {
//    return [NSRunLoop currentRunLoop];
//}
//-(void)onSocketDidDisconnect:(AsyncSocket *)sock
//{
////    socketUpdate = nil;
//     [socketUpdate disconnect];
//    
//}
//#pragma mark - 封装返回数据最后一条MESGID
//- (NSString *)getmesgid
//{
//    NSString *meglocaid =@"0";
//    if (    [[NSUserDefaults standardUserDefaults] objectForKey:@"lastmegid"]!=nil) {
//        meglocaid =  [[NSUserDefaults standardUserDefaults] objectForKey:@"lastmegid"];
//    }
//    NSLog(@"%@",meglocaid);
//    return  meglocaid;
//    
//}
//-(void)ConSocket3
//{
//    if ([self isConnectionAvailable])
//    {
//    if (![socketUpdate isConnected]) {
//        //
//        //        static BOOL connectOK;
//        //            connectOK =  [chatSocket connectToHost:SOCKETADDRESS onPort:SOCKETPORT error:nil];
//        //
//        //        if (connectOK ==YES) {
//        
//        socketUpdate = [socketNet sharedSocketNet];
//        //            [self connectsoket];
//        
//        //2014.07.29 chenlihua 发送给socket的数据给加上标识,dev:iOS 或者 dev:android.
//        NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",[self getmesgid],@"msgid",[[UserInfo sharedManager] username],@"from_uid",@"dev",@"iOS",/*@"all",@"to_uid",@"ios",@"message",*/nil];
//        NSLog(@"-------------上传服务器的JSONDic--%@",jsonDic);
//        NSString *jsonString=[jsonDic JSONString];
//        NSLog(@"---------上传服务器的JSON数据----- jsonDic %@-------",jsonString);
//        
//        
//        //2014.07.11 chenlihua 修改上传到服务器的格式，前面要加上字符数量
//        NSString *lengJson=[NSString stringWithFormat:@"%i",jsonString.length];
//        NSString *newJson=[NSString stringWithFormat:@"%@#%@\n",lengJson,jsonString];
//        NSLog(@"-----------最后上传服务器的数据---newJson--%@--",lengJson);
//        NSLog(@"-----------newJson-------%@",newJson);
//        
//        
//        NSData *data = [newJson dataUsingEncoding:NSUTF8StringEncoding];
//        
//        [socketUpdate writeData:data withTimeout:-1 tag:1000];
//        //            sokectsuccessful = 0;
//        //            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(connectagain)  userInfo:nil repeats:NO];
//        
//        
//        
//    }else{
//        
//    }
//    }
//}
//
@end
