
//
//  FvalueIndexVC.m
//  FangChuang
//
//  Created by weiping on 14-10-17.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvalueIndexVC.h"
#import "FangChuangInsiderViewController.h"
#import "TSPopoverController.h"
#import "TSActionSheet.h"
#import "RootViewController.h"
@interface FvalueIndexVC ()

@end

@implementation FvalueIndexVC
@synthesize searchBar,arrUnSendCollection;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma  -mark -pullingrefreshTableView delegate
//载入数据的时候，（往下拉）
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
      [myTableView reloadData];
}
//重新刷新的时候（往下拉）
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
      [myTableView reloadData];
}
-(void)viewDidDisappear:(BOOL)animated
{
  
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [self.view.layer removeAllAnimations];
 
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",currentIndex] forKey:@"currentIndex"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"indexvcrelodata" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"indexvcrelodata2" object:nil];
    if (choessvc!=1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"downsoket" object:nil];
    }

  
}
-(void)getContractHeadImage
{
    
    [[NetManager sharedManager] getdiscussion_ulistWithuserName:[[UserInfo sharedManager] username]
                                                         hudDic:nil
                                                        success:^(id responseDic) {
                                                            NSLog(@"%@",responseDic);
                                                            NSMutableDictionary *conDic = [[NSMutableDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
                                                            NSArray *arr1=[[NSArray alloc]init];
                                                            arr1=[conDic objectForKey:@"ulist"];
                                                            for (NSDictionary *dic in arr1){
                                                                NSUserDefaults *headImageUrl1=[NSUserDefaults standardUserDefaults];
                                                                NSLog(@"%@",[dic objectForKey:@"username"]);
                                                                [headImageUrl1 setObject:[dic objectForKey:@"picurl"] forKey:[dic objectForKey:@"username"]];
                                                                [headImageUrl1 synchronize];
                                                                
                                                            }
                                                        } fail:^(id errorString) {
                                                            
                                                        }];
    
    
    
}
-(void)getdtypeunread
{
    [unLabel0 setHidden:NO];
    [unLabel1 setHidden:NO];
    [unLabel2 setHidden:NO];
    [unLabel3 setHidden:NO];
    NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
    dataArray[currentIndex] =[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",currentIndex,[[UserInfo sharedManager] username]]]];
    
    
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
  
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tuichudenglu"];
    
	[[NSUserDefaults standardUserDefaults] synchronize];
//    [self addnotity];

    findstate=0;
    SUserDB * db = [[SUserDB alloc] init];
    [db createDataBase:@"SUser"];
    _userDB = [[SUserDB alloc] init];
    dgidarr = [[NSMutableArray alloc]init];
    [self setTitle:@"方创"];
    [self addtheview];
    [self addtableview];

    currentPage = 1;
    currentIndex=1;

    for (int i = 0; i<4; i++) {
        dataArray[i]=[[NSMutableArray alloc]init];
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"nosave"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
    if ([unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",currentIndex,[[UserInfo sharedManager] username] ]] !=nil) {
        dataArray[currentIndex]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",currentIndex,[[UserInfo sharedManager] username] ]]];
    }

    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"indexvcrelodata"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(relodata:)name:@"indexvcrelodata" object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(httpreload)name:@"indexvcrelodata2" object:nil];//indexshuaxin

    
   if ([[NSUserDefaults standardUserDefaults] objectForKey:@"relodataarr"]!=nil) {
     
       if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"relodataarr"] count]==2) {
        [self relodataarr: [[NSUserDefaults standardUserDefaults] objectForKey:@"relodataarr"]];
       }
      
      
   }
    [self httpreload];
}

- (void)httpreload
{
    [myTableView reloadData];
//    [NSMutableArray arrayWithArray:[_userDB findWithUid2:[dataDic objectForKey:@"dgid"] limit2:1]];
//    if ([_userDB findWithUiddtype:@"1" limitdtype:1].count>0) {
//        [unLabel0 setHidden:NO];
//        [unLabel0 setText:[NSString stringWithFormat:@"%d",[_userDB findWithUiddtype:@"1" limitdtype:1].count]];
//
//    }
//    if ([_userDB findWithUiddtype:@"2" limitdtype:1].count>0) {
//        [unLabel1 setHidden:NO];
//        [unLabel1 setText:[NSString stringWithFormat:@"%d",[_userDB findWithUiddtype:@"2" limitdtype:1].count]];
//    }
//    if ([_userDB findWithUiddtype:@"3" limitdtype:1].count>0) {
//        [unLabel2 setHidden:NO];
//        [unLabel2 setText:[NSString stringWithFormat:@"%d",[_userDB findWithUiddtype:@"3" limitdtype:1].count]];
//    }
//    if ([_userDB findWithUiddtype:@"4" limitdtype:1].count>0) {
//        [unLabel3 setHidden:NO];
//        [unLabel3 setText:[NSString stringWithFormat:@"%d",[_userDB findWithUiddtype:@"4" limitdtype:1].count]];
//    }

}
-(void)relodataarr:(NSArray *)arr
{

    NSInteger index=[[arr objectAtIndex:1] intValue];
    NSInteger dgids =[[arr objectAtIndex:0]intValue];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"relodataarr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
    dataArray[index] = [[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
    if (dataArray[index].count>0) {
        for (int i=0; i< dataArray[index].count; i++) {
            NSInteger dgidm =[[[dataArray[index] objectAtIndex:i] objectForKey:@"dgid"]intValue];
            if (dgidm==dgids)
            {
                
                if (i!=0) {
                    [dataArray [index] exchangeObjectAtIndex:0 withObjectAtIndex:i];
                    for (int j=1; j<dataArray[index].count;j++) {
                        [dataArray [index] exchangeObjectAtIndex:i withObjectAtIndex:j];
                    }
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
                    [userDefault synchronize];
                    [myTableView reloadData];
                    return;
                }else
                {
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
                    [userDefault synchronize];
                    [myTableView reloadData];
                    return;
                    
                }
                
            }
        }
        [[NetManager sharedManager]getdisginfoWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] dgid:[arr objectAtIndex:0] hudDic:nil success:^(id responseDic) {
            sleep(1);
            dataArray[index]=[[NSMutableArray alloc] init];
            NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
            if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
                ;
            }else{
                dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
            }
            NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
            [dic setValue:[arr objectAtIndex:0] forKey:@"dgid"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dpicurl"] forKey:@"dpicurl"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"] forKey:@"mcnt"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dname"] forKey:@"dname"];
            
            for (int i = 0; i<dataArray[currentIndex].count; i++) {
                NSInteger dgidm=[[[dataArray[currentIndex] objectAtIndex:i] objectForKey:@"dgid"] intValue];
                if (dgids==dgidm) {
                    return ;
                }
               
            }
             [dataArray[index] addObject:dic];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
            [userDefault synchronize];
            
            [myTableView reloadData];
        } fail:^(id errorString) {  }];
        
        
    }else
    {
        
        [[NetManager sharedManager]getdisginfoWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] dgid:[arr objectAtIndex:0] hudDic:nil success:^(id responseDic) {
            sleep(1);
            dataArray[index]=[[NSMutableArray alloc] init];
            
            NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
            if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
                ;
            }else{
                dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
            }
            NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
            [dic setValue:[NSString stringWithFormat:@"%d",dgids] forKey:@"dgid"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dpicurl"] forKey:@"dpicurl"];
            
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"] forKey:@"mcnt"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dname"] forKey:@"dname"];
            for (int i = 0; i<dataArray[currentIndex].count; i++) {
                NSInteger dgidm =[[[dataArray[index] objectAtIndex:i] objectForKey:@"dgid"]intValue];
                if (dgidm==dgids) {
                    return ;
                }
               
                
            }
             [dataArray[index] addObject:dic];
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
            [userDefault synchronize];
            [myTableView reloadData];
        }fail:^(id errorString) {}];
    }
    
    

}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)relodata:(NSNotification*) notification
{
    NSArray *arr= notification.object;
    NSInteger index=[[arr objectAtIndex:1] intValue];
    NSInteger dgids =[[arr objectAtIndex:0]intValue];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"relodataarr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
    dataArray[index] = [[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
    
    
    if (dataArray[index].count>0) {
        
        for (int i=0; i< dataArray[index].count; i++) {
        NSInteger dgidm =[[[dataArray[index] objectAtIndex:i] objectForKey:@"dgid"]intValue];
            if (dgidm==dgids)
            {
                
                if (i!=0) {
                    [dataArray [index] exchangeObjectAtIndex:0 withObjectAtIndex:i];
                    for (int j=1; j<dataArray[index].count;j++) {
                        [dataArray [index] exchangeObjectAtIndex:i withObjectAtIndex:j];
                    }
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
                    [userDefault synchronize];
                    [myTableView reloadData];
                    return;
                }else
                {
                   NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                        [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
                        [userDefault synchronize];
                        [myTableView reloadData];
                        return;
               
                }
                
            }
        }
        [[NetManager sharedManager]getdisginfoWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] dgid:[arr objectAtIndex:0] hudDic:nil success:^(id responseDic) {
            sleep(1);
            dataArray[index]=[[NSMutableArray alloc] init];
            NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
            if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
                ;
            }else{
                dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
            }
            NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
            [dic setValue:[arr objectAtIndex:0] forKey:@"dgid"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dpicurl"] forKey:@"dpicurl"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"] forKey:@"mcnt"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dname"] forKey:@"dname"];
            NSLog(@"----返回的数据-1--%@",dic);
            for (int i = 0; i<dataArray[index].count; i++) {
                NSInteger dgidm=[[[dataArray[currentIndex] objectAtIndex:i] objectForKey:@"dgid"] intValue];
               
                if (dgidm==dgids) {
                    return ;
                }
          
            }
         
            [dataArray[index] addObject:dic];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

             [dataArray [index] exchangeObjectAtIndex:0 withObjectAtIndex:dataArray[index].count-1];
            [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
            [userDefault synchronize];
            [myTableView reloadData];

        } fail:^(id errorString) {  }];
       
        
    }else
    {
        
        [[NetManager sharedManager]getdisginfoWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] dgid:[arr objectAtIndex:0] hudDic:nil success:^(id responseDic) {
           sleep(1);
            dataArray[index]=[[NSMutableArray alloc] init];
            
            NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
            if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
                ;
            }else{
                dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
            }
            NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
            [dic setValue:[NSString stringWithFormat:@"%d",dgids] forKey:@"dgid"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dpicurl"] forKey:@"dpicurl"];
            
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"] forKey:@"mcnt"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dname"] forKey:@"dname"];
            NSLog(@"--返回的数据---2--%@",dic);
            
            for (int i = 0; i<dataArray[index].count; i++) {
                  NSInteger dgidm =[[[dataArray[index] objectAtIndex:i] objectForKey:@"dgid"]intValue];
                if (dgidm==dgids) {
                    return ;
                }
              
                
            }
           [dataArray[index] addObject:dic];
          
           NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
            [userDefault synchronize];
            [myTableView reloadData];

        }fail:^(id errorString) {}];
    }


}
-(void)reloadData;
{
  [myTableView reloadData];
}
-(void)viewlodata
{


//    NSString *perpageString=[NSString stringWithFormat:@"%d",currentPage*20];
//    
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@groups%d",[[UserInfo sharedManager] username],currentIndex]]!=nil) {
//        
//        NSDictionary *dic =[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@groups%d",[[UserInfo sharedManager] username],currentIndex]];
//        NSLog(@"%@",dic);
//        dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
//        [myTableView reloadData];
//    }
//    else
//    {
//     [[NetManager sharedManager] indexWithusername:[[UserInfo sharedManager] username] dtype:[NSString stringWithFormat:@"%d",currentIndex] perpage:perpageString pagenum:@"1" hudDic:nil success:^(id responseDic) {
//        NSDictionary *dic = [responseDic objectForKey:@"data"];
//        NSLog(@"%@",dic);
//        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:[NSString stringWithFormat:@"%@groups%d",[[UserInfo sharedManager] username],currentIndex]];
//        dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
//        [myTableView reloadData];
//        
//    } fail:^(id errorString) {
//    }];
//    }


}

