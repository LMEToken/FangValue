//
//  SelectContactViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-4-25.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//选择联系人（个人）
#import "SelectContactViewController.h"
#import "CacheImageView.h"
#import "FangChuangInsiderViewController.h"
#import "ChatWithFriendViewController.h"


//2014.06.13 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"


@interface SelectContactViewController ()

@end

@implementation SelectContactViewController
@synthesize  didString;
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
-(void)lodedata
{
    [[NetManager sharedManager] getdiscussion_ulistWithuserName:[[UserInfo sharedManager] username]
                                                         hudDic:nil
                                                        success:^(id responseDic) {
                                                            dataDic = [[NSMutableArray alloc]initWithArray:[[responseDic objectForKey:@"data"]objectForKey:@"ulist"]];
                                                            NSLog(@"%@",dataDic);
                                                            NSLog(@"%@",self.guoluarr );
                                                 
                                                   
                                                              
                                                                for (int j = 0; j<self.guoluarr.count; j++) {
                                                                        for (int i =0; i<dataDic.count; i++) {
                                                                    if ([[dataDic objectAtIndex:i] containsObject:[self.guoluarr objectAtIndex:j]]) {
                                                                        [dataDic removeObjectAtIndex:i];
                                                           
                                                                    }
                                                                }
                                                            }

                                                       
                                                            arrayDict = [[NSMutableDictionary alloc]init];
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

                                                                    }
                                                                }
                                                            }

                                                            [myTableView reloadData];
                                                        } fail:^(id errorString) {
                                                            
                                                            [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
                                                        }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.titleLabel setFont:[UIFont fontWithName:KUIFont size:20]];
    [self.titleLabel setText:@"添加群成员"];
    //返回按钮
    [self addBackButton];
    //隐藏TabBar
    [self setTabBarHidden:YES];
    currentIndex=1;
    [self lodedata];
    downArray = [[NSMutableArray alloc]init];
    dataSet = [[NSMutableSet alloc] init];
    dataDic= [[NSMutableArray alloc]init];
    chooseArr= [[NSMutableArray alloc]init];
    SUserDB * db = [[SUserDB alloc] init];
    [db createDataBase:@"SUser"];
    _userDB = [[SUserDB alloc] init];
    //联系人给所在的TableView
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight ) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.sectionIndexColor = [UIColor orangeColor];
    myTableView.sectionIndexBackgroundColor = [UIColor clearColor];
//    [myTableView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:myTableView];

    choessstate=0;
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-65, (44-25)/2, 70, 25)];
    
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    //    [rightButton setTitle:@"完成" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchDown];
    [rightButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:13]];
    [self addRightButton:rightButton isAutoFrame:NO];

    
}
#pragma -mark -doClickButton
- (void) backButtonAction : (id) sender
{
   [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"%@",downArray);
}

