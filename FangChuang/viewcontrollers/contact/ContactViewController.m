//
//  ContactViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//联系人界面,t001登录的时候，方创内部人登录的时候
#import "ContactViewController.h"
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

@interface ContactViewController ()
{
    NSTimer *Sokettimer;
}
@end

@implementation ContactViewController

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
}
- (void)loadData
{
    
    [[NetManager sharedManager]getcontactlistWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        NSLog(@"%@",responseDic);
     dataArray = [[NSMutableArray alloc]initWithArray:[[responseDic objectForKey:@"data"]objectForKey:@"fclist"]];
        NSLog(@"%@",dataArray);
        for (int i=0; i<dataArray.count; i++) {
            if ([[[dataArray objectAtIndex:i]objectForKey:@"username"]isEqualToString:[[UserInfo sharedManager]username]]) {
                [dataArray removeObjectAtIndex:i];
            }
        }
        if (dataArray.count>0) {
            NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS UNREAD4 (ID INTEGER PRIMARY KEY AUTOINCREMENT, division TEXT, email TEXT, sid TEXT, mobile TEXT,name TEXT, picfiletime TEXT ,picurl TEXT,postion TEXT,username TEXT)";
            [self execSql:sqlCreateTable];
            for (int i=0; i<dataArray.count; i++) {
                NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@','%@','%@','%@','%@','%@','%@','%@','%@') VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@')",@"UNREAD4",@"division",@"email",@"sid",@"mobile",@"name",@"picfiletime",@"picurl",@"postion",@"username",[[dataArray objectAtIndex:i]objectForKey:@"division"] ,[[dataArray objectAtIndex:i]objectForKey:@"email"] ,[[dataArray objectAtIndex:i]objectForKey:@"id"],[[dataArray objectAtIndex:i]objectForKey:@"mobile"] ,[[dataArray objectAtIndex:i]objectForKey:@"name"] ,[[dataArray objectAtIndex:i]objectForKey:@"picfiletime"] ,[[dataArray objectAtIndex:i]objectForKey:@"picurl2"] ,[[dataArray objectAtIndex:i]objectForKey:@"postion"] ,[[dataArray objectAtIndex:i]objectForKey:@"username"]];
                
                //获取联系认relname;
                   [[NSUserDefaults standardUserDefaults] setObject:[[dataArray objectAtIndex:i]objectForKey:@"username"] forKey:[NSString stringWithFormat:@"relname%@",[[dataArray objectAtIndex:i]objectForKey:@"username"]]];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self execSql:sql1];
                
            }
            
         
            sqlite3 *db ;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documents = [paths objectAtIndex:0];
            NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
            if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
                sqlite3_close(db);
                NSLog(@"数据库打开失败");
            }
            NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM %@", @"UNREAD4"];
            sqlite3_stmt * statement;
            if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    char *n1 = (char *)sqlite3_column_text(statement, 1);
                    NSString *l1 = [[NSString alloc]initWithUTF8String:n1] ;
                    char *n2 = (char *)sqlite3_column_text(statement, 2);
                    NSString *l2 = [[NSString alloc]initWithUTF8String:n2] ;
                    char *n3 = (char *)sqlite3_column_text(statement, 3);
                    NSString *l3 = [[NSString alloc]initWithUTF8String:n3] ;
                    char *n4 = (char *)sqlite3_column_text(statement, 4);
                    NSString *l4 = [[NSString alloc]initWithUTF8String:n4] ;
                    char *n5 = (char *)sqlite3_column_text(statement, 5);
                    NSString *l5 = [[NSString alloc]initWithUTF8String:n5] ;
                    char *n6 = (char *)sqlite3_column_text(statement,6);
                    NSString *l6 = [[NSString alloc]initWithUTF8String:n6] ;
                    char *n7 = (char *)sqlite3_column_text(statement,7);
                    NSString *l7 = [[NSString alloc]initWithUTF8String:n7] ;
                    char *n8= (char *)sqlite3_column_text(statement, 8);
                    NSString *l8 = [[NSString alloc]initWithUTF8String:n8] ;
                    char *n9= (char *)sqlite3_column_text(statement, 9);
                    NSString *l9 = [[NSString alloc]initWithUTF8String:n9] ;
                    //                NSLog(@"%@   %@       %@      %@       %@        %@         %@       %@           %@",l1,l2,l3,l4,l5,l6,l7,l8,l9);
                    
                    NSMutableDictionary *dicarr =[[NSMutableDictionary alloc]init];
                    [dicarr setValue:l1  forKey:@"division"];
                    [dicarr setValue:l2 forKey:@"email"];
                    [dicarr setValue:l3 forKey:@"id"];
                    [dicarr setValue:l4 forKey:@"mobile"];
                    [dicarr setValue:l5 forKey:@"name"];
                    [dicarr setValue:l6 forKey:@"picfiletime"];
                    [dicarr setValue:l7 forKey:@"picurl"];
                    [dicarr setValue:l8 forKey:@"postion"];
                    [dicarr setValue:l9 forKey:@"username"];
                    //                NSUserDefaults *headImageUrl1=[NSUserDefaults standardUserDefaults];
                    //                [headImageUrl1 setObject:l7 forKey:[NSString stringWithFormat:@"%@%@",l9,[[UserInfo sharedManager]username]]];
                    //                [headImageUrl1 synchronize];
                    [dataDic addObject:dicarr];
                    
                    
                }
                sqlite3_finalize(statement);
                sqlite3_close(db);
            }
            
        
