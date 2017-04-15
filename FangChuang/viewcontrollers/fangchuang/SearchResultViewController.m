//
//  SearchResultViewController.m
//  FangChuang
//
//  Created by super man on 14-3-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//搜索结果
#import "SearchResultViewController.h"
#import "CacheImageView.h"
#import "SQLite.h"
#import "ChatWithFriendViewController.h"

@interface SearchResultViewController ()
@end
@implementation SearchResultViewController
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self setTitle:@"搜索结果"];
    
    //UITableView
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) style:UITableViewStylePlain];
    [myTableView setDataSource:self];
    [myTableView setDelegate:self];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:myTableView];

  //  self.datas =  [SQLite getLikeChatWithKey:self.key];
    
   //2014.04.26 chenlihua 将搜索功能做成和微信的一样按照昵称和聊天内容进行查询
    self.datas= [SQLite getLikeNicNameWithKey:self.key];
    NSLog(@"---搜索结果界面-------------");
    NSLog(@"array = %@",self.datas);
    if (self.datas.count==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"没有搜索到您想要的聊天内容，请重新进行搜索" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [alert show];
    }
    else{
        [myTableView reloadData];
    }
    //2014.08.22 chenlihua 当没有搜索结果的时候，弹出提示框。
    /*
    if (self.datas.count) {
        [myTableView reloadData];
    }
     */
}
#pragma -mark -UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    if (self.datas.count > indexPath.row) {
        NSDictionary* dic = [self.datas objectAtIndex:indexPath.row];
        //cell背景图
        UIImage* bcImg = [UIImage imageNamed:@"60_kuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];

        //头像
        UIImage *image=[UIImage imageNamed:@"61_touxiang_1"];
        CacheImageView *headView = [[CacheImageView alloc]initWithImage:image Frame:CGRectMake(10, 10, 50, 50)];
        [headView getImageFromURL:[NSURL URLWithString:[dic objectForKey:@"picPath"]]];
        [headView setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:headView];
        
        //姓名Label
        UILabel *xingminglab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headView.frame)+10, 10, 200, 15)];
        [xingminglab setBackgroundColor:[UIColor clearColor]];
        [xingminglab setText:[dic objectForKey:@"openby"]];
        //[xingminglab setFont: [UIFont systemFontOfSize:14]];
        [xingminglab setFont:[UIFont fontWithName:KUIFont size:14]];
        [xingminglab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:xingminglab];
        
        //内容Label
        UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headView.frame)+10, CGRectGetMaxY(xingminglab.frame) + 10, 200, 20)];
        [contentLabel setNumberOfLines:0];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [contentLabel setText:[dic objectForKey:@"content"]];
        [contentLabel setFont:[UIFont fontWithName:KUIFont size:14]];
        [contentLabel setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:contentLabel];
    }
      /**/
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dataDic = [self.datas objectAtIndex:indexPath.row];
    NSLog(@"---dataDic--%@",dataDic);
    
    ChatWithFriendViewController *cfVC=[[ChatWithFriendViewController alloc]init];
    cfVC.talkId=[dataDic objectForKey:@"talkId"];
    cfVC.titleName=[dataDic objectForKey:@"openby"];
    cfVC.flagContact=@"3";
    
    [self.navigationController pushViewController:cfVC animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end