-(void) showActionSheet:(id)sender forEvent:(UIEvent*)event
{
    TSActionSheet *actionSheet = [[TSActionSheet alloc] initWithTitle:@""];
    [actionSheet destructiveButtonWithTitle:@"发起群聊" block:^
     {
              [self rightButton:sender];
     }];
  [actionSheet addButtonWithTitle:@"106发来10条快速创群通知" block:^{
      NSArray *mesDicarr=[NSArray arrayWithObjects:@"106",@"1", nil];
      for (int i=0; i<10; i++) {
             [[NSNotificationCenter defaultCenter] postNotificationName:@"indexvcrelodata" object:mesDicarr];
      }
     
      }];
   [actionSheet addButtonWithTitle:@"781发来10条快速创群通知" block:^{
       NSArray *mesDicarr=[NSArray arrayWithObjects:@"781",@"1", nil];
       for (int i=0; i<10; i++) {
           [[NSNotificationCenter defaultCenter] postNotificationName:@"indexvcrelodata" object:mesDicarr];
       }
    
   }];

     actionSheet.cornerRadius = 3;
//    
    [actionSheet showWithTouch:event];
}

-(void)addtheview
{
    [self setTabBarIndex:0];
       if ([[[UserInfo sharedManager] usertype] isEqualToString:@"1"]||[[[UserInfo sharedManager] usertype] isEqualToString:@"0"]) {
       }else
       {
    UIButton* rtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rtBtn setFrame:CGRectMake(320 - 44 - 10, 0, 44, 44)];
    [rtBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
    [rtBtn setImage:[UIImage imageNamed:@"fangchuangrightAdd"] forState:UIControlStateNormal];
   // [rtBtn addTarget:self action:@selector(showActionSheet:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [rtBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rtBtn isAutoFrame:NO];

       }
    //2014.05.29 chenlihua 在方创人，项目方，投资方，对接群，有未读消息的时候，显示红点。
    topView = [[ButtonColumnView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) delegate:self];
    
    if (![[[UserInfo sharedManager] usertype] isEqualToString:@"2"]) {
        topView.hidden = YES;
        
    }
    [self.contentView addSubview:topView];
    //2014.05.29 chenlihua 在方创人，项目方，投资方，对接群，有未读消息的时候，显示红点。
    unLabel0=[[UILabel alloc]initWithFrame:CGRectMake(65+80*0, 0, 15, 15)];
    [unLabel0 setTextColor:[UIColor whiteColor]];
    unLabel0.backgroundColor=[UIColor redColor];
    //    [unLabel0 setFont:[UIFont systemFontOfSize:13]];
    [unLabel0 setFont:[UIFont fontWithName:KUIFont size:8]];
    unLabel0.textAlignment=NSTextAlignmentCenter;
    unLabel0.tag=1000000+0;
    [unLabel0.layer setCornerRadius:7];
    [unLabel0.layer setMasksToBounds:YES];
    unLabel0.hidden=YES;
    
    [topView addSubview:unLabel0];
    
    
    unLabel1=[[UILabel alloc]initWithFrame:CGRectMake(65+80*1, 0, 15, 15)];
    [unLabel1 setTextColor:[UIColor whiteColor]];
    unLabel1.backgroundColor=[UIColor redColor];
    [unLabel1 setFont:[UIFont fontWithName:KUIFont size:8]];
    unLabel1.textAlignment=NSTextAlignmentCenter;
    unLabel1.tag=1000000+1;
    [unLabel1.layer setCornerRadius:7];
    [unLabel1.layer setMasksToBounds:YES];
    unLabel1.hidden=YES;
    [topView addSubview:unLabel1];
    
    
    unLabel2=[[UILabel alloc]initWithFrame:CGRectMake(65+80*2, 0, 15, 15)];
    [unLabel2 setTextColor:[UIColor whiteColor]];
    unLabel2.backgroundColor=[UIColor redColor];
    [unLabel2 setFont:[UIFont fontWithName:KUIFont size:8]];
    unLabel2.textAlignment=NSTextAlignmentCenter;
    unLabel2.tag=1000000+2;
    [unLabel2.layer setCornerRadius:7];
    [unLabel2.layer setMasksToBounds:YES];
    unLabel2.hidden=YES;
    [topView addSubview:unLabel2];
    
    unLabel3=[[UILabel alloc]initWithFrame:CGRectMake(65+80*3, 0, 15, 15)];
    unLabel3.backgroundColor=[UIColor redColor];
    [unLabel3 setTextColor:[UIColor whiteColor]];
    [unLabel3 setFont:[UIFont fontWithName:KUIFont size:8]];
    unLabel3.textAlignment=NSTextAlignmentCenter;
    unLabel3.tag=1000000+3;
    [unLabel3.layer setCornerRadius:7];
    [unLabel3.layer setMasksToBounds:YES];
    unLabel3.hidden=YES;
    [topView addSubview:unLabel3];
    

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
}
-(void)addtableview
{
    myTableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 30, 320, self.contentViewHeight-30) style:UITableViewStyleGrouped];
    if (![[[UserInfo sharedManager] usertype] isEqualToString:@"2"]) {
        myTableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight ) style:UITableViewStylePlain];
        
    }
    //    [myTableView setDelegate:self];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [myTableView setBackgroundColor:[UIColor whiteColor]];
    [myTableView setTableHeaderView:self.searchBar];
    myTableView.delegate = self;
    [myTableView setDataSource:self];
    myTableView.pullingDelegate=self;
    [myTableView setShowsVerticalScrollIndicator:NO];
