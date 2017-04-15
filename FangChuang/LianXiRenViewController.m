//
//  LianXiRenViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-2.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//联系人,暂时未用到
#import "LianXiRenViewController.h"
#import "JianJieViewController.h"

@interface LianXiRenViewController ()
@property(nonatomic,retain) AsyncSocket *socketUpdate;
@end

@implementation LianXiRenViewController
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
        //        socketUpdate=[socketNet sharedSocketNet];
        //        socketUpdate.delegate=self;
    }
    return self;
}

- (void)loadData
{
    //    [[NetManager sharedManager] ge];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:20]];
    [self.titleLabel setText:@"联系人"];
    [self setTabBarIndex:2];
    [self addBackButton];
    
    currentPage = 1;
    haoYoutableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) pullingDelegate:self];
    [haoYoutableView setBackgroundColor:[UIColor clearColor]];
    [haoYoutableView setShowsVerticalScrollIndicator:NO];
    haoYoutableView.dataSource=self;
    haoYoutableView.delegate=self;
    [self.contentView addSubview:haoYoutableView];
    
    
}
#pragma  - mark -PullingRefreshTabelView Delegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [haoYoutableView tableViewDidEndDragging:scrollView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [haoYoutableView tableViewDidScroll:scrollView];
}

-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    currentPage++;
    //[self loadData];
    [tableView tableViewDidFinishedLoading];
}
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    currentPage=1;
    //[self loadData];
    [tableView tableViewDidFinishedLoading];
}
#pragma  -mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    //    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellString=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellString];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellString];
        
        //cell的背景图
        UIImage* bcImg = [UIImage imageNamed:@"60_kuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];
        
        //向右的箭头
        UIImageView *jiantouImage=[[UIImageView alloc]initWithFrame:CGRectMake(320-10-23/2, (70-20.5)/2, 23/2, 41/2)];
        [jiantouImage setImage:[UIImage imageNamed:@"45_jiantou_1"]];
        [cell.contentView addSubview:jiantouImage];
        
        //头像
        UIImage *image=[UIImage imageNamed:@"61_touxiang_1"];
        UIImageView *headerImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        [headerImage setImage:image];
        [cell.contentView addSubview:headerImage];
        
        //头像button
        UIButton *headBut=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        [headBut setBackgroundColor:[UIColor clearColor]];
        [headBut addTarget:self action:@selector(JianJieEvent:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:headBut];
        
        //姓名:Label
        UILabel *xingminglab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 25, 40, 20)];
        [xingminglab setBackgroundColor:[UIColor clearColor]];
        [xingminglab setText:@"姓名:"];
        [xingminglab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:xingminglab];
        
        //姓名内容Label
        UILabel *xingmlab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(xingminglab.frame)+5, 25, 120, 20)];
        [xingmlab setBackgroundColor:[UIColor clearColor]];
        [xingmlab setText:@"张三"];
        [xingmlab setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:xingmlab];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"企业团队A";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"row=%d ,section=%d",indexPath.row,indexPath.section);
}
#pragma -mark -doClickButton
- (void)JianJieEvent:(UIButton *)sender{
    JianJieViewController *view=[[JianJieViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}


//#pragma -mark -AsyncSocketDelegate
//-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//
//
//    [socketUpdate readDataWithTimeout:-1 tag:200];
//
//}
//
//-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
//{
//    NSLog(@"连接服务器成功");
//    [socketUpdate readDataWithTimeout:-1 tag:200];
//
//}
//-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
//{
//
//}
//- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket {
//    return [NSRunLoop currentRunLoop];
//}
//-(void)onSocketDidDisconnect:(AsyncSocket *)sock
//{
////     socketUpdate = nil;
//    [socketUpdate disconnect];
//
//}
//- (BOOL)onSocketWillConnect:(AsyncSocket *)sock {
//
//
//    return YES;
//}
//-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
//{
//    
//}




@end
