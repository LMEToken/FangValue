//
//  FinancierProjectListViewController.m
//  FangChuang
//
//  Created by omni on 14-4-1.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//项目列表中没有增加项目选项的。 暂时无用
#import "FinancierProjectListViewController.h"
//2014.07.22 chenlihua 修改图片缓存方式
#import "UIImageView+WebCache.h"


@interface FinancierProjectListViewController ()
{
    NSTimer *Sokettimer;
}
@property(nonatomic,retain) AsyncSocket *socketUpdate;
@end
@implementation FinancierProjectListViewController
@synthesize socketUpdate;
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

        // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated
{
//    [Sokettimer invalidate];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    socketUpdate=[socketNet sharedSocketNet];
    socketUpdate.delegate=self;
//  Sokettimer=  [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(ConSocket3) userInfo:nil repeats:YES];
	// Do any additional setup after loading the view.
    [self.titleLabel setText:@"项目"];
    [self setTabBarIndex:1];
    
    currentPage=1;
    [self initTableView];
}
#pragma -mark -functions
- (void)loadData
{
    
    [[NetManager sharedManager]getProjectListWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        //        NSLog(@"responseDic=%@",responseDic);
        
        
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
#pragma -mark -UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellString=nil;
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        dataDic = [[NSDictionary alloc]initWithDictionary:[dataArray objectAtIndex:indexPath.row]];
        
        //cell背景
        UIImage* bcImg = [UIImage imageNamed:@"60_kuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];
 
        //头像
        /*
        UIImage *image=[UIImage imageNamed:@"47_anniu_1"];
        //CacheImageView *headerImage=[[CacheImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
        CacheImageView *headerImage = [[CacheImageView alloc]initWithImage:image Frame:CGRectMake(10, 15, 50, 50)];
        //[headerImage setImage:image];
        [headerImage setBackgroundColor:[UIColor clearColor]];
        [headerImage getImageFromURL:[NSURL URLWithString:[dataDic objectForKey:@"projectpicture"]]];
        [cell.contentView addSubview:headerImage];
        */
        
        //2014.07.22 chenlihua 修改图像缓存方式
        UIImage *image=[UIImage imageNamed:@"47_anniu_1"];
        UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
        [headerImage setBackgroundColor:[UIColor clearColor]];
        [headerImage setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"projectpicture"]] placeholderImage:image];
        [cell.contentView addSubview:headerImage];
         
        
        for (int i =0 ; i < 3; i++) {
            NSArray *array =[NSArray arrayWithObjects:@"定位:",@"行业:",@"融资额:", nil];
            //定位-融资额Label
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 10+(20*i), 50, 20)];
            [lab setBackgroundColor:[UIColor clearColor]];
            [lab setFont:[UIFont fontWithName:KUIFont size:14]];
            [lab setTextColor:[UIColor orangeColor]];
            [lab setText:[array objectAtIndex:i]];
            [cell.contentView addSubview:lab];
            
        }
        
        //定位内容Label
        DWlable=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 150, 20)];
        [DWlable setBackgroundColor:[UIColor clearColor]];
        [DWlable setText:[dataDic objectForKey:@"projectposition"]];
        [DWlable setFont:[UIFont fontWithName:KUIFont size:14]];
        [cell.contentView addSubview:DWlable];
        
        //行业内容Label
        HYlable=[[UILabel alloc]initWithFrame:CGRectMake(110, 10+(20*1), 150, 20)];
        [HYlable setBackgroundColor:[UIColor clearColor]];
        [HYlable setText:[dataDic objectForKey:@"projectindustry"]];
        [HYlable setFont:[UIFont fontWithName:KUIFont size:14]];
        [cell.contentView addSubview:HYlable];
        
        //融资额内容Label
        RZElable=[[UILabel alloc]initWithFrame:CGRectMake(130, 10+(20*2), 150, 20)];
        [RZElable setBackgroundColor:[UIColor clearColor]];
        [RZElable setTextColor:[UIColor orangeColor]];
        [RZElable setText:[dataDic objectForKey:@"projectmoney"]];
        [RZElable setFont:[UIFont fontWithName:KUIFont size:14]];
        [cell.contentView addSubview:RZElable];
        
        //箭头背景
        UIImageView *jiantouImage=[[UIImageView alloc]initWithFrame:CGRectMake(320-10-23/2, (80-20.5)/2, 23/2, 41/2)];
        [jiantouImage setImage:[UIImage imageNamed:@"45_jiantou_1"]];
        [cell.contentView addSubview:jiantouImage];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"hang  %d",indexPath.row);
    dataDic = [dataArray objectAtIndex:indexPath.row];
    NSLog(@"dataDic=%@",dataDic);
    [JumpControl project:self dictionary:dataDic];
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
//- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket {
//    return [NSRunLoop currentRunLoop];
//}
//-(void)onSocketDidDisconnect:(AsyncSocket *)sock
//{
//    
//    [socketUpdate disconnect];
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
//        socketUpdate = [socketNet sharedSocketNet];
//        
//        //
//        //        static BOOL connectOK;
//        //            connectOK =  [chatSocket connectToHost:SOCKETADDRESS onPort:SOCKETPORT error:nil];
//        //
//        //        if (connectOK ==YES) {
//        
//        
//        
////          [self connectsoket];
//        socketUpdate = [socketNet sharedSocketNet];
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
//    
//}
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

@end