//    [myTableView setBackgroundColor:[UIColor clearColor]];
          //分割线

    //2014.08.13 chenlihua 将系统自带的线隐藏。

    
    //2014.05.06 chenlihua 设置单元格可以被滑动删除
    // [myTableView setEditing:NO animated:YES];
    [myTableView setTableHeaderView:self.searchBar];
    myTableView.backgroundColor=[UIColor clearColor];
    myTableView.userInteractionEnabled=YES;
    [self.contentView addSubview:myTableView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview Delegete
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (dataArray[currentIndex].count>0) {
        FaFinancierWelcomeItemCell *cell=[[FaFinancierWelcomeItemCell alloc]init];
        cell.tag=indexPath.row;
//        if (cell==nil) {
          
//        }
        dataDic =[dataArray[currentIndex]objectAtIndex:indexPath.row];
        NSLog(@"%@",dataDic);
//        if ( [[dataDic objectForKey:@"dgid"]isEqualToString:@"404"]) {
//            FaFinancierWelcomeItemCell *cell=[[FaFinancierWelcomeItemCell alloc]init];
//            [cell.titleLab setText:@"[通知]"];
//            [cell.avatar setImage:[UIImage imageNamed:@"fanotifty"]];
//            cell.subTitleLab.text=@"";
//            [cell.unReadLabel setHighlighted:NO];
//            [cell.unReadLabel setText:@"⭐️"];
//            return cell;
//        }
        NSLog(@"-----danme---%@",[dataDic objectForKey:@"dname"]);
        
           [cell.titleLab setText:[dataDic objectForKey:@"dname"]];
        
        
        if ([[dataDic objectForKey:@"mcnt"] isEqualToString:@"1"]){
            //显示自己
            NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
            NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",[dataDic objectForKey:@"dgcreateby"] ,   [[UserInfo sharedManager]username]]];
            [cell.avatar setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] success:^(UIImage *image){} failure:^(NSError *error){} ];
            [cell.titleLab setText:[dataDic objectForKey:@"dgcreateby"]];
            
        }else if ([[dataDic objectForKey:@"mcnt"] isEqualToString:@"2"]){
            
            //显示对方
            NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
            NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",[dataDic objectForKey:@"dname"] ,   [[UserInfo sharedManager]username]]];
            NSLog(@"-clh--urlString---%@",urlString);
            [cell.avatar setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] success:^(UIImage *image){} failure:^(NSError *error){} ];

        }else{
            
            //显示服务器返回的
              [cell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] success:^(UIImage *image){} failure:^(NSError *error){} ];
        }
        
        
        
        /*
        if ([[dataDic objectForKey:@"mcnt"] isEqualToString:@"2"]) {
        
           
            if ([[dataDic objectForKey:@"dgcreateby"] isEqualToString:[[UserInfo sharedManager] username]])
            {
                
                NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
                NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",[dataDic objectForKey:@"dname"] ,   [[UserInfo sharedManager]username]]];
                NSLog(@"-clh--urlString---%@",urlString);
                 [cell.avatar setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] success:^(UIImage *image){} failure:^(NSError *error){} ];
            }  else
            {
                //自己的
                NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
                NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",[dataDic objectForKey:@"dgcreateby"] ,   [[UserInfo sharedManager]username]]];
                [cell.avatar setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] success:^(UIImage *image){} failure:^(NSError *error){} ];
               [cell.titleLab setText:[dataDic objectForKey:@"dgcreateby"]];
            }
             

         
        }else
        {
      
              [cell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] success:^(UIImage *image){} failure:^(NSError *error){} ];
        }

         */
        
        NSString *unsend = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@unsend",cell.titleLab.text]] ;
        if (unsend.length>0) {

            cell.subTitleLab.text =[NSString stringWithFormat:@"[草稿]%@",unsend];
            cell.subTitleLab.textColor = [UIColor redColor];
            
        }else
        {
            
            NSMutableArray    *unredmes  = [[NSMutableArray alloc]init];
            @try {
             
                unredmes    =  [NSMutableArray arrayWithArray:[_userDB findWithUid2:[dataDic objectForKey:@"dgid"] limit2:1]];
                if (unredmes.count>0) {
                    
                       
                          cell.subTitleLab.text =[NSString stringWithFormat:@"%@:%@", [[unredmes objectAtIndex:0] objectAtIndex:2], [[unredmes objectAtIndex:0] objectAtIndex:1]] ;
                      NSLog(@"%@",unredmes);
                            NSLog(@"%@",cell.subTitleLab
                                  .text);
                            NSString *lengstr = [[unredmes objectAtIndex:0] objectAtIndex:2];
                            if (lengstr.length<2) {
                                cell.subTitleLab.text =[NSString stringWithFormat:@"%@%@", [[unredmes objectAtIndex:0] objectAtIndex:2], [[unredmes objectAtIndex:0] objectAtIndex:1]] ;
                            }
                    
                    
                }
               
                NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
                [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                NSString *datetime= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];
                datetime = [datetime substringToIndex:10];
                NSString *timer = [[unredmes objectAtIndex:0] objectAtIndex:5];
                NSString *truetime = timer;
                timer = [timer substringToIndex:10];
                
                if ([datetime isEqualToString:timer]) {
                     timer = [NSString stringWithFormat:@"今天 %@ ",[[truetime substringFromIndex:10]substringToIndex:6]];
                    
                    
//                    [timer substringToIndex:<#(NSUInteger)#>]
                }else
                {
                    timer = [[truetime substringFromIndex:5]substringToIndex:11];
                }
            
               
                 [cell.timelable setText:timer];

                [cell.unReadLabel setHidden:NO];
                NSInteger numcount2=[_userDB findWithUid5:[dataDic objectForKey:@"dgid"] limit5:1];
                cell.unReadLabel.text = [NSString stringWithFormat:@"%d", numcount2];
                if (numcount2<=0) {
                    [cell.unReadLabel setHidden:YES];
                }
//                if (numcount2>99) {
//                    [cell.unReadLabel setHidden:NO];
//                    cell.unReadLabel.text =@"99+";
//                    [cell.unReadLabel  setFont:[UIFont fontWithName:KUIFont size:8]];
//                }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            


           
           
          
            
        }
        
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray[currentIndex].count;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete ;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//删除事件
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSInteger index = currentIndex;
        dataArray[index]=[[NSMutableArray alloc] init];
        NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
        if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
            ;
        }else{
            dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
        }
        NSDictionary *dic =   [dataArray[currentIndex]objectAtIndex:indexPath.row];
        NSUserDefaults *unSendDefault2 = [NSUserDefaults standardUserDefaults];
        if (![unSendDefault2 objectForKey:[NSString stringWithFormat:@"dgidarr%@",[[UserInfo sharedManager] username]]]) {
            ;
        }else{
            dgidarr=[[NSMutableArray alloc]initWithArray:[unSendDefault2 objectForKey:[NSString stringWithFormat:@"dgidarr%@",[[UserInfo sharedManager] username]]]];
            
        }
