//
//  ContactViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//联系人界面,t001登录的时候，方创内部人登录的时候
#import "XuanZeLianXiRenViewController.h"
#import "JianJieViewController.h"
#import "LianXiRenViewController.h"
#import "QiYeTuanDuiViewController.h"
#import "XuanZeQunViewController.h"
#import "MineInFoemationViewController.h"
#import "ContactTableViewCell.h"
#import "ChatWithFriendViewController.h"


//2014.05.21 chenlihua 解决联系人保存在本地。
#import "Reachability.h"

//2014.06.12 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"

@interface XuanZeLianXiRenViewController ()
{
    NSTimer *Sokettimer;
}
@end

@implementation XuanZeLianXiRenViewController

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
        //              socketUpdate=[socketNet sharedSocketNet];
        //        }
        //
        //        socketUpdate.delegate=self;
        //        Sokettimer =   [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(ConSocket3) userInfo:nil repeats:YES];
        // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [Sokettimer invalidate];
}
//2014.05.20 chenlihua 判断网络是否连接,解决联系人保存在本地的问题。
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

//2014.08.11 chenlihua  重新写loadData函数，在有网的时候，也要从本地取数据

- (void)loadData
{
    [[NetManager sharedManager] getdiscussion_ulistWithuserName:[[UserInfo sharedManager] username]
                                                         hudDic:nil
                                                        success:^(id responseDic) {
                                                            NSLog(@"%@",responseDic);
                                                            dataDic = [[NSMutableArray alloc]initWithArray:[[responseDic objectForKey:@"data"]objectForKey:@"ulist"]];
                                                            NSLog(@"%@",dataDic);
                                                            arrayDictKey  = [[NSMutableArray alloc]init];
                                                            for (int i =0; i<dataDic.count;i++) {
                                                                
                                                                NSString *zimu=    [[ChineseToPinyin pinyinFromChiniseString:[[dataDic objectAtIndex:i] objectForKey:@"username"]]substringToIndex:1];
                                                                if (![arrayDictKey containsObject:zimu]) {
                                                                    [arrayDictKey addObject:zimu];
                                                                }
                                                                [arrayDictKey sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                                                                
                                                            }
                                                            for (int j=0;j<arrayDictKey.count ; j++) {
                                                                NSMutableArray *arr = [[NSMutableArray alloc]init];
                                                                for (int i=0; i<dataDic.count; i++) {
                                                                    
                                                                    
                                                                    NSString *zimu=    [[ChineseToPinyin pinyinFromChiniseString:[[dataDic objectAtIndex:i] objectForKey:@"username"]]substringToIndex:1];
                                                                    if ([zimu isEqualToString:[arrayDictKey objectAtIndex:j]]) {
                                                                        
                                                                        [arr addObject:[dataDic objectAtIndex:i]];
                                                                        [arrayDict setValue:arr forKey:[arrayDictKey objectAtIndex:j]];
                                                                        //                    [arr removeAllObjects];
                                                                    }
                                                                }
                                                            }
                                                            
                                                            
                                                            NSLog(@"%@",arrayDict);
                                                            [haoYoutableView reloadData];
                                                        } fail:^(id errorString) {
                                                            
                                                            [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
                                                        }];
    
    
    //
    //    if ([self isConnectionAvailable]) {
    //        NSUserDefaults *contactDefault=[NSUserDefaults standardUserDefaults];
    //        NSData *contactDic=[contactDefault objectForKey:@"CONTACT_INFO"];
    //        NSLog(@"-----联系人中保存数据成功后，，，data--%@",[NSKeyedUnarchiver unarchiveObjectWithData:contactDic]);
    //        dataDic = [[NSDictionary alloc]initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:contactDic]];
    //        NSLog(@"-----------------------dataDic----%@---",dataDic);
    //
    //        //2014.05.24 chenlihua 解决若第一次登陆软件后，断网，点击联系人时页面崩溃。崩溃原因是第一次时还没有本地中还没有数据，为空。
    //        if (dataDic.count==0) {
    //
    //            [[NetManager sharedManager]getcontactlistWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
    //                //if ([[responseDic objectForKey:@"data"]isKindOfClass:[NSDictionary class]]) {
    //                dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
    //                NSLog(@"dataDic=%@",dataDic);
    //
    //
    //                NSData *archiveConData = [NSKeyedArchiver archivedDataWithRootObject:dataDic];
    //                NSUserDefaults *ContactDefaults=[NSUserDefaults standardUserDefaults];
    //                [ContactDefaults setObject:archiveConData forKey:@"CONTACT_INFO"];
    //                [ContactDefaults synchronize];
    //
    //                [self initTableView];
    //
    //            } fail:^(id errorString) {
    //                NSLog(@"%@",errorString);
    //                [self.view showActivityOnlyLabelWithOneMiao:errorString];
    //
    //            }];
    //
    //
    //        }else
    //        {
    //            //2014.09.12 chenlihua 解决有网时，本地数据不及时更新的问题
    //            [[NetManager sharedManager]getcontactlistWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
    //                //if ([[responseDic objectForKey:@"data"]isKindOfClass:[NSDictionary class]]) {
    //                dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
    //                NSLog(@"dataDic=%@",dataDic);
    //
    //
    //                NSData *archiveConData = [NSKeyedArchiver archivedDataWithRootObject:dataDic];
    //                NSUserDefaults *ContactDefaults=[NSUserDefaults standardUserDefaults];
    //                [ContactDefaults setObject:archiveConData forKey:@"CONTACT_INFO"];
    //                [ContactDefaults synchronize];
    //
    //                [self initTableView];
    //
    //            } fail:^(id errorString) {
    //                NSLog(@"%@",errorString);
    //                [self.view showActivityOnlyLabelWithOneMiao:errorString];
    //
    //            }];
    //
    //           // [self initTableView];
    //        }
    //
    //
    //    }else
    //    {
    //        /*
    //         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络未连接，请您一会儿重新发送" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //         [alert show];
    //         */
    //
    //        NSUserDefaults *contactDefault=[NSUserDefaults standardUserDefaults];
    //        NSData *contactDic=[contactDefault objectForKey:@"CONTACT_INFO"];
    //
    //        NSLog(@"-----联系人中保存数据成功后，，，data--%@",[NSKeyedUnarchiver unarchiveObjectWithData:contactDic]);
    //        dataDic = [[NSDictionary alloc]initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:contactDic]];
    //        NSLog(@"-----------------------dataDic----%@---",dataDic);
    //
    //        //2014.05.24 chenlihua 解决若第一次登陆软件后，断网，点击联系人时页面崩溃。崩溃原因是第一次时还没有本地中还没有数据，为空。
    //        if (dataDic.count==0) {
    //
    //            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络出现错误，请您一会刷新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //            [alertView show];
    //
    //        }else
    //        {
    //            [self initTableView];
    //        }
    //
    //        //  [self initTableView];
    //    }
}



//2014.05.21 chenlihua 实现联系人的本地存储，在断网的时候，也有数据，重写loadData函数。
/*
 - (void)loadData
 {
 
 if ([self isConnectionAvailable]) {
 
 [[NetManager sharedManager]getcontactlistWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
 //if ([[responseDic objectForKey:@"data"]isKindOfClass:[NSDictionary class]]) {
 dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
 NSLog(@"dataDic=%@",dataDic);
 
 
 NSData *archiveConData = [NSKeyedArchiver archivedDataWithRootObject:dataDic];
 NSUserDefaults *ContactDefaults=[NSUserDefaults standardUserDefaults];
 [ContactDefaults setObject:archiveConData forKey:@"CONTACT_INFO"];
 [ContactDefaults synchronize];
 
 [self initTableView];
 
 } fail:^(id errorString) {
 NSLog(@"%@",errorString);
 [self.view showActivityOnlyLabelWithOneMiao:errorString];
 
 }];
 
 }else
 {
 /*
 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络未连接，请您一会儿重新发送" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
 [alert show];
 */
/*
 NSUserDefaults *contactDefault=[NSUserDefaults standardUserDefaults];
 NSData *contactDic=[contactDefault objectForKey:@"CONTACT_INFO"];
 
 NSLog(@"-----联系人中保存数据成功后，，，data--%@",[NSKeyedUnarchiver unarchiveObjectWithData:contactDic]);
 dataDic = [[NSDictionary alloc]initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:contactDic]];
 NSLog(@"-----------------------dataDic----%@---",dataDic);
 
 //2014.05.24 chenlihua 解决若第一次登陆软件后，断网，点击联系人时页面崩溃。崩溃原因是第一次时还没有本地中还没有数据，为空。
 if (dataDic.count==0) {
 UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络出现错误，请您一会刷新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
 [alertView show];
 
 }else
 {
 [self initTableView];
 }
 
 //  [self initTableView];
 }
 }
 */

/*
 - (void)loadData
 {
 [[NetManager sharedManager]getcontactlistWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
 //if ([[responseDic objectForKey:@"data"]isKindOfClass:[NSDictionary class]]) {
 dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
 NSLog(@"dataDic=%@",dataDic);
 
 [self initTableView];
 
 } fail:^(id errorString) {
 NSLog(@"%@",errorString);
 [self.view showActivityOnlyLabelWithOneMiao:errorString];
 
 }];
 }
 */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}
- (void)showAlert

{
    
    promptAlert = [[UIAlertView alloc] initWithTitle:@"正在删除群成员" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    promptAlert.frame = CGRectMake(30, 30, 30, 30);
    
    [promptAlert show];
}
- (void)myTask {
    
    sleep(3);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleLabel setText:@"发起群聊"];
    //    [self setTabBarIndex:2];
    downArray = [[NSMutableArray alloc]init];
    
    //[self addBackButton];
    //dataArray = [[NSMutableArray alloc]init];
    //currentPage = 1;
    [self loadData];
    [self initTableView];
    [self addBackButton];
    [self setTabBarHidden:YES];
    arrayDict = [[NSMutableDictionary alloc]init];
    chooseArr = [[NSMutableArray alloc]init];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-65, (44-25)/2, 70, 25)];
    
    [rightButton setTitle:@"开始群聊" forState:UIControlStateNormal];
    //    [rightButton setTitle:@"完成" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchDown];
    [rightButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:13]];
    [self addRightButton:rightButton isAutoFrame:NO];
    
    //    NSArray *array = [[NSArray alloc] initWithObjects:@"你好", @"BFlower",
    //                      @"CGrass", @"DFence", @"EHouse", @"FTable", @"GChair",
    //                      @"HBook", @"ISwing" ,@"JWang" ,@"KDong" ,@"LNi" ,@"MHao" ,@"Na" ,@"Oa" ,@"Pa" ,@"Qa" ,@"Ra" ,@"Sa" ,@"Ta" ,@"Ua" ,@"Va" ,@"Wa" ,@"Xa" ,@"Ya" ,@"Za", nil];
    //     listarray = array;
    
}
#pragma -mark -functions
- (void)initTableView
{
    //UITableView
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    self.searchBar.placeholder = @"请输入搜索内容";
    self.searchBar.delegate = self;
    
    //
    //    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 30, 320, 288)];
    //    myview.backgroundColor= [UIColor blackColor];
    //    myview.alpha = 0.3;
    //    [self.searchBar setInputAccessoryView:myview];
    
    self.strongSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.delegate = self;
    
    haoYoutableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight+50)];
    //    [ haoYoutableView setTableHeaderView:self.searchBar];
    [haoYoutableView setBackgroundColor:[UIColor clearColor]];
    [haoYoutableView setShowsVerticalScrollIndicator:NO];
    [haoYoutableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    haoYoutableView.dataSource=self;
    haoYoutableView.delegate=self;
    //设置右侧索引栏
    
    haoYoutableView.sectionIndexColor = [UIColor orangeColor];
    haoYoutableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.contentView addSubview:haoYoutableView];
}
//#pragma mark - PullingRefreshTabelView Delegate
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    [haoYoutableView tableViewDidEndDragging:scrollView];
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [haoYoutableView tableViewDidScroll:scrollView];
//}
//
//-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
//{
//    currentPage++;
//    //[self loadData];
//    [tableView tableViewDidFinishedLoading];
//}
//-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
//{
//    currentPage=1;
//    //[self loadData];
//    [tableView tableViewDidFinishedLoading];
//}
#pragma mark - UISearchBar Delegete
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if (findstate==0) {
        haoYoutableView.frame = CGRectMake(0, 30, 320, self.contentViewHeight ) ;
        XuanZeLianXiRenViewController *vc = [[XuanZeLianXiRenViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
        [self setNavigationViewHidden:NO];
    }
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    
}
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    
}
//退出搜索事件
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    
    
    haoYoutableView.frame = CGRectMake(0, 30, 320, self.contentViewHeight ) ;
    XuanZeLianXiRenViewController *vc = [[XuanZeLianXiRenViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self setNavigationViewHidden:NO];
    
    
    
}
//点击准备输入a
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar2
{
    
    haoYoutableView.frame = CGRectMake(0, 0, 320, self.contentViewHeight ) ;
    
    [self setNavigationViewHidden:YES];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    findstate = 1;
    haoYoutableView.frame = CGRectMake(0, 0, 320, self.contentViewHeight ) ;
    SearchResultViewController* viewController = [[SearchResultViewController alloc] init];
    [viewController setKey:self.searchBar.text];
    [self.navigationController pushViewController:viewController animated:NO];
    [self setNavigationViewHidden:NO];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    haoYoutableView.frame = CGRectMake(0, 30, 320, self.contentViewHeight ) ;
    //    FvalueIndexVC *vc = [[FvalueIndexVC alloc]init];
    //    [self.navigationController pushViewController:vc animated:NO];
    //    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //
    //    [self setNavigationViewHidden:NO];
    
}


