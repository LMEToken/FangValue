//
//  XiangMuWenDangViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//
//项目文档
#import "XiangMuWenDangViewController.h"
#define DEMO_VIEW_CONTROLLER_PUSH TRUE

@interface XiangMuWenDangViewController ()
@property(nonatomic,retain)NSDictionary *dic;
@end

@implementation XiangMuWenDangViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PDFDOCMENTDIDGOT object:nil];

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
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:20]];
    [self.titleLabel setText:@"项目文档"];
	[self addBackButton];
    [self setTabBarHidden:YES];
    [self loadData];
    
    //文档类别Label
    UILabel* typeLb  =[[UILabel alloc] initWithFrame:CGRectMake(20, (40 - 15) / 2., 70, 15)];
    [typeLb setBackgroundColor:[UIColor clearColor]];
    [typeLb setTextColor:GRAY];
    [typeLb setText:@"文档类别"];
    [typeLb setFont:[UIFont fontWithName:KUIFont size:15]];
    [self.contentView addSubview:typeLb];

    //文档类别选择
    UIImage *chooseKuang = [UIImage imageNamed:@"15_anniu_1.png"];
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn setFrame:CGRectMake(CGRectGetMaxX(typeLb.frame)-5, 10, chooseKuang.size.width/2-20, chooseKuang.size.height/2)];
    [chooseBtn setBackgroundImage:chooseKuang forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(chooseYear:) forControlEvents:UIControlEventTouchUpInside];
    chooseBtn.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:chooseBtn];
    
    //文档类别内容选择
    docuLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(typeLb.frame), 10, 80, chooseKuang.size.height/2)];
    [docuLabel setBackgroundColor:[UIColor clearColor]];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"docu"]) {
        [docuLabel setText:@"顾问协议"];
    }else{
        [docuLabel setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"docu"]];
    }
    [docuLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [docuLabel setTextColor:[UIColor grayColor]];
     docuLabel.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:docuLabel];

    //项目文档Label
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, self.contentViewHeight - 40) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.contentView addSubview:myTableView];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetPDFDocment:) name:PDFDOCMENTDIDGOT object:nil];
}
#pragma -mark -functions
- (void)loadData
{
    //    NSString *docuType = @"";
    //    switch (docuIndex) {
    //        case 0:
    //            docuType = @"顾问协议";
    //            break;
    //        case 1:
    //            docuType = @"商业计划书";
    //            break;
    //        case 2:
    //            docuType = @"业务文件";
    //            break;
    //        case 3:
    //            docuType = @"法务文件";
    //            break;
    //        case 4:
    //            docuType = @"财务文件";
    //            break;
    //        case 5:
    //            docuType = @"投资推荐信";
    //            break;
    //        case 6:
    //            docuType = @"保密协议";
    //            break;
    //        case 7:
    //            docuType = @"termsheet";
    //            break;
    //        case 8:
    //            docuType = @"dd尽调文件";
    //            break;
    //        case 9:
    //            docuType = @"spa";
    //            break;
    //        case 10:
    //            docuType = @"其他文件";
    //            break;
    //        default:
    //            break;
    //    }
    NSString * index = (NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"index"];
    if (index == nil) {
        index = @"1";
        [[NSUserDefaults standardUserDefaults] setObject:index forKey:@"index"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    [[NetManager sharedManager]getDocumentListWithProjectid:self.proid documenttype:index username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        NSLog(@"responseDic=%@",responseDic);
       
        /*
        responseDic={
            data =     {
                docmentlist =         (
                                       {
                                           createby = jenny;
                                           dname = "\U65b9\U521b";
                                           docid = 270;
                                           doctime = "2012-02-02 11:17:56";
                                           docurl = "http://fcapp.favalue.com/data/upload/1/201202/02/02111756054355g3.zip";
                                           size = 16512564;
                                       }
                                       );
            };
            msg = ok;
            status = 0;
        }
    */
        
        
        self.dic=[[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
        if ([[self.dic objectForKey:@"docmentlist"]count]==0) {
            [myTableView reloadData];
        }else{
            NSLog(@"cccccccc");
            [myTableView reloadData];
            NSLog(@"ddddddd");
        }
        
        
        
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
//获取文件tom920
- (void)pathForPDFWithUrl:(int)tag
{
    NSLog(@"---tag--%i",tag);
    
    NSLog(@"%@",self.dic);
    if ([[self.dic objectForKey:@"docmentlist"]count]==0) {
 
    }else{
        NSLog(@"--GetPDFWithUrl-%@---",[NSString stringWithFormat:@"%@",[[[self.dic objectForKey:@"docmentlist"] objectAtIndex:tag] objectForKey:@"docurl"]]);
  
        
        
         [[NetManager sharedManager] GetPDFWithUrl:[NSString stringWithFormat:@"%@",[[[self.dic objectForKey:@"docmentlist"] objectAtIndex:tag] objectForKey:@"docurl"]]];
        
        
        NSLog(@"----ttttt---%@------",[[[self.dic objectForKey:@"docmentlist"] objectAtIndex:tag] objectForKey:@"docurl"]);

    }
  
    
    
    /*http://fcapp.favalue.com/data/upload/1/201402/27/2718033203432a6d.pdf */
}

//获取到路径的通知
- (void)didGetPDFDocment:(NSNotification*)noti
{
    NSString* path = (NSString*)noti.object;
    
    NSLog(@"------path---%@",path);
    
    /*
    /Users/chenlihua/Library/Application Support/iPhone Simulator/7.1/Applications/90F66543-6242-4B3A-B537-E586458242A9/Documents/http:fcapp.favalue.comdataupload1201402272718033203432a6d.pdf*/
    
    //暂时先用本地的试试
  /*
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    
	NSArray *pdfs = [[NSBundle mainBundle] pathsForResourcesOfType:@"pdf" inDirectory:nil];
    
	NSString *filePath = [pdfs lastObject]; assert(filePath != nil); // Path to last PDF file
    
   */
   
    if ([path isEqualToString:@"error"]) {
       [self.view showActivityOnlyLabelWithOneMiao:@"获取文档失败"];
        return ;
    }
   

    NSLog(@"-------path后--%@---",path);
	ReaderDocument *document = [ReaderDocument withDocumentFilePath:path password:nil];
    
    NSLog(@"------document-----%@----",document);
    
	if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
	{
        [self.view showActivityOnlyLabelWithOneMiao:@"读取文件成功"];
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
		readerViewController.delegate = (id<ReaderViewControllerDelegate>)self; // Set the ReaderViewController delegate to self
        
        
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        
		[self.navigationController pushViewController:readerViewController animated:YES];
        
#else // present in a modal view controller
        
		readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
       
        [self.navigationController pushViewController:readerViewController animated:YES];
		//[self presentModalViewController:readerViewController animated:YES];
        
#endif // DEMO_VIEW_CONTROLLER_PUSH
        
	}
    else
    {
       
       [self performSelector:@selector(showhud)withObject:nil afterDelay:2];
       return;
       
    }
}
-(void)showhud
{
   [self.view showActivityOnlyLabelWithOneMiao:@"PDF损坏"];
}
#pragma  -mark -ReaderViewControllerDelegate methods
- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
    
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
	[self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    
	[self dismissModalViewControllerAnimated:YES];
    
#endif // DEMO_VIEW_CONTROLLER_PUSH
}
#pragma  -mark -doClickAction

//选择文档时播放
- (void)documentClick:(int)tag
{
    NSLog(@"--documentClick---");
       //这里需要凭借网络PDF地址
   [self pathForPDFWithUrl:tag];
}

//选择文档内容
- (void)chooseYear:(UIButton*)sender
{
    docuArray = [[NSArray alloc]initWithObjects:@"顾问协议",@"商业计划书",@"业务文件",@"法务文件",@"财务文件",@"投资推荐信",@"保密协议",@"termsheet",@"dd尽调文件",@"spa",@"其他文件",nil];
    
    myPickerView = [[APickerView alloc]initWithData:docuArray];
    myPickerView.delegate = self;
    [self.contentView addSubview:myPickerView];
    
    NSLog(@"--setSelect-%i-----",[[[NSUserDefaults standardUserDefaults]objectForKey:@"index"]intValue]);
     [myPickerView setSelectRow:[[[NSUserDefaults standardUserDefaults]objectForKey:@"index"]intValue] inComponent:0 animated:YES];
}

#pragma  -mark -UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---cell---");
    static NSString* identifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSLog(@"--cell--nil");
        //cell的背景色
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        //cell的背景框
        UIImage* bcImg = [UIImage imageNamed:@"40_shurukuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), 75)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];
        
        //文档Label
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake( 20, 10, 40 , 15)];
        [nameLabel setText:@"文档:"];
        [nameLabel setTextColor:ORANGE];
        [nameLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:nameLabel];
        
        //文档内容Label
        UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) , CGRectGetMinY(nameLabel.frame), 320 -CGRectGetMaxX(nameLabel.frame) - 20, 15)];
        [contentLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [contentLabel setTextColor:[UIColor blueColor]];
        [contentLabel setText:[[[self.dic objectForKey:@"docmentlist"] objectAtIndex:indexPath.row] objectForKey:@"dname"]];
        [cell.contentView addSubview:contentLabel];
        
        //        //2014.08.30 chenlihua 把读PDF。由点击单元格，变成button
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(0, 0, 100, 40);
            [button addTarget:self action:@selector(documentClick:) forControlEvents:UIControlEventTouchUpInside];
             button.backgroundColor=[UIColor redColor];
           //  [cell.contentView addSubview:button];
             [button setTag:1000 + indexPath.row];
        
        
        //添加人Label
        UILabel* diLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(nameLabel.frame) + 4, 60 , 15)];
        [diLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [diLabel setBackgroundColor:[UIColor clearColor]];
        [diLabel setTextColor:GRAY];
        [diLabel setText:@"添加人:"];
        [cell.contentView addSubview:diLabel];
        
        //添加人内容Label
        UILabel* renLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(diLabel.frame) , CGRectGetMinY(diLabel.frame), 320 -CGRectGetMaxX(nameLabel.frame) - 20, 15)];
        [renLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [renLabel setBackgroundColor:[UIColor clearColor]];
        [renLabel setTextColor:[UIColor lightGrayColor]];
        [renLabel setText:[[[self.dic objectForKey:@"docmentlist"] objectAtIndex:indexPath.row] objectForKey:@"createby"]];
        [cell.contentView addSubview:renLabel];
        
        //添加时间Label
        UILabel* dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(diLabel.frame) + 4, 70 , 15)];
        [dataLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [dataLabel setBackgroundColor:[UIColor clearColor]];
        [dataLabel setTextColor:GRAY];
        [dataLabel setText:@"添加时间:"];
        [cell.contentView addSubview:dataLabel];
        
        //添加时间内容Label
        UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dataLabel.frame) , CGRectGetMinY(dataLabel.frame), 320 -CGRectGetMaxX(dataLabel.frame) - 20, 15)];
        [dateLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:[UIColor lightGrayColor]];
        [dateLabel setText:[[[self.dic objectForKey:@"docmentlist"] objectAtIndex:indexPath.row] objectForKey:@"doctime"]];
        [cell.contentView addSubview:dateLabel];
        NSLog(@"--cell finished---");

    }
    
    NSLog(@"---cell return ---");
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"---didSelect---");
    NSLog(@"---indexPath.row---%i",indexPath.row);
    //2014.08.30 chenlihua 暂时注掉，改成加button.
    [self documentClick:indexPath.row];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"---height---");
    return 75;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSLog(@"---numbeOfRows---");
    return [[self.dic objectForKey:@"docmentlist"]count];
}
#pragma -mark -APickerViewDelegate
- (void) pickerViewSelectObject : (id) object index : (NSInteger) index
{
    [[NSUserDefaults standardUserDefaults]setObject:[docuArray objectAtIndex:index] forKey:@"docu"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",index+1] forKey:@"index"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   
    //    [UIView animateWithDuration:.5f delay:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        [myPickerView setFrame:CGRectMake(0, self.contentViewHeight+216, 320, 216)];
    //    } completion:nil];
    docuLabel.text = [docuArray objectAtIndex:index];
    [self loadData];
    [myTableView reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"低内存警告" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
    
}

@end