//        NSLog(@"%@",[[dataArray[index] objectAtIndex:indexPath.row] objectForKey:@"dgid"]);
//        NSLog(@"%@",dgidarr);
//        NSLog(@"%@",[[dataArray[currentIndex] objectAtIndex:indexPath.row] objectForKey:@"dgid"]);
          NSString *dgid=[[dataArray[index] objectAtIndex:indexPath.row] objectForKey:@"dgid"];
//
//            if ([dgidarr containsObject:dgid]) {
//                
//                 [dgidarr removeObject:dgid];
//                
                for (int i=0; i<dataArray[index].count; i++) {
                    if ([[dataArray[index] objectAtIndex:i] containsObject:dgid]) {
                        [dataArray[index] removeObjectAtIndex:i];
                    }
                }
//
//              }

//        NSUserDefaults *userDefault2 = [NSUserDefaults standardUserDefaults];
//        [userDefault2 setObject:dgidarr forKey:[NSString stringWithFormat:@"dgidarr%@",[[UserInfo sharedManager] username]]];
//        [userDefault2 synchronize];
    
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
        [userDefault synchronize];
        
     [myTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
   
     [myTableView reloadData];
        
        



    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    choessvc=1;
    ChatWithFriendViewController *viewCon=[[ChatWithFriendViewController alloc]init];
    dataDic =[dataArray[currentIndex]objectAtIndex:indexPath.row];

    if (dataDic.count>=5) {
        if (/*[[dataDic objectForKey:@"dgid"] isEqualToString:@"404"]*/1==2) {
            
            NotifyVC *vc= [[NotifyVC alloc]init];
           [self.navigationController pushViewController:vc animated:NO];
            
        }else
        {
            [[NSUserDefaults standardUserDefaults] setObject:[dataDic objectForKey:@"dgid"] forKey:@"nosave"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"indexvcrelodata"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            viewCon.entrance = @"qun";
            viewCon.talkId=[dataDic objectForKey:@"dgid"];
            viewCon.titleName=[dataDic objectForKey:@"dname"];
            viewCon.memberCount = [dataDic objectForKey:@"mcnt"];
            viewCon.qunzhuname =[dataDic objectForKey:@"dgcreateby"];
            if ([[dataDic objectForKey:@"mcnt"] isEqualToString:@"2"]) {
                viewCon.titleName=[dataDic objectForKey:@"dgcreateby"];
                if ([[dataDic objectForKey:@"dgcreateby"]isEqualToString:[[UserInfo sharedManager] username]]) {
                viewCon.titleName=[dataDic objectForKey:@"dname"];
                } 
            }
            viewCon.where=@"insider";
            NSString *cellcount=@"" ;
            if ( [[NSUserDefaults standardUserDefaults] objectForKey:viewCon.titleName]!=nil) {
                cellcount =  [[NSUserDefaults standardUserDefaults] objectForKey:viewCon.titleName];
            }
            
            [_userDB mergeWithUser:[[dataArray[currentIndex] objectAtIndex:indexPath.row] objectForKey:@"dgid"] ];
            
            NSString  *tokenString=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"];
            
            [[NetManager sharedManager] setPushJobNumWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] dgid:[dataDic objectForKey:@"dgid"] pushtoken:tokenString jobnum:cellcount hudDic:nil success:^(id responseDic) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:viewCon.titleName];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            } fail:^(id errorString) {  }];
//            NSInteger index =  1;
//            dataArray[index]=[[NSMutableArray alloc] init];
//            NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
//            if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
//                ;
//            }else{
//                dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
//            }
//            for (int i =0; i<dataArray[index].count; i++) {
//                if ([[dataArray[index] objectAtIndex:i]containsObject:[dataDic objectForKey:@"dgid"]]) {
//                    [dataArray [index] exchangeObjectAtIndex:0 withObjectAtIndex:i];
//                }
//            }
//            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//            [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
//            [userDefault synchronize];
            [self.navigationController pushViewController:viewCon animated:NO];
            
        }
    }

    
 
}