//            NSString *zimu2=  [[ChineseToPinyin pinyinFromChiniseString:[[dataDic objectAtIndex:43] objectForKey:@"name"]]substringToIndex:1];  
            arrayDictKey  = [[NSMutableArray alloc]init];
            for (int i =0; i<dataDic.count;i++) {
                NSString *zimu=   [[ChineseToPinyin pinyinFromChiniseString:[[dataDic objectAtIndex:i] objectForKey:@"username"]]substringToIndex:1];
                //            if (![[dataDic objectAtIndex:i] objectForKey:@"name"]) {
                //               zimu=    [[ChineseToPinyin pinyinFromChiniseString:[[dataDic objectAtIndex:i] objectForKey:@"name"]]substringToIndex:1];
                //            }else
                //            {
                //                zimu=    [[ChineseToPinyin pinyinFromChiniseString:[[dataDic objectAtIndex:i] objectForKey:@"username"]]substringToIndex:1];
                //            }
                
                
                if (![arrayDictKey containsObject:zimu]) {
                    [arrayDictKey addObject:zimu];
                }
                [arrayDictKey sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                
            }
            
            
            for (int j=0;j<arrayDictKey.count ; j++) {
                NSMutableArray *arr = [[NSMutableArray alloc]init];
                for (int i=0; i<dataDic.count; i++) {
                    
                    
                    NSString *zimu=[[ChineseToPinyin pinyinFromChiniseString:[[dataDic objectAtIndex:i] objectForKey:@"name"]]substringToIndex:1];
                    if ([zimu isEqualToString:[arrayDictKey objectAtIndex:j]]) {
                        
                        [arr addObject:[dataDic objectAtIndex:i]];
                        [arrayDict setValue:arr forKey:[arrayDictKey objectAtIndex:j]];
                        //                    [arr removeAllObjects];
                    }
                }
            }
        
        }
    
        
// NSMutableArray *dataarr[arrayDictKey.count] ;
//        dataarr[arrayDictKey.count] = [[NSMutableArray alloc]init];
//        for (int i =0; i<dataDic.count;i++) {
//              NSString *zimu=    [[ChineseToPinyin pinyinFromChiniseString:[[dataDic objectAtIndex:i] objectForKey:@"name"]]substringToIndex:1];
//            for (int j = 0; j<arrayDictKey.count; j++) {
//                if ([zimu isEqualToString:[arrayDictKey objectAtIndex:j]]) {
//                    [dataarr[j] addObject:[dataDic objectAtIndex:i]];
//                }
//            }
//       }
  
//        NSArray *arrayA = [[NSArray alloc] initWithObjects:@"测试A1",@"测试A2", nil];
//        NSArray *arrayB = [[NSArray alloc] initWithObjects:@"测试B1",@"测试B2", nil];
//        NSArray *arrayC = [[NSArray alloc] initWithObjects:@"测试C1",@"测试C2",nil];
//        NSArray *arrayD = [[NSArray alloc] initWithObjects:@"测试D1",@"测试D2",nil];
//        NSArray *arrayE = [[NSArray alloc] initWithObjects:@"测试E1",@"测试E2", nil];
//        NSArray *arrayF = [[NSArray alloc] initWithObjects:@"测试F1",@"测试F2", nil];
//        NSArray *arrayG = [[NSArray alloc] initWithObjects:@"测试G1",@"测试G2", nil];


       
         
//         initWithObjectsAndKeys:arrayA,[arrayDictKey objectAtIndex:0],
//         arrayB,[arrayDictKey objectAtIndex:1],
//         arrayC,[arrayDictKey objectAtIndex:2],
//         arrayD,[arrayDictKey objectAtIndex:3],
//         arrayE,[arrayDictKey objectAtIndex:4],
//         arrayF,[arrayDictKey objectAtIndex:5],
//         arrayG,[arrayDictKey objectAtIndex:6],
//         nil];
        
        [haoYoutableView reloadData];
