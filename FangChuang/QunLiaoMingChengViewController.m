//
//  QunLiaoMingChengViewController.m
//  FangChuang
//
//  Created by super man on 14-3-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//群聊名称
#import "QunLiaoMingChengViewController.h"

#import "ChatWithFriendViewController.h"

@interface QunLiaoMingChengViewController ()

@end

@implementation QunLiaoMingChengViewController
@synthesize groupChatName;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"qunname"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    SUserDB * db = [[SUserDB alloc] init];
    [db createDataBase:@"SUser"];
    _userDB = [[SUserDB alloc] init];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:17]];
    //    [self setTitle:@"群聊名称"];
    self.titleLabel.text = @"群聊名称";
    [self addBackButton];
    [self addRightButtons];
    
    [self setTabBarHidden:YES];
    
    //    ic_obtain_code_text_bg 370 × 66
    //黄色的背景框
    //    UIImageView* btmImageV = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 370 / 2.) / 2., 20, 370 / 2., 66 / 2.)];
    //    [btmImageV setImage:[UIImage imageNamed:@"ic_obtain_code_text_bg"]];
    //    [self.contentView addSubview:btmImageV];
    
    //名字textField
    UIView  *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 40)];
    myview.backgroundColor = [UIColor whiteColor];
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, self.view.bounds.size.width-10, 40)];
    [nameTextField setBorderStyle:UITextBorderStyleNone];
    [nameTextField setFont:[UIFont fontWithName:KUIFont size:14]];
    
    nameTextField.backgroundColor=[UIColor whiteColor];
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //2014.04.25 chenlihua 解决群名称修改UITextField名称默认为0的情况
    nameTextField.text=groupChatName;
    [nameTextField setDelegate:self];
    
    [self.contentView addSubview:myview];
    [self.contentView addSubview:nameTextField];
}
#pragma -mark -functions
//修改按钮
- (void)myTask {
    
    sleep(3);
}
- (void)addRightButtons
{
    
    UIButton* infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoBtn setFrame:CGRectMake(320 - 44 , 0, 44, 44)];
    //    37 * 31
    //    [infoBtn setImage:[UIImage imageNamed:@"48_anniu_4"] forState:UIControlStateNormal];
    [infoBtn setTitle:@"确认" forState:UIControlStateNormal];
    [infoBtn.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [infoBtn setImageEdgeInsets:UIEdgeInsetsMake(22 - 31 / 4., 22 - 37 / 4., 22 - 31 / 4., 22 - 37 / 4.)];
    [infoBtn addTarget:self action:@selector(goToInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:infoBtn isAutoFrame:NO];
}
#pragma -mark -doClickAction
//点击修改按钮
//2014.05.06 chenlihua 修改群名称成功后，跳转到聊天界面。暂时隐藏原代码。重写。
/*
 - (void)goToInfo:(UIButton*)button
 {
 
 if (nameTextField.text.length == 0) {
 [self.view showActivityOnlyLabelWithOneMiao:@"请输入群名称"];
 return;
 }
 
 
 [[NetManager sharedManager] changeDiscussNameWithUsername:[[UserInfo sharedManager] username]
 did:self.digId
 newname:nameTextField.text
 hudDic:Nil success:^(id responseDic) {
 
 //2014.05.06 chenlihua 解决添加联系人或群组后，点击修改后，程序崩溃的情况发生。暂时取消此代码。
 //[[NSNotificationCenter defaultCenter] postNotificationName:@"QUNTITLECHANGE" object:nameTextField.text];
 
 [self.view showActivityOnlyLabelWithOneMiao:@"修改成功"];
 [self.navigationController popViewControllerAnimated:YES];
 
 } fail:^(id errorString) {
 [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
 }];
 }
 */

//点击修改按钮
//2014.05.06 chenlihua 修改群名称成功后，跳转到聊天界面。暂时隐藏原代码。重写。
- (void)goToInfo:(UIButton*)button
{
    
    if (nameTextField.text.length == 0) {
        [self.view showActivityOnlyLabelWithOneMiao:@"请输入群名称"];
        return;
    }

    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    [[NetManager sharedManager] changeDiscussNameWithUsername:[[UserInfo sharedManager] username]
                                                          did:self.digId
                                                      newname:nameTextField.text
                                                       hudDic:Nil success:^(id responseDic) {
                                                           
                                                           
                                                         
                                                           /*
                                                           SUser * user = [SUser new];
                                                           user.uid=self.digId;
                                                           user.titleName =self.digId;
                                                           //方创下显示群名称
                                                           user.conText = [NSString stringWithFormat:@"%@修改群名为[%@]",[[UserInfo sharedManager] username],nameTextField.text];
                                                                                                                user.contentType = @"3";
                                                           user.username =[[UserInfo sharedManager] username];
                                                           user.msgid =  @"";
                                                           user.description = @"";
                                                           user.readed=@"1";

                                                           [_userDB saveUser:user];
                                                         */
                                                        
                                                        /*                                                              [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                                                                    talkId:self.digId
                                                                               contentType:@"0"
                                                                                  talkType:@"3"
                                                                                 vedioPath:@""
                                                                                   picPath:@""
                                                       content:[NSString stringWithFormat:@"%@修改群名为[%@]",[[UserInfo sharedManager] username],nameTextField.text]
                                                                                      time:@""
                                                                                    isRead:@"0"
                                                                                    second:@""
                                                                                     MegId:[NSString stringWithFormat:@"%@修改群名为[%@]",[[UserInfo sharedManager] username],nameTextField.text]
                                                                                  imageUrl:@""
                                                                                    openBy:@""];
                                                        */
                                                          
                                                           //2014.05.06 chenlihua 解决添加联系人或群组后，点击修改后，程序崩溃的情况发生。暂时取消此代码。
                                                           //[[NSNotificationCenter defaultCenter] postNotificationName:@"QUNTITLECHANGE" object:nameTextField.text];
                                                           [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"creatteam"];
                                                           [[NSUserDefaults standardUserDefaults] synchronize];
                                                           //                                                           [self.view showActivityOnlyLabelWithOneMiao:@"修改成功"];
                                                           
                                                           [ShowBox showSuccess:@"修改成功!"];
                                                           
                                                           NSInteger currentIndex=1;
                                                           NSInteger index = currentIndex;
                                                           dataArray[index]=[[NSMutableArray alloc] init];
                                                           NSUserDefaults *unSendDefault3 = [NSUserDefaults standardUserDefaults];
                                                           if (![unSendDefault3 objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
                                                               ;
                                                           }else{
                                                               dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault3 objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
                                                           }
                                                           for (int i=0; i<dataArray[currentIndex].count; i++) {
                                                               if ([[dataArray[currentIndex] objectAtIndex:i]containsObject:self.digId]) {
                                                                   
                                                                   NSDictionary *dic =  [dataArray[currentIndex] objectAtIndex:i];
                                                                   
                                                                   NSMutableDictionary *ee = [[ NSMutableDictionary alloc]init];
                                                                   [ee setValue:[dic objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
                                                                   if ([[dic objectForKey:@"mcnt"] isEqualToString:@"2"]) {
                                                                       [ee setValue:@"1v1" forKey:@"type"];
                                                                   }else
                                                                   {
                                                                       [ee setValue:@"1vn" forKey:@"type"];
                                                                   }
                                                                   [ee setValue:[dic objectForKey:@"dgid"] forKey:@"dgid"];
                                                                   [ee setValue:nameTextField.text forKey:@"dname"];
                                                                   [ee setValue:[dic objectForKey:@"dpicurl"] forKey:@"dpicurl"];
                                                                   [ee setValue:[dic objectForKey:@"picurl1"]forKey:@"picurl1"];
                                                                   [ee setValue:[dic objectForKey:@"mcnt"] forKey:@"mcnt"];
                                                                   [dataArray[currentIndex]  removeObjectAtIndex:i];
                                                                   [dataArray[currentIndex] addObject:ee];
                                                     [dataArray [index] exchangeObjectAtIndex:0 withObjectAtIndex:dataArray[index].count-1];               NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                                                                   [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
                                                                   [userDefault synchronize];
                                                                   
                                                               }
                                                           }
                                                           
                                                           NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                                                           [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
                                                           [userDefault synchronize];
                                                           
                                                           
                                                           ChatWithFriendViewController* viewController = [[ChatWithFriendViewController alloc] init];
                                                           viewController.talkId = self.digId;
                                                           [viewController setTitleName:nameTextField.text];
                                                           viewController.memberCount= self.peoplecount;
                                                           
                                                           
                                                           
                                                           //2014.07.03 chenlihua 当从添加群组界面选群修改名称后，跳到群聊天界面，没有显示群组的名字。
                                                           viewController.changeName=nameTextField.text;
                                                               viewController.memberCount= self.peoplecount;
                                                           viewController.flagView=@"changeName";
                                                           NSLog(@"--nameTextField--%@--",nameTextField.text);
                                                           viewController.entrance = @"qun";
                                                           [self.navigationController pushViewController:viewController animated:NO];
                                                           
                                                           
                                                           
                                                       } fail:^(id errorString) {
                                                           [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
                                                           UIAlertView *show = [[UIAlertView alloc]initWithTitle:@"修改失败了！" message:@"╮(╯▽╰)╭ 稍后再试试吧~" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                                                           [show show];
                                                           
                                                       }];
}

#pragma  -mark -UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma -mark -重新写返回按钮
- (void) backButtonAction : (id) sender
{
    NSLog(@"---------返回按钮---parent-------------");
    
    [self.navigationController popViewControllerAnimated:NO];
    
    //    if (nameTextField.text.length == 0) {
    //        [self.view showActivityOnlyLabelWithOneMiao:@"请输入群名称"];
    //        return;
    //    }
    //
    //    [[NetManager sharedManager] changeDiscussNameWithUsername:[[UserInfo sharedManager] username]
    //                                                          did:self.digId
    //                                                      newname:nameTextField.text
    //                                                       hudDic:Nil success:^(id responseDic) {
    //
    //                                                         [self.navigationController popViewControllerAnimated:NO];
    //                                                           ;
    //                                                       } fail:^(id errorString) {
    //                                                           ;
    //                                                       }];
    
    
}

@end