#pragma mark - UISearchBar Delegete
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if (findstate==0) {
    myTableView.frame = CGRectMake(0, 30, 320, self.contentViewHeight ) ;
    FvalueIndexVC *vc = [[FvalueIndexVC alloc]init];
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
 
  
        myTableView.frame = CGRectMake(0, 30, 320, self.contentViewHeight ) ;
        FvalueIndexVC *vc = [[FvalueIndexVC alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self setNavigationViewHidden:NO];
        
    
    
}
//点击准备输入a
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar2
{
    
    myTableView.frame = CGRectMake(0, 0, 320, self.contentViewHeight ) ;
   
    [self setNavigationViewHidden:YES];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    findstate = 1;
     myTableView.frame = CGRectMake(0, 0, 320, self.contentViewHeight ) ;
    SearchResultViewController* viewController = [[SearchResultViewController alloc] init];
    [viewController setKey:self.searchBar.text];
    [self.navigationController pushViewController:viewController animated:NO];
    [self setNavigationViewHidden:NO];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    myTableView.frame = CGRectMake(0, 30, 320, self.contentViewHeight ) ;
//    FvalueIndexVC *vc = [[FvalueIndexVC alloc]init];
//    [self.navigationController pushViewController:vc animated:NO];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    
//    [self setNavigationViewHidden:NO];
    
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
    
     [myTableView reloadData];
    
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
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewCon animated:NO];
    // 动画事件
  
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/

@end