//        NSData *archiveConData = [NSKeyedArchiver archivedDataWithRootObject:dataDic];
//        NSUserDefaults *ContactDefaults=[NSUserDefaults standardUserDefaults];
//        [ContactDefaults setObject:archiveConData forKey:@"CONTACT_INFO"];
//        [ContactDefaults synchronize];
    } fail:^(id errorString) {
    
//        [self.view showActivityOnlyLabelWithOneMiao:errorString];
        
               
        
    }];
//
//    if ([self isConnectionAvailable]) {
//   NSUserDefaults *contactDefault=[NSUserDefaults standardUserDefaults];
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
-(void)getsqldata
{
    sqlite3 *db ;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM %@", @"UNREAD4"];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *n1 = (char *)sqlite3_column_text(statement, 1);
            NSString *l1 = [[NSString alloc]initWithUTF8String:n1] ;
            char *n2 = (char *)sqlite3_column_text(statement, 2);
            NSString *l2 = [[NSString alloc]initWithUTF8String:n2] ;
            char *n3 = (char *)sqlite3_column_text(statement, 3);
            NSString *l3 = [[NSString alloc]initWithUTF8String:n3] ;
            char *n4 = (char *)sqlite3_column_text(statement, 4);
            NSString *l4 = [[NSString alloc]initWithUTF8String:n4] ;
            char *n5 = (char *)sqlite3_column_text(statement, 5);
            NSString *l5 = [[NSString alloc]initWithUTF8String:n5] ;
            char *n6 = (char *)sqlite3_column_text(statement,6);
            NSString *l6 = [[NSString alloc]initWithUTF8String:n6] ;
            char *n7 = (char *)sqlite3_column_text(statement,7);
            NSString *l7 = [[NSString alloc]initWithUTF8String:n7] ;
            char *n8= (char *)sqlite3_column_text(statement, 8);
            NSString *l8 = [[NSString alloc]initWithUTF8String:n8] ;
            char *n9= (char *)sqlite3_column_text(statement, 9);
            NSString *l9 = [[NSString alloc]initWithUTF8String:n9] ;
            NSLog(@"%@   %@       %@      %@       %@        %@         %@       %@           %@",l1,l2,l3,l4,l5,l6,l7,l8,l9);
            
            NSMutableDictionary *dicarr =[[NSMutableDictionary alloc]init];
            [dicarr setValue:l1  forKey:@"division"];
            [dicarr setValue:l2 forKey:@"email"];
            [dicarr setValue:l3 forKey:@"id"];
            [dicarr setValue:l4 forKey:@"mobile"];
            [dicarr setValue:l5 forKey:@"name"];
            [dicarr setValue:l6 forKey:@"picfiletime"];
            [dicarr setValue:l7 forKey:@"picurl"];
            
            [dicarr setValue:l8 forKey:@"postion"];
            [dicarr setValue:l9 forKey:@"username"];
            [dataDic addObject:dicarr];
            
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    
    arrayDictKey  = [[NSMutableArray alloc]init];
    for (int i =0; i<dataDic.count;i++) {
        
        NSString *zimu=@"";
        //[[ChineseToPinyin pinyinFromChiniseString:[[dataDic objectAtIndex:i] objectForKey:@"name"]]substringToIndex:1];
        if (![[dataDic objectAtIndex:i] objectForKey:@"username"]) {
            zimu=    [[ChineseToPinyin pinyinFromChiniseString:[[dataDic objectAtIndex:i] objectForKey:@"username"]]substringToIndex:1];
        }else
        {
            zimu=    [[ChineseToPinyin pinyinFromChiniseString:[[dataDic objectAtIndex:i] objectForKey:@"username"]]substringToIndex:1];
        }
        
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
    [haoYoutableView reloadData];
    if (dataDic.count==0) {
        [self loadData];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleLabel setText:@"联系人"];
    [self setTabBarIndex:2];
    dataDic= [[NSMutableArray alloc]init];
    dataArray = [[NSMutableArray alloc]init];
    arrayDict = [[NSMutableDictionary alloc]init];
    [self initTableView];
    [self getsqldata];
}
-(void)selectqun
{
    FvaluequnIndexVC *vc=[[FvaluequnIndexVC alloc]init];
     [self.navigationController pushViewController:vc animated:NO];
}
#pragma -mark -functions
- (void)initTableView
{
    //UITableView
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    self.searchBar.placeholder = @"请输入搜索内容";
    self.searchBar.delegate = self;
    self.strongSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.delegate = self;
//    UIButton *qunbtn = [[UIButton alloc]initWithFrame:CGRectMake(80, 10, 60, 60)];
//    qunbtn.backgroundColor = [UIColor orangeColor];
//    [qunbtn setTitle:@"我的群" forState: UIControlStateNormal];
//    [qunbtn.titleLabel setFont:[UIFont fontWithName:KUIFont size:13]];
//    qunbtn.layer.cornerRadius = 30;//设置那个圆角的有多圆
//    qunbtn.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
//    qunbtn.layer.borderColor = [[UIColor blackColor] CGColor];//设置边框的颜色
//    qunbtn.layer.masksToBounds = YES;
//    
//    UIButton *qunbtn2 = [[UIButton alloc]initWithFrame:CGRectMake(180, 10, 60, 60)];
//    qunbtn2.backgroundColor = [UIColor orangeColor];
//    [qunbtn2 setTitle:@"查找群" forState: UIControlStateNormal];
//    [qunbtn2.titleLabel setFont:[UIFont fontWithName:KUIFont size:13]];
//    qunbtn2.layer.cornerRadius = 30;//设置那个圆角的有多圆
//    qunbtn2.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
//    qunbtn2.layer.borderColor = [[UIColor blackColor] CGColor];//设置边框的颜色
//    qunbtn2.layer.masksToBounds = YES;
//
//    [qunbtn addTarget:self action:@selector(selectqun) forControlEvents:UIControlEventTouchDown];
    UIImageView *qunimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [qunimage setImage:[UIImage imageNamed:@"qunherad"]];
    
    UILabel *textlale = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 100, 40)];
    [textlale setText:@"群聊"];
    [textlale setFont:[UIFont fontWithName:KUIFont size:14]];
    [textlale setTextColor:[UIColor grayColor]];
    
    
    UIView *showview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    showview.backgroundColor = [UIColor whiteColor];
    [showview addSubview:qunimage];
    [showview addSubview:textlale];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    [btn addTarget:self action:@selector(selectqun) forControlEvents:UIControlEventTouchDown];
    btn.backgroundColor=[UIColor clearColor];
    [showview addSubview:btn];
    
    haoYoutableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [haoYoutableView setTableHeaderView:showview];
    
    [haoYoutableView setBackgroundColor:[UIColor clearColor]];

    [haoYoutableView setShowsVerticalScrollIndicator:NO];
    [haoYoutableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    haoYoutableView.dataSource=self;
    haoYoutableView.delegate=self;
    //设置右侧索引栏
//    UIImageView *imageview = [UIImageView new];
//    imageview.image = [UIImage imageNamed:@"4buffer.jpg"];
//    imageview.frame = haoYoutableView.bounds;
//    haoYoutableView.backgroundView=imageview;
    
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
        ContactViewController *vc = [[ContactViewController alloc]init];
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
   ContactViewController *vc = [[ContactViewController alloc]init];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   /*
    static NSString *cellString=@"cellId";
    
    ContactTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell==nil) {
        cell=[[ContactTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellString];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    }
    */
    //2014.05.15 chenlihua 解决图片复用的问题
    //图片加载时候正确，但是上下滑动时，会导致图片错乱。
    ContactTableViewCell *cell=[[ContactTableViewCell alloc]init];
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    

//    dic = [array objectAtIndex:indexPath.row];
    
     //头像
   // [cell.headView getImageFromURL:[NSURL URLWithString:[dic objectForKey:@"picurl"]]];
    
    //2014.06.12 chenlihua 修改图片缓存的方式
    NSLog(@"----array-Dic--%@",arrayDict);
    NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
    NSString *username=[[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"username"];
    NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",username ,  [[UserInfo sharedManager]username]]];

    
    [cell.headView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
    [cell.headView.layer setMasksToBounds:YES];
    
    [cell.headView.layer setCornerRadius:10.0f];
    //2014.05.29 直接在聊天界面调用联系人接口。此部分代码注释掉。
    //2014.05.26 chenlihua 把头像URL以姓名为标志，保存在本地。
    /*
    NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
    [headImageUrl setObject:[dic objectForKey:@"picurl"] forKey:[dic objectForKey:@"username"]];
    [headImageUrl synchronize];
    
     NSLog(@"---缓存---picurl---%@-------",[headImageUrl objectForKey:[dic objectForKey:@"username"]]);
    */
   NSUInteger sectionMy = [indexPath section];
    NSString *username2=[[[arrayDict objectForKey:[arrayDictKey objectAtIndex:sectionMy]] objectAtIndex:indexPath.row] objectForKey:@"username"];


//    NSString *name =[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"relname%@",username2]];
    [cell.xingmlab setText:username2];
    return cell;
}

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
//    NSArray *array = nil;
//    if (indexPath.section == 0) {
//        array = [dataDic objectForKey:@"prolist"];
//    }else if (indexPath.section == 1) {
//        array = [dataDic objectForKey:@"fclist"];
//    }else{
//        array = [dataDic objectForKey:@"invlist"];
//    }
//
    NSArray *array=  [arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]];
    NSLog(@"%@",array);
    NSDictionary *myDic = [array objectAtIndex:indexPath.row];
    NSLog(@"%@",myDic);
    [[NetManager sharedManager] getHeadImageDetailInformationWithusername:[myDic objectForKey:@"username"] hudDic:nil success:^(id responseDic) {
        NSLog(@"在聊天界面点击联系人头像跳转到详细页面，成功获取数据，，responseDic--%@",responseDic);
        NSDictionary *detailDic=[responseDic objectForKey:@"data"];
        NSLog(@"-----detailDic----%@",detailDic);
        FvaluePeopleData *vc = [[FvaluePeopleData alloc]init];
        //        PersonalDataVC *vc = [[PersonalDataVC alloc]init];
        vc.peopledic = myDic;
        [self.navigationController pushViewController:vc
                                             animated:NO];
      
        
    } fail:^(id errorString) {
        NSLog(@"在聊天界面点击联系人头像跳转到详细页面，获取数据失败");
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:errorString delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
         [alert show];
        
    }];
    
//    NSArray *array = nil;
//    if (indexPath.section == 0) {
//        array = [dataDic objectForKey:@"prolist"];
//    }else if (indexPath.section == 1) {
//        array = [dataDic objectForKey:@"fclist"];
//    }else{
//        array = [dataDic objectForKey:@"invlist"];
//    }
//    NSArray *array=  [arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]];
//    NSLog(@"%@",array);
//    NSDictionary *myDic = [array objectAtIndex:indexPath.row];
//    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!myDic = %@",myDic);
//    //如果是自己的话，显示详细信息，如果是别人的话，就显示简介。
//    if ([[myDic valueForKey:@"id"] isEqualToString:[[UserInfo sharedManager] userid]]) {
////
////
////        
//        
//        MineInFoemationViewController* viewCon = [[MineInFoemationViewController alloc] init];
//        viewCon.ismine = YES;
//        [self.navigationController pushViewController:viewCon animated:YES];
//    }else{
////
////        /*
////        ChatWithFriendViewController *cfVc=[[ChatWithFriendViewController alloc]init];
////        cfVc.talkId=[myDic objectForKey:@"id"];
////        cfVc.title=@"聊天";
////        cfVc.entrance = @"contact";
////        cfVc.contactInfo = myDic;
////        cfVc.userName=[myDic objectForKey:@"name"];
////        
////        NSLog(@"--------------由联系人跳转到聊天界面---------------");
////        NSLog(@"---talkID--%@---cfvc.titile--%@---cfvc.entrance---%@---cfvc.contactInfo--%@---cfvc.username--%@",cfVc.talkId,cfVc.title,cfVc.entrance,cfVc.contactInfo,cfVc.userName);
////        
////        NSLog(@"cfvc.username....%@......",cfVc.userName);
////        [self.navigationController pushViewController:cfVc animated:YES];
////        */
////    
//        NSDictionary *myDic = [array objectAtIndex:indexPath.row];
//        NSLog(@"%@'",myDic);
//        NSLog(@"%@",dataDic);
//        //2014.05.05 chenlihua 联系人界面1对1发消息，不正常显示记录
////        ChatWithFriendViewController *viewCon=[[ChatWithFriendViewController alloc]init];
////        viewCon.entrance = @"qun";
////        viewCon.talkId=[myDic objectForKey:@"id"];
////        viewCon.titleName=[myDic objectForKey:@"name"];
////        viewCon.memberCount =@"2";
////        //[dataDic objectForKey:@"mcnt"];
////        viewCon.where=@"insider";
//
////        [self.navigationController pushViewController:viewCon animated:NO];
//        
//        JianJieViewController *view=[[JianJieViewController alloc]init];
////
//        view.myDiction = myDic;
//        NSLog(@"----联系人点击后跳转到详细页面--view.myDiction---%@",view.myDiction);
//        [self.navigationController pushViewController:view animated:YES];
//
//    }
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