#pragma  -mark  -tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    //* 出现几组
    //if(aTableView == self.tableView) return 27;
    return [arrayDictKey count];
}
//*字母排序搜索
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    
    return arrayDictKey;
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //搜索时显示按索引第几组
    NSInteger count = 0;
    NSLog(@"%@",title);
    for(NSString *character in arrayDictKey)
    {
        
        if([character isEqualToString:title])
        {
            
            return count;
            
        }
        
        count ++;
        
    }
    
    return count;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [arrayDictKey objectAtIndex:section];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.listarray count];    //*每组要显示的行数
    //NSInteger i = [[listarray objectAtIndex:section] ]
    NSInteger i =  [[arrayDict objectForKey:[arrayDictKey objectAtIndex:section]] count];
    return i;
}
-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    //返回类型选择按钮
    
    return UITableViewCellAccessoryDisclosureIndicator;   //每行右边的图标
}
//- (UITableViewCell *)tableView:(UITableView *)tableview
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
//
//    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:
//                             TableSampleIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]
//                initWithStyle:UITableViewCellStyleDefault
//                reuseIdentifier:TableSampleIdentifier];
//    }
//
//    NSUInteger row = [indexPath row];
//    NSUInteger sectionMy = [indexPath section];
////    NSLog(@"%@", [[arrayDict objectForKey:[arrayDictKey objectAtIndex:sectionMy]] objectForKey:@"name"]);
//    NSLog(@"%@",arrayDict);
//
//
//    cell.textLabel.text =[[[arrayDict objectForKey:[arrayDictKey objectAtIndex:sectionMy]] objectAtIndex:indexPath.row] objectForKey:@"name"];
//
//
//
//    return cell;
//}
//划动cell是否出现del按钮
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return YES;  //是否需要删除图标
}
////编辑状态(不知道干什么用)
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
//forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    [self viewDidLoad];
//}
//- (NSIndexPath *)tableView:(UITableView *)tableView
//  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSUInteger row = [indexPath row];
//    if (row%2 == 0) {
//        NSUInteger row = [indexPath row];
//        NSString *rowValue = [listarray objectAtIndex:row];
//
//        NSString *message = [[NSString alloc] initWithFormat:
//                             @"You selected %@", rowValue];
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"Row Selected!"
//                              message:message
//                              delegate:nil
//                              cancelButtonTitle:@"Yes I Did"
//                              otherButtonTitles:nil];
//        [alert show];
//
//    }
//    return indexPath;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //这里控制值的大小
    return 70.0;  //控制行高
    
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return [[dataDic allKeys]count];
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSArray *array = nil;
//    switch (section) {
//        case 0:
//            array = [dataDic objectForKey:@"prolist"];
//            break;
//        case 1:
//            array = [dataDic objectForKey:@"fclist"];
//            break;
//        case 2:
//            array = [dataDic objectForKey:@"invlist"];
//            break;
//        default:
//            break;
//    }
//    return array.count;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 70;
//}
#pragma -mark -functions
//开始
- (void)start:(UIButton*)button
{
    
    //首先创建讨论组
    if (0 == downArray.count ) {
        [self.view showActivityOnlyLabelWithOneMiao:@"请选择联系人"];
        return;
    }
    
    NSArray* mebers = [downArray mutableArrayValueForKeyPath:@"username"];//把字典中的某个key取出来，成为单个key的子数组。
    NSLog(@"----mebers----%@---",mebers);
    for (NSString* str in mebers) {
        NSLog(@"meber \n%@",str);
    }
    NSString* meberStr = [mebers componentsJoinedByString:@","];//把value取出来，拼接成一个字符串
    
    NSLog(@"meberString \n%@",meberStr);
    if (mebers.count==1) {

        [[NSUserDefaults standardUserDefaults] setObject:meberStr forKey:@"lianxiren"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [Utils changeViewControllerWithTabbarIndex:5];

//        NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:@"成功创建聊天",@"success", nil];
//


//        [[NetManager sharedManager]getdid_by121Withusername:[[UserInfo sharedManager] username] sendto:meberStr hudDic:dic2 success:^(id responseDic) {
//
//            ChatWithFriendViewController *cfVc=[[ChatWithFriendViewController alloc]init];
//            NSLog(@"--------从联系人点击后的个人简介页面发送消息--跳转到聊天界面----responseDic--%@",responseDic);
//            cfVc.talkId=[[responseDic objectForKey:@"data"] objectForKey:@"did"];
//            NSLog(@"--------did----%@",cfVc.talkId);
//            cfVc.titleName=meberStr;
//            cfVc.entrance = @"contact";
//            cfVc.memberCount=@"2";
//            cfVc.flagContact=@"2";
//            NSArray *arr = [NSArray arrayWithObjects:[[responseDic objectForKey:@"data"] objectForKey:@"did"],@"1", nil];
//            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"relodataarr"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            [self.navigationController pushViewController:cfVc animated:YES];
//            
//            
//        }
//                                                       fail:^(id errorString) {
//                                                       }];
    }else
    {
        NSLog(@"%@",dataDic);
        meberStr = [meberStr stringByAppendingString:[NSString stringWithFormat:@",%@",[[UserInfo sharedManager] username]]];
#pragma test



        [[NetManager sharedManager] createdisWithusername:[[UserInfo sharedManager] username]members:meberStr hudDic:nil success:^(id responseDic) {
            NSLog(@"%@",responseDic);
            /*
             ChatWithFriendViewController* viewController = [[ChatWithFriendViewController alloc] init];
             viewController.talkId = [[responseDic objectForKey:@"data"] objectForKey:@"did"];
             [viewController setTitleName:[[responseDic objectForKey:@"data"] objectForKey:@"dname"]];
             viewController.entrance = @"qun";
             [self.navigationController pushViewController:viewController animated:YES];
             */
            NSMutableDictionary *dicarr=[[NSMutableDictionary alloc]init];
            [dicarr setObject:[[responseDic objectForKey:@"data"] objectForKey:@"did"] forKey:@"id"];
            [dicarr setObject:[[responseDic objectForKey:@"data"] objectForKey:@"dname"] forKey:@"name"];
            [dicarr setObject:[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"] forKey:@"mcnt"];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"lianxiren"];
            [[NSUserDefaults standardUserDefaults] setObject:dicarr forKey:@"lianxirenqun"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [Utils changeViewControllerWithTabbarIndex:5];


//            QunLiaoMingChengViewController* vc = [[QunLiaoMingChengViewController alloc] init];
//            [vc setDigId:[[responseDic objectForKey:@"data"] objectForKey:@"did"]];
//            vc.groupChatName=[[responseDic objectForKey:@"data"] objectForKey:@"dname"];
//            vc.peoplecount=[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"];
//            [self.navigationController pushViewController:vc animated:NO];

            
//            //2014.05.06 chenlihua  添加群时，转到群名称的修改中来。
//            NSArray *arr = [NSArray arrayWithObjects:[[responseDic objectForKey:@"data"] objectForKey:@"did"],@"1", nil];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"relodataarr"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            QunLiaoMingChengViewController* vc = [[QunLiaoMingChengViewController alloc] init];
//            [vc setDigId:[[responseDic objectForKey:@"data"] objectForKey:@"did"]];
//            vc.groupChatName=[[responseDic objectForKey:@"data"] objectForKey:@"dname"];
//            vc.peoplecount=[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"];
//            [self.navigationController pushViewController:vc animated:YES];

            
        } fail:^(id err){
            
            [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",err]];
        }];

    }
    
    
    
}
- (void)chooseWithButton : (UIButton*)button
{
    //2014.05.30 chenlihua 使添加群组界面在上下滑动时，原来选中的群前的勾会消失。
    NSString *flag=[NSString stringWithFormat:@"%d",button.tag];
    if (![chooseArr containsObject:flag]) {
        for (int i =0; i<dataDic.count; i++) {
            if ([[dataDic objectAtIndex:i] containsObject:flag]) {
                [downArray addObject:[dataDic objectAtIndex:i] ];
            }
        }
        [button setBackgroundImage:[UIImage imageNamed:@"71_dian_2"] forState:UIControlStateNormal];
        [chooseArr addObject:flag];
        
        
        
    }else
    {
        for (int i =0; i<dataDic.count; i++) {
            if ([[dataDic objectAtIndex:i] containsObject:flag]) {
                [downArray removeObject:[dataDic objectAtIndex:i] ];
            }
        }
        [chooseArr removeObject:flag];
        [button setBackgroundImage:[UIImage imageNamed:@"71_dian_1"] forState:UIControlStateNormal];
    }
    //    NSString *flag=[NSString stringWithFormat:@"%d",button.tag];
    //    if (!chooseArr) {
    //        chooseArr=[[NSMutableArray alloc]init];
    //        for (int i =0; i<dataDic.count; i++) {
    //            if ([[dataDic objectAtIndex:i] containsObject:flag]) {
    //                [downArray addObject:[dataDic objectAtIndex:i] ];
    //            }
    //        }
    //
    //        [chooseArr addObject:flag];
    //        [button setBackgroundImage:[UIImage imageNamed:@"71_dian_2"] forState:UIControlStateNormal];
    //    }else{
    //        isHave=NO;
    //        for (NSString *choStr in chooseArr){
    //            if ([choStr isEqualToString:flag]) {
    //                isHave=YES;
    //            }
    //        }
    //        if (isHave) {
    //
    //
    //            [chooseArr removeObject:flag];
    //            [button setBackgroundImage:[UIImage imageNamed:@"71_dian_1"] forState:UIControlStateNormal];
    //
    //        }else{
    //            NSLog(@"%@",dataDic);
    //
    //            for (int i =0; i<dataDic.count; i++) {
    //                if ([[dataDic objectAtIndex:i] containsObject:flag]) {
    //                    [downArray addObject:[dataDic objectAtIndex:i] ];
    //                }
    //            }
    //            [chooseArr addObject:flag];
    //
    //            [button setBackgroundImage:[UIImage imageNamed:@"71_dian_2"] forState:UIControlStateNormal];
    //        }
    //    }
    //
    ////    [[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"name"]
    ////    NSLog(@"%@",arrayDict);a
    //  if ([dataSet containsObject:dic]) {
    //        //删除行
    //        NSInteger row = [downArray indexOfObject:dic];
    //        [downArray removeObject:dic];
    //
    //        //        [downTable beginUpdates];
    //        [haoYoutableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
    //        //        [downTable endUpdates];
    //
    //
    //        [dataSet removeObject:dic];
    //        [button setSelected:NO];
    //    }
    //    else
    //    {
    //
    //        [dataSet addObject:dic];
    //        [button setSelected:YES];
    //        [downArray addObject:dic];
    //
    //
    //    }
}
- (void)choose:(UIButton*)sender
{
    [self chooseWithButton:sender];
    return;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = nil;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if ([tableView isEqual:haoYoutableView]) {
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            UIButton *duiGouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [duiGouBtn setFrame:CGRectMake(10, (55 - 30) / 2., 30, 30)];
            duiGouBtn.tag = [[[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
            
            [duiGouBtn setBackgroundImage:[UIImage imageNamed:@"71_dian_1"] forState:UIControlStateNormal];
            [duiGouBtn backgroundRectForBounds:CGRectMake(7, 7, 16, 16)];
            [duiGouBtn imageRectForContentRect:CGRectMake(7, 7, 16, 16)];
            [duiGouBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:duiGouBtn];
            
            //                if (chooseArr.count>0) {
            //
            //                    for (NSString *str in chooseArr) {
            //                        if ([str isEqualToString:[NSString stringWithFormat:@"%d",1000+indexPath.row - 1]]) {
            //
            //                            NSLog(@"------======-----------");
            //                            [duiGouBtn setBackgroundImage:[UIImage imageNamed:@"71_dian_2"] forState:UIControlStateNormal];
            //                        }
            //                    }
            //
            //                }
            if (chooseArr.count>0) {
                for (NSString *str in chooseArr) {
                    if ([str isEqualToString:[[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"id"] ]) {
                        [duiGouBtn setBackgroundImage:[UIImage imageNamed:@"71_dian_2"] forState:UIControlStateNormal];
                    }
                }
                
            }
            
            
            UIImageView* headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(duiGouBtn.frame) + 15,(55  - 81 / 2.)  / 2., 81 / 2., 81 / 2.)];
            [headImageView setTag:2000+indexPath.row];
            
            NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
            NSString *username= [[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"username"];
            NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",username,   [[UserInfo sharedManager]username]]];
            //                [mybtn setImageWithURL:[NSURL URLWithString:[[self.datas objectAtIndex:index] objectForKey:@"picurl2"]]  placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
            [headImageView  setImageWithURL:[NSURL URLWithString:urlString]  placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
            //                [  typebutton setImageWithURL:[NSURL URLWithString:[[self.datas objectAtIndex:index] objectForKey:@"picurl"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
            //            [cell addSubview:typebutton];
            //
            //            NSLog(@"%@",[NSURL URLWithString: [[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"picurl2"]]);
            //
            //                [headImageView setImageWithURL:[NSURL URLWithString: [[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"picurl2"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
            
            [headImageView.layer setCornerRadius:10.0];
            [headImageView.layer setMasksToBounds:YES];
            [cell.contentView addSubview:headImageView];
            
            
            UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake( CGRectGetMaxX(headImageView.frame) + 5+5, (55 - 15) / 2., 320 - CGRectGetMaxX(headImageView.frame) - 15 , 15+5+5)];
            NSString *name =[[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"username"];
            [nameLabel setText:name];
            
            [nameLabel setTextColor:[UIColor blackColor]];
            [nameLabel setFont:[UIFont fontWithName:KUIFont size:15]];
            [nameLabel setBackgroundColor:[UIColor clearColor]];
            nameLabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:nameLabel];
            
        }
        
        
        
    }
    //    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    /*
//     static NSString *cellString=@"cellId";
//
//     ContactTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
//     if (cell==nil) {
//     cell=[[ContactTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellString];
//     cell.selectionStyle=UITableViewCellSelectionStyleGray;
//     }
//     */
//    //2014.05.15 chenlihua 解决图片复用的问题
//    //图片加载时候正确，但是上下滑动时，会导致图片错乱。
//    ContactTableViewCell *cell=[[ContactTableViewCell alloc]init];
//    cell.selectionStyle=UITableViewCellSelectionStyleGray;
//
//
//    //    dic = [array objectAtIndex:indexPath.row];
//
//    //头像
//    // [cell.headView getImageFromURL:[NSURL URLWithString:[dic objectForKey:@"picurl"]]];
//
//    //2014.06.12 chenlihua 修改图片缓存的方式
//    [cell.headView setImageWithURL:[NSURL URLWithString:[[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]  objectForKey:@"picurl"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
//    [cell.headView.layer setMasksToBounds:YES];
//    [cell.headView.layer setCornerRadius:10.0f];
//
//    //2014.05.29 直接在聊天界面调用联系人接口。此部分代码注释掉。
//    //2014.05.26 chenlihua 把头像URL以姓名为标志，保存在本地。
//    /*
//     NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
//     [headImageUrl setObject:[dic objectForKey:@"picurl"] forKey:[dic objectForKey:@"username"]];
//     [headImageUrl synchronize];
//
//     NSLog(@"---缓存---picurl---%@-------",[headImageUrl objectForKey:[dic objectForKey:@"username"]]);
//     */
//
//    NSUInteger sectionMy = [indexPath section];
//    NSString *name =[[[arrayDict objectForKey:[arrayDictKey objectAtIndex:sectionMy]] objectAtIndex:indexPath.row] objectForKey:@"name"];
//    [cell.xingmlab setText:name];
//    return cell;
//}
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    NSArray *array = [[NSArray alloc]initWithObjects:@"企业团队",@"方创团队",@"投资人", nil];
//
//    //姓名背景图
//    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
//    [imageView setImage:[UIImage imageNamed:@"beijing_1"]];
//    [myView addSubview:imageView];
//
//    //企业团队等的Label
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
//    [label setText:[array objectAtIndex:section]];
//    [label setFont:[UIFont boldSystemFontOfSize:15]];
//    [label setTextColor:ORANGE];
//    [label setBackgroundColor:[UIColor clearColor]];
//    [label setFont:[UIFont fontWithName:KUIFont size:15]];
//    [myView addSubview:label];
//
//    return myView;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
///*
//- (void)JianJieEvent:(UIButton *)sender{
//    JianJieViewController *view=[[JianJieViewController alloc]init];
//    view.dataDic = dic;
//    NSLog(@"-------%@",view.dataDic);
//    [self.navigationController pushViewController:view animated:YES];
//}
// */
////#pragma -mark -AsyncSocketDelegate
////
////-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
////{
////    [socketUpdate readDataWithTimeout:-1 tag:200];
////
////}
////-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
////{
////
////
////}
//////2014.06.26 chenlihua sokcet断开后无法连接的问题
////-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
////{
////
////
////    // [chatSocket connectToHost:@"42.121.132.104" onPort:8480 error:nil];
////}
////-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
////{
////    NSLog(@"连接服务器成功");
////    [socketUpdate readDataWithTimeout:-1 tag:200];
////
////}
////- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket {
////    return [NSRunLoop currentRunLoop];
////}
////-(void)onSocketDidDisconnect:(AsyncSocket *)sock
////{
////
////    [socketUpdate disconnect];
////
////}
////- (BOOL)onSocketWillConnect:(AsyncSocket *)sock {
////    if (![self isConnectionAvailable])
////    {
////        return NO;
////    }
////    if ([socketUpdate isConnected]) {
////        return NO;
////    }
////    return YES;
////}
////#pragma mark - 封装返回数据最后一条MESGID
////- (NSString *)getmesgid
////{
////    NSString *meglocaid =@"0";
////    if (    [[NSUserDefaults standardUserDefaults] objectForKey:@"lastmegid"]!=nil) {
////        meglocaid =  [[NSUserDefaults standardUserDefaults] objectForKey:@"lastmegid"];
////    }
////    NSLog(@"%@",meglocaid);
////    return  meglocaid;
////
////}
////-(void)ConSocket3
////{
////
////
////    if ([self isConnectionAvailable])
////    {
////    if (![socketUpdate isConnected]) {
////        //
////        //        static BOOL connectOK;
////        //            connectOK =  [chatSocket connectToHost:SOCKETADDRESS onPort:SOCKETPORT error:nil];
////        //
////        //        if (connectOK ==YES) {
////
////
////
////        //            [self connectsoket];
////        socketUpdate = [socketNet sharedSocketNet];
////        //2014.07.29 chenlihua 发送给socket的数据给加上标识,dev:iOS 或者 dev:android.
////        NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",[self getmesgid],@"msgid",[[UserInfo sharedManager] username],@"from_uid",@"dev",@"iOS",/*@"all",@"to_uid",@"ios",@"message",*/nil];
////        NSLog(@"-------------上传服务器的JSONDic--%@",jsonDic);
////        NSString *jsonString=[jsonDic JSONString];
////        NSLog(@"---------上传服务器的JSON数据----- jsonDic %@-------",jsonString);
////
////
////        //2014.07.11 chenlihua 修改上传到服务器的格式，前面要加上字符数量
////        NSString *lengJson=[NSString stringWithFormat:@"%i",jsonString.length];
////        NSString *newJson=[NSString stringWithFormat:@"%@#%@\n",lengJson,jsonString];
////        NSLog(@"-----------最后上传服务器的数据---newJson--%@--",lengJson);
////        NSLog(@"-----------newJson-------%@",newJson);
////
////
////        NSData *data = [newJson dataUsingEncoding:NSUTF8StringEncoding];
////        
////        [socketUpdate writeData:data withTimeout:-1 tag:1000];
////        //            sokectsuccessful = 0;
////        //            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(connectagain)  userInfo:nil repeats:NO];
////        
////        
////        
////    }else{
////        
////    }
////    }
////    
////}

@end
