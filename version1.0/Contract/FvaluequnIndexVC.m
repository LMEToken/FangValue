//
//  FvalueIndexVC.m
//  FangChuang
//
//  Created by weiping on 14-10-17.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaluequnIndexVC.h"

#import "TSPopoverController.h"
#import "TSActionSheet.h"
#import "RootViewController.h"
#import "FangChuangInsiderViewController.h"
@interface FvaluequnIndexVC ()

@end

@implementation FvaluequnIndexVC
@synthesize searchBar,arrUnSendCollection;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated
{
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self setTitle:@"我的群"];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self addtableview];
    currentPage = 1;
    currentIndex = 1;
    [self loadData];
    dataArray= [[NSMutableArray alloc]init];

}

-(void)loadData
{

    NSString *perpageString=[NSString stringWithFormat:@"%d",currentPage*9990];
    

    if ([self isConnectionAvailable]) {
     
        [[NetManager sharedManager] indexWithusername:[[UserInfo sharedManager] username] dtype:[NSString stringWithFormat:@"%d",currentIndex] perpage:perpageString pagenum:@"1" hudDic:nil success:^(id responseDic) {
            NSDictionary *dic = [responseDic objectForKey:@"data"];
            NSLog(@"%@",dic);
            NSMutableArray *countarr= [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
            NSLog(@"%@",[[countarr objectAtIndex:0] objectForKey:@"name"]);
            if ([[[countarr objectAtIndex:0] objectForKey:@"name"]isEqualToString:@"0"]) {
               
                NSLog(@"aaa");
              
            }else
            {
              for (int i=0; i<countarr.count; i++) {
                if ([[[countarr objectAtIndex:i] objectForKey:@"dataflag"] isEqualToString:@"discussion"]) {
                    [dataArray addObject:[countarr objectAtIndex:i]];
                 
                }
            [myTableView reloadData];
            }
            }

          
            
            
        } fail:^(id errorString) {
   
        }];
        
        
        
    }else
    {
    }
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)addtableview
{
    myTableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) style:UITableViewStylePlain];

    //    [myTableView setDelegate:self];
    [myTableView setBackgroundColor:[UIColor whiteColor]];
    [myTableView setTableHeaderView:self.searchBar];
    myTableView.delegate = self;
    [myTableView setDataSource:self];
    myTableView.pullingDelegate=self;
    [myTableView setShowsVerticalScrollIndicator:NO];
    //    [myTableView setBackgroundColor:[UIColor clearColor]];
    //分割线
    
    //2014.08.13 chenlihua 将系统自带的线隐藏。
    [myTableView setSeparatorStyle: UITableViewCellSeparatorStyleSingleLine];
    
    //2014.05.06 chenlihua 设置单元格可以被滑动删除
    // [myTableView setEditing:NO animated:YES];
    [myTableView setTableHeaderView:self.searchBar];
    myTableView.userInteractionEnabled=YES;
    [self.contentView addSubview:myTableView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview Delegete
#pragma -mark -UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",dataArray);
         FaFinancierWelcomeItemCell *cell=[[FaFinancierWelcomeItemCell alloc]init];
    if (dataArray.count>0) {
        dataDic = [dataArray objectAtIndex:indexPath.row];
        NSString *type = [dataDic objectForKey:@"dataflag"];
        if ([type isEqualToString:@"discussion"]){
            
         
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.tag=indexPath.row;
            NSLog(@"%@",dataDic);
           [cell.timelable setText:[NSString stringWithFormat:@"(%@)",[dataDic objectForKey:@"mcnt"]]];
           [cell.titleLab setText:[dataDic objectForKey:@"name"]];
           [cell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage.png"]];
            
//            recell = cell;
        }

    }

    
    NSLog(@"-----------cellForRow------dataArray---%@",dataArray);
    


    

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"----方创内部进入--------------dataArray----%@-------------",dataArray);
    dataDic = [[NSDictionary alloc]initWithDictionary:[dataArray objectAtIndex:indexPath.row]];
    
    NSLog(@"%@",dataDic);
    NSString *type = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"dataflag"]];
    NSArray *arr = [NSArray arrayWithObjects:[dataDic objectForKey:@"id"],@"1", nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"relodataarr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([type isEqualToString:@"board"]) {
        
        XiangMuJinZhanViewController* viewController = [[XiangMuJinZhanViewController alloc] init];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if ([type isEqualToString:@"task"]){
        
        FangChuangRenWuViewController * viewController = [[FangChuangRenWuViewController alloc] init];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    //  else if ([type isEqualToString:@"order"])
    //2014.05.26 chenlihua 修改代码，使点击我的日程时，跳转到相应界面。
    else if ([type isEqualToString:@"schedule"])
    {
        
        RiChengBiaoViewController *rcVC=[[RiChengBiaoViewController alloc]init];
        [self.navigationController pushViewController:rcVC animated:NO];
        
        
    }
    // else{
    //2014.08.07 chenlihua 修改jobnum为0的情况出现
    else if ([type isEqualToString:@"discussion"]) {
        NSLog(@"%@",dataDic);
        
       [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"lianxiren"];
       [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:dataDic forKey:@"lianxirenqun"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
       [Utils changeViewControllerWithTabbarIndex:5];

        
    }
    
    
}




#pragma mark - Navigation
-(void)execSql:(NSString *)sql
{
    sqlite3 *db ;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != 0) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
    sqlite3_close(db);
}
#pragma mark - buttonView delegate
- (void)buttonViewSelectIndex:(int)index buttonView:(ButtonColumnView *)view
{
    //    NSString *perpageString=[NSString stringWithFormat:@"%d",currentPage*20];
    //    NSLog(@"%@",perpageString);
    //    NSLog(@"%d",index);
    //    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@groups%d",[[UserInfo sharedManager] username],index+1]]!=nil) {
    //
    //        NSDictionary *dic =[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@groups%d",[[UserInfo sharedManager] username],index+1]];
    //        dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
    //        [myTableView reloadData];
    //    }else
    //    {
    //    [[NetManager sharedManager] indexWithusername:[[UserInfo sharedManager] username] dtype:[NSString stringWithFormat:@"%d",index+1] perpage:perpageString pagenum:@"1" hudDic:nil success:^(id responseDic) {
    //
    //        NSDictionary *dic = [responseDic objectForKey:@"data"];
    //          if ([[dic objectForKey:@"indexlist"] count]<8) {
    //              [myTableView setHidden:YES];
    //        }else
    //        {
    //            [myTableView setHidden:NO];
    //        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:[NSString stringWithFormat:@"%@groups%d",[[UserInfo sharedManager] username],currentIndex]];
    //        dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
    //        NSData *archiveConData = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
    //        NSUserDefaults *OtherDefaults=[NSUserDefaults standardUserDefaults];
    //        NSString *fangInfoString=[NSString stringWithFormat:@"FANG_INFO_%d",currentIndex];
    //        [OtherDefaults setObject:archiveConData forKey:fangInfoString];
    //        [OtherDefaults synchronize];
    //
    //        [myTableView reloadData];
    //        }
    //    } fail:^(id errorString) {
    //    }];
    //    }
    //    [[NetManager sharedManager] indexWithusername:[[UserInfo sharedManager] username] dtype:[NSString stringWithFormat:@"%d",index+1] perpage:perpageString pagenum:@"1" hudDic:nil success:^(id responseDic) {
    //        NSLog(@"-------第二次调用接口成功----%@--",responseDic);
    //        NSDictionary *dic = [responseDic objectForKey:@"data"];
    //
    //        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:[NSString stringWithFormat:@"%@groups%d",[[UserInfo sharedManager] username],index+1]];
    //
    //        NSLog(@"----方创栏群组刷新---------------------------dic=%@----------------------------------------------",dic);
    //        dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
    //
    //        NSLog(@"----方创栏群组刷新---------------------------dataArray=%@----------------------------------------------",dataArray);
    //        NSLog(@"-------dataArray count--%d-------",[dataArray count]);
    //
    //
    //        NSData *archiveConData = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
    //        NSUserDefaults *OtherDefaults=[NSUserDefaults standardUserDefaults];
    //        NSLog(@"%d",index);
    //        NSString *fangInfoString=[NSString stringWithFormat:@"FANG_INFO_%d",index+1];
    //
    //        [OtherDefaults setObject:archiveConData forKey:fangInfoString];
    //        [OtherDefaults synchronize];
    //
    //        [myTableView reloadData];
    //
    //
    //    } fail:^(id errorString) {
    //        NSLog(@"------第二次调用接口失败---%@--------",errorString);
    //        ;
    //    }];
    
    //    currentIndex = index+1;
    //
    //
    //    //2014.05.11 chenlihua 修改下拉刷新。
    //    NSLog(@"--------上拉刷新时--loadData---currentPage--%d--",currentPage);
    //    NSString *perpageString=[NSString stringWithFormat:@"%d",currentPage*20];
    //    NSLog(@"-------刷新的总行数-----%@",perpageString);
    //
    //
    //    //2014.05.09 chenlihua chenlihua 接口更改
    //    NSLog(@"--------开始进入方创，第二次调用接口--username--%@",[[UserInfo sharedManager] username]);
    //    NSLog(@"--------开始进入方创，第二次调用接口--dtype--%@",[NSString stringWithFormat:@"%d",index+1]);
    //    NSLog(@"--------开始进入方创，第二次调用接口--AppToken--%@",[[UserInfo sharedManager] apptoken]);
    //
    //    if ([self isConnectionAvailable]) {
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //        //20140809 Tom 实现本地计算
    
    
    //        }else
    //        {
    //
    //        }
    //
    //    }else{
    //
    //        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络未连接，请您一会儿重新发送" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //        //        [alert show];
    //
    //
    //        NSUserDefaults *OtherDefault=[NSUserDefaults standardUserDefaults];
    //
    //        NSString *fangInfoString=[NSString stringWithFormat:@"FANG_INFO_%d",index+1];
    //        NSData *OtherDic=[OtherDefault objectForKey:fangInfoString];
    //        NSLog(@"-----联系人中保存数据成功后，，111111111，Other--%@",[NSKeyedUnarchiver unarchiveObjectWithData:OtherDic]);
    //
    //
    //        //2014.05.24 chenlihua 修改第一次登陆后，断网。本地还没有存数据的情况下，点击方创其它部分会崩溃掉的情况。解决办法，虚构一个数组。使其能点进去，进行刷新。
    //        if (![NSKeyedUnarchiver unarchiveObjectWithData:OtherDic]) {
    //
    //
    //            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    //            [dic setObject:@"discussion" forKey:@"dataflag"];
    //            [dic setObject:@"" forKey:@"dgcreateby"];
    //            [dic setObject:@"0" forKey:@"id"];
    //            [dic setObject:@"0" forKey:@"mcnt"];
    //            [dic setObject:@"0" forKey:@"msgcnt"];
    //            [dic setObject:@"" forKey:@"name"];
    //            [dic setObject:@"0" forKey:@"order"];
    //            NSLog(@"---------dic---%@-",dic);
    //
    //
    //            dataArray=[[NSMutableArray alloc]init];
    //            [dataArray addObject:dic];
    //
    //
    //
    //        }else
    //        {
    //            dataArray = [[NSMutableArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:OtherDic]];
    //
    //
    //        }
    //
    //    }
    currentIndex = index+1;
    NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
    dataArray[currentIndex]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",currentIndex,[[UserInfo sharedManager] username] ]]];
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
    
}
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
- (void)rightButton:(UIButton*)button
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    // 动画时间控制
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //是否代理
    transition.delegate = self;
    // 是否在当前层完成动画
    transition.removedOnCompletion = NO;
    
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    
    XuanZeLianXiRenViewController *viewCon = [[XuanZeLianXiRenViewController alloc]init];
    [self.navigationController pushViewController:viewCon animated:NO];
    // 动画事件
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/

@end