//开始添加群成员
- (void)start:(UIButton*)button
{

    if (self.guoluarr.count==-1&&[self.quntype isEqualToString:@"1v1"]) {
        NSLog(@"%@",self.guoluarr);
       [downArray addObject:[self.guoluarr objectAtIndex:0]];
       [downArray addObject:[self.guoluarr objectAtIndex:1]];
         NSLog(@"%@",downArray);
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
        [[NetManager sharedManager] createdisWithusername:[[UserInfo sharedManager] username]members:meberStr hudDic:nil success:^(id responseDic) {
                NSArray *arr = [NSArray arrayWithObjects:[[responseDic objectForKey:@"data"] objectForKey:@"did"],@"1", nil];
                [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"relodataarr"];
            [[NSUserDefaults standardUserDefaults] synchronize];
                QunLiaoMingChengViewController* vc = [[QunLiaoMingChengViewController alloc] init];
                [vc setDigId:[[responseDic objectForKey:@"data"] objectForKey:@"did"]];
                vc.groupChatName=[[responseDic objectForKey:@"data"] objectForKey:@"dname"];
                [self.navigationController pushViewController:vc animated:YES];
                
            } fail:^(id err){
                
                [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",err]];
            }];
            


    }else
    {
        
        
        //    NSInteger  currentIndex=1;
        //    NSInteger index = currentIndex;
        //    dataArray[index]=[[NSMutableArray alloc] init];
        //    NSUserDefaults *unSendDefault3 = [NSUserDefaults standardUserDefaults];
        //    if (![unSendDefault3 objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
        //        ;
        //    }else{
        //        dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault3 objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
        //    }
        //    for (int i=0; i<dataArray[currentIndex].count; i++) {
        //        if ([[dataArray[currentIndex] objectAtIndex:i]containsObject:self.didString]) {
        //            NSLog(@"%@",[dataArray[currentIndex] objectAtIndex:i]);
        //            NSDictionary *dicarr =  [dataArray[currentIndex] objectAtIndex:i];
        //            NSInteger mcnt = [[dicarr objectForKey:@"mcnt"] intValue]+downArray.count;
        //            NSMutableDictionary *ee = [[ NSMutableDictionary alloc]init];
        //            [ee setValue:[dicarr objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
        //            [ee setValue:[dicarr objectForKey:@"dgid"] forKey:@"dgid"];
        //            [ee setValue:[dicarr objectForKey:@"dname"] forKey:@"dname"];
        //            [ee setValue:[dicarr objectForKey:@"dpicurl"] forKey:@"dpicurl"];
        //            [ee setValue:[dicarr objectForKey:@"picurl1"]forKey:@"picurl1"];
        //            [ee setValue:[NSString stringWithFormat:@"%d",mcnt] forKey:@"mcnt"];
        //            [dataArray[currentIndex]  removeObjectAtIndex:i];
        //            [dataArray[currentIndex] addObject:ee];
        //        }
        //    }
        //
        //    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        //    [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
        //    [userDefault synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"creatteam"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //首先创建讨论组
        if (0 == downArray.count ) {
            [self.view showActivityOnlyLabelWithOneMiao:@"请选择联系人"];
            return;
        }
        NSLog(@"--添加群成员界面--初始化-----“请选择一个联系人");
        NSArray* mebers = [downArray mutableArrayValueForKeyPath:@"username"];//把字典中的某个key取出来，成为单个key的子数组。
        NSLog(@"---------downArray---%@---",downArray);
        for (NSString* str in mebers) {
            NSLog(@"meber \n%@",str);
        }
        NSString* meberStr = [mebers componentsJoinedByString:@","];//把value取出来，拼接成一个字符串
        
        NSLog(@"--------meberString \n%@-------",meberStr);
        
        //  meberStr = [meberStr stringByAppendingString:[NSString stringWithFormat:@",%@",[[UserInfo sharedManager] username]]];
        
        NSLog(@"------添加群成员---did %@---",didString);
        NSLog(@"---------添加群成员---grpmember--%@",meberStr);
        
        [[NetManager sharedManager] createGroupMemberWithusername:[[UserInfo sharedManager] username]
         
                                                              did:self.didString
                                                        grpmember:meberStr hudDic:nil success:^(id responseDic) {
                                                            NSLog(@"-----添加新成员成员成功----responseDic--%@",responseDic);
                                                            NSLog(@"%@",downArray);
                                                            //2014.04.29 chenlihua 添加人数成功，直接跳转到聊天界面
                                                            NSMutableString *addname=[[NSMutableString alloc]init];
                                                            for (int i = 0; i<downArray.count; i++) {
                                                                ;
                                                                [addname appendFormat:@"%@,",[[downArray objectAtIndex:i] objectForKey:@"username"]  ];
                                                            }
                                                            
                                                            if ([[addname substringFromIndex:addname.length-1] isEqualToString:@","]) {
                                                                addname =(NSMutableString *) [addname  substringToIndex:addname.length-1];
                                                            }
                                                           
                                                           /*
                                                            [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                                                                     talkId:self.didString
                                                                                contentType:@"0"
                                                                                   talkType:@"3"
                                                                                  vedioPath:@""
                                                                                    picPath:@""
                                                                                    content:[NSString stringWithFormat:@"%@邀请[%@]加入",[[UserInfo sharedManager] username],addname]
                                                                                       time:@""
                                                                                     isRead:@"0"
                                                                                     second:@""
                                                                                      MegId:[NSString stringWithFormat:@"%@邀请[%@]加入",[[UserInfo sharedManager] username],addname]
                                                                                   imageUrl:@""
                                                                                     openBy:@""];
                                                            
                                             SUser * user = [SUser new];
                                                            user.uid=self.didString;
                                                            user.titleName =self.didString;
                                                            user.conText = [NSString stringWithFormat:@"%@邀请[%@]加入",[[UserInfo sharedManager] username],addname];
                                                            user.contentType = @"3";
                                                            user.username =@"";
                                                            user.msgid =  @"";
                                                            user.description = @"";
                                                            user.readed=@"1";
                                                            [_userDB saveUser:user];
                                                            */
                                                            /*ChatWithFriendViewController*chatView=[[ChatWithFriendViewController alloc]init];
                                                             [self.navigationController pushViewController:chatView animated:YES];
                                                             */
                                                            //2014.05.21 chenlihua 添加新成员后，跳转到原来的群聊界面。
                                                            [self.navigationController popViewControllerAnimated:YES];
                                                        } fail:^(id errorString) {
                                                            
                                                            NSLog(@"----添加新成员失败------");
                                                            NSLog(@"------errorString---%@",errorString);
                                                         [self.view showActivityOnlyLabelWithOneMiao:errorString];
                                                            
                                                            
                                                        }];
        
        
        
        
        
        

    }

}
//选择按钮
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
  
//    if (choessstate==0) {
//         [button setBackgroundImage:[UIImage imageNamed:@"71_dian_2"] forState:UIControlStateNormal];
//        choessstate=1;
//    }else
//    {
//        choessstate=0;
//        [button setBackgroundImage:[UIImage imageNamed:@"71_dian_1"] forState:UIControlStateNormal];
//    }
    
//    if (!chooseArr) {
//    
//            for (int i =0; i<dataDic.count; i++) {
//            if ([[dataDic objectAtIndex:i] containsObject:flag]) {
//                [downArray addObject:[dataDic objectAtIndex:i] ];
//            }
//            [chooseArr addObject:flag];
//
//        }
//   
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
    
}//选择按钮里用到
- (CGRect)backgroundRectForBounds:(CGRect)bounds
{
    return bounds;
}
#pragma  -mark -UITableView Delegate

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
    return 50.0;  //控制行高
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = nil;
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ([tableView isEqual:myTableView]) {
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//            if (indexPath.row == 0) {
//                
//                UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake( 10, 7.5 , 200 , 15)];
//                
//                //选择一个群Label
//                [nameLabel setText:@"选择一个联系人:"];
//                [nameLabel setTextColor:ORANGE];
//                [nameLabel setFont:[UIFont fontWithName:KUIFont size:15]];
//                [nameLabel setBackgroundColor:[UIColor clearColor]];
//                [cell.contentView addSubview:nameLabel];
//                
//                
//                //添加箭头
//                
//                //                UIImageView* arrowImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"59_jiantou_1"]];
//                //
//                //                //15 * 26
//                //                [arrowImgV setFrame:CGRectMake(0, 0, 15 / 2., 13)];
//                //                [cell setAccessoryView:arrowImgV];
//                
//            }
//            else
//            {
                //cell背景图片
//                UIImage* bcImg = [UIImage imageNamed:@"63_kuang_1"];
//                UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), 55)];
//                [bcImgV setImage:bcImg];
//                [cell.contentView addSubview:bcImgV];
            
                //选择按钮
                UIButton* duiGouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [duiGouBtn setFrame:CGRectMake(10, (55 - 30) / 2., 30, 30)];
                duiGouBtn.tag = [[[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
                //2014.05.30 chenlihua 使添加群组界面在上下滑动时，原来选中的群前的勾会消失。
              //  [duiGouBtn setBackgroundImage:[UIImage imageNamed:@"71_dian_2"] forState:UIControlStateSelected];
                [duiGouBtn setBackgroundImage:[UIImage imageNamed:@"71_dian_1"] forState:UIControlStateNormal];
                [duiGouBtn backgroundRectForBounds:CGRectMake(7, 7, 16, 16)];
                [duiGouBtn imageRectForContentRect:CGRectMake(7, 7, 16, 16)];
                [duiGouBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:duiGouBtn];
                
                
                //2014.05.30 chenlihua 使添加群组界面在上下滑动时，原来选中的群前的勾会消失。
                NSLog(@"--cell中的---chooseArray---%@--",chooseArr);
                if (chooseArr.count>0) {
                    for (NSString *str in chooseArr) {
                        if ([str isEqualToString:[[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"id"] ]) {
                            [duiGouBtn setBackgroundImage:[UIImage imageNamed:@"71_dian_2"] forState:UIControlStateNormal];
                        }
                    }
                    
                }

                
                
                
                
                
                
                
                //名字前面的头像，头像获取数据为空
                /*
                CacheImageView* headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(duiGouBtn.frame) + 15,(55  - 81 / 2.)  / 2., 81 / 2., 81 / 2.)];
                [headImageView setTag:2000+indexPath.row];
                [headImageView setImage:[UIImage imageNamed:@"61_touxiang_1"]];
              //  [headImageView setImage:[UIImage imageNamed:[[data objectAtIndex:indexPath.row - 1] objectForKey:@"picurl"]]];
                
                //2014.05.04 chenlihua 解决添加群成员的时候，联系人界面为空的情况
                [headImageView getImageFromURL:[NSURL URLWithString:[[data objectAtIndex:indexPath.row - 1] objectForKey:@"picurl"]]];
                [cell.contentView addSubview:headImageView];
                */
                
                //2014.06.13 chenlihua 修改头像的缓存方式
                
                UIImageView* headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(duiGouBtn.frame) + 15,(55  - 81 / 2.)  / 2., 81 / 2., 81 / 2.)];
                [headImageView setTag:2000+indexPath.row];
                [headImageView setImageWithURL:[NSURL URLWithString: [[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"picurl2"]]  placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
                [headImageView.layer setCornerRadius:10.0];
                [headImageView.layer setMasksToBounds:YES];
                [cell.contentView addSubview:headImageView];
                
                
                //群名Label
                UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake( CGRectGetMaxX(headImageView.frame) + 5, (55 - 15) / 2., 320 - CGRectGetMaxX(headImageView.frame) - 15 , 15)];
                [nameLabel setText: [[[arrayDict objectForKey:[arrayDictKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"username"]];
                [nameLabel setTextColor:ORANGE];
                [nameLabel setFont:[UIFont fontWithName:KUIFont size:15]];
                [nameLabel setBackgroundColor:[UIColor clearColor]];
                [cell.contentView addSubview:nameLabel];
                
                
            }
        }
        
        
//    }else{
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//            
//          //  UIImage *head = [UIImage imageNamed:@"71_touxiang_2"];
//            UIImage *head = [UIImage imageNamed:[[downArray objectAtIndex:indexPath.row] objectForKey:@"image"]];
//            //cell.imageView.image = head;
//            UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, head.size.width/2, head.size.height/2)];
//            [headView setTag:2000+indexPath.row];
//            [headView setImage:head];
//            [cell.contentView addSubview:headView];
//        }
//    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([tableView isEqual:myTableView]) {
//        return indexPath.row == 0 ? 30 : 55.;
//    }else{
//        return 50;
//    }
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if ([tableView isEqual:myTableView]) {
//        return data.count + 1;
//    }else{
//        return downArray.count;
//        //return 10;
//    }
//}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:downTable]) {
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
        cell.contentView.transform = transform;
    }
}


@end
