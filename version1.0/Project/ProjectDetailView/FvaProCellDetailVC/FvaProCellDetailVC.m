//
//  ProjectMainTableCellDetailViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaProCellDetailVC.h"
#define MAXFLOAT    0x1.fffffep+127f
#define DEMO_VIEW_CONTROLLER_PUSH TRUE
@interface FvaProCellDetailVC ()
{
    NSDictionary *datadic;
    NSTimer *showtimer;
}
@end

@implementation FvaProCellDetailVC
@synthesize navigationView,titlename;
@synthesize projectId,welview;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: NO];

}
-(void)relodata
{
  [[NetManager sharedManager]getBusinessPlanWithProjectid:projectId username:[[UserInfo sharedManager] username] hudDic:nil success:^(id responseDic) {
      NSLog(@"%@",responseDic);
      datadic = [responseDic objectForKey:@"data"];
      NSLog(@"%@",datadic);
      [self setTitle:[datadic objectForKey:@"fullname"]];
      [self addTableview];

      [self.DetailTableview reloadData];

  }
  fail:^(id errostrin) {
      
  }];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
     [[NSNotificationCenter defaultCenter] removeObserver:PDFDOCMENTDIDGOT];
    [showtimer invalidate];
}
- (void)viewDidLoad
{
 
    [super viewDidLoad];
    datadic=[[NSDictionary alloc]init];
    showtimer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(changepage) userInfo:nil repeats:YES];
    [self addPageControl];
  
    imageindex=0;
    self.DetailTableview.delegate = self;
    self.DetailTableview.dataSource =self;
    [self setTabBarHidden:YES];
    [self addBackButton];
 
    [self relodata];
    [self loadData];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetPDFDocment:) name:PDFDOCMENTDIDGOT object:nil];

}

- (void) backButtonAction : (id) sender
{

        ProjectMainTableViewController *insideView=[[ProjectMainTableViewController alloc]init];
        [self.navigationController pushViewController:insideView animated:NO];

    
    
}
- (void)addTableview
{
    [self addPageControl];
    [self addScrollView];
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
    [myview addSubview:imageScrollView];
    [myview addSubview:pageControl];
// [ imageScrollView addSubview:pageControl];
//    [self addSubview:imageScrollView];
//    [self addSubview:pageControl];
    self.DetailTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) style:UITableViewStylePlain];
    [self.DetailTableview setTableHeaderView:myview];
    
                          //UITableViewStylePlain];
    [self.DetailTableview setDelegate:self];
    [ self.DetailTableview setDataSource:self];

    [self.DetailTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.contentView addSubview:self.DetailTableview];
 
}
//添加返回按钮
- (void) addBackButton
{
    UIView *view = [self.view viewWithTag:backButtonTag];
    if (view) {
        [view removeFromSuperview];
        view = nil;
    }

    UIImage *backImage = [UIImage imageNamed:@"project_main_back-new"];

    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    backButton.backgroundColor=[UIColor clearColor];
    [backButton setTag:backButtonTag];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake((navigationHeight  - backImage.size.height/2)/2, (navigationHeight  - backImage.size.width/2)/2, (navigationHeight  - backImage.size.height/2)/2, (navigationHeight  - backImage.size.width/2)/2)];

    //    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    
    //加大返回按钮
    //2014.08.14 chenlihua
    UIButton *NewBackButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    NewBackButton.frame=CGRectMake(0, 20, 100, 44);
    NewBackButton.backgroundColor=[UIColor clearColor];
    [NewBackButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NewBackButton];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 文档读取
//获取文档
- (void)loadData
{
    
    NSString * index = (NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"index"];
    if (index == nil) {
        index = @"1";
        [[NSUserDefaults standardUserDefaults] setObject:index forKey:@"index"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [[NetManager sharedManager]getDocumentListWithProjectid:@"10068" documenttype:index username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        NSLog(@"responseDic=%@",responseDic);
        self.ptfdic=[[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
        
         [_DetailTableview reloadData];
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
//获取文档路径
- (void)pathForPDFWithUrl:(int)tag
{
    if ([[self.ptfdic objectForKey:@"docmentlist"]count]==0) {
        
    }else{
        NSLog(@"%@",[NSString stringWithFormat:@"%@",[[[datadic objectForKey:@"docmentlist"] objectAtIndex:tag] objectForKey:@"docurl"]]);
        [[NetManager sharedManager] GetPDFWithUrl:[NSString stringWithFormat:@"%@",[[[datadic objectForKey:@"docmentlist"] objectAtIndex:tag] objectForKey:@"docurl"]]];
    }
    

}
//接收到路径读取文档显示文档
- (void)didGetPDFDocment:(NSNotification*)noti
{
    NSString* path = (NSString*)noti.object;
    if ([path isEqualToString:@"error"]) {
        [self.view showActivityOnlyLabelWithOneMiao:@"获取文档失败"];
        return ;
    }
	ReaderDocument *document = [ReaderDocument withDocumentFilePath:path password:nil];
    
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
- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#ifdef DEBUGX

#endif
    
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
	[self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    
	[self dismissModalViewControllerAnimated:YES];
    
#endif // DEMO_VIEW_CONTROLLER_PUSH
}


#pragma mark - TableVIewDelegete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11 ;
}


-(CGSize)sizeForContentWithString:(NSString*)content
{
    CGSize size;
    // 首先算宽度
    size = [content sizeWithFont:[UIFont fontWithName:KUIFont size:12] constrainedToSize:CGSizeMake(MAXFLOAT, 20) lineBreakMode:NSLineBreakByWordWrapping];
    //宽度大于150 ， 计算适配高度
    if (size.width > 200) {
        size = [content sizeWithFont:[UIFont fontWithName:KUIFont size:12] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        return size;
    }
    return size;
}

#pragma -mark -functions
-(void)addScrollView {
    imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
    [imageScrollView setBackgroundColor:[UIColor clearColor]];;
    [imageScrollView setContentSize:CGSizeMake(320*[[datadic objectForKey:@"projectpic"] count], 120)];
    [imageScrollView setBounces:NO];
    [imageScrollView setDelegate:self];;
    imageScrollView.pagingEnabled = YES;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator=NO;

    NSLog(@"%d",[[datadic objectForKey:@"projectpic"] count]);
    
    int a = 0;
    int i = 0;
    for ( i = 0; i <[[datadic objectForKey:@"projectpic"] count]; i++) {
        //        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 100)];
        //        imageView.image = [UIImage imageNamed:[self.imagelist objectAtIndex:i]];
        //        imageView.tag = 110 + i;
        //        imageView.userInteractionEnabled=YES;
        //        [imageScrollView addSubview:imageView];
        //        a +=200;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 120)];
//    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"加%d.png",(i+1)]];
//        imageView.image = [UIImage imageNamed:[[datadic objectForKey:@"projectpic"] objectAtIndex:i]];
//        NSLog(@"%@",[[datadic objectForKey:@"projectpic"] objectAtIndex:i]);
      [imageView  setImageWithURL:[NSURL URLWithString:[[datadic objectForKey:@"projectpic"] objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
        
        imageView.tag = 110 + i;
        imageView.userInteractionEnabled=YES;
        [imageScrollView addSubview:imageView];
        a +=200;
    }
    
}

#pragma -mark -UIPageViewControllerDelegate
-(void) addPageControl {
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(145, 130-40, 320/2-140, 40)];
    //页数（几个圆圈）
    pageControl.numberOfPages = [[datadic objectForKey:@"projectpic"] count];
    pageControl.tag = 101;
    pageControl.currentPage = 0;
 
   
   
}
-(void)changepage
{
  
      pageControl.currentPage=pageControl.currentPage+1;
    if (pageControl.currentPage==[[datadic objectForKey:@"projectpic"] count]-1) {
        changeyes = changeyes+1;
        
    }
    if (changeyes==2) {
        pageControl.currentPage=0;
 
        changeyes=0;
    }
    
    [imageScrollView scrollRectToVisible:CGRectMake(pageControl.currentPage * 320.0, 65.0, 320.0, 218.0) animated:YES];
    
 

  
}
-(void) tap: (UITapGestureRecognizer*)sender{
    NSLog(@"tap %ld image",(long)pageControl.currentPage);
}
#pragma -mark -UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int current = scrollView.contentOffset.x/320;
    NSLog(@"current:%d",current);
    pageControl.currentPage = current;
    if (pageControl.currentPage==[[datadic objectForKey:@"projectpic"] count]-1) {
        changeyes = changeyes+1;
     
    }
    if (changeyes==2) {
        pageControl.currentPage=0;
        [imageScrollView scrollRectToVisible:CGRectMake(pageControl.currentPage * 320.0, 65.0, 320.0, 218.0) animated:YES];
        changeyes=0;
    }
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *cellarr = [NSArray arrayWithObjects:@"项目介绍 :",@"投资亮点:",@"公司阶段 :",@"团队介绍 :",@"融资需求 :",@"相关链接 :",@"团队 :",@"资料 :",@"融资进度 :",@"相关群 :", nil];
        FvaProDetailCell *cell = [[FvaProDetailCell alloc]init];
    UIImageView *cellline = [[UIImageView alloc]initWithFrame:CGRectMake(90, 2, 210, 0.5)];
    cellline.image = [UIImage imageNamed:@"cellfenge"];
    [cell addSubview:cellline];
  
    //点击背景的时候，背景色颜色不变。
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row ==0) {
             FvaProDetailHeradCell *heradcell = [[FvaProDetailHeradCell alloc]init];
            return heradcell;
    }
    if (indexPath.row==1) {
//        cell.detailetext.text = [datadic objectForKey:@"position"];
        UITextView *fpurposte = [[UITextView alloc]initWithFrame:CGRectMake(85, 3, self.view.bounds.size.width-85, 77)];
        fpurposte.text =  [datadic objectForKey:@"position"];
        fpurposte.editable =NO;
       
        cell.userInteractionEnabled=YES;
        [fpurposte setFont:[UIFont fontWithName:KUIFont size:12]];
        [cell addSubview:fpurposte];
    }
    if (indexPath.row==2) {
//        cell.detailetext.text =  [datadic objectForKey:@"factor"];
        UITextView *fpurposte = [[UITextView alloc]initWithFrame:CGRectMake(85, 3, self.view.bounds.size.width-85, 77)];
        fpurposte.text =  [datadic objectForKey:@"factor"];
        fpurposte.editable =NO;
        cell.userInteractionEnabled=YES;
        [fpurposte setFont:[UIFont fontWithName:KUIFont size:12]];
        [cell addSubview:fpurposte];
    }
    if (indexPath.row==3) {
//        cell.detailetext.text =  [datadic objectForKey:@"statge"];
        UITextView *fpurposte = [[UITextView alloc]initWithFrame:CGRectMake(85, 3, self.view.bounds.size.width-85, 77)];
        fpurposte.text=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"statge"]];
        fpurposte.backgroundColor=[UIColor clearColor];
        fpurposte.editable =NO;
        cell.userInteractionEnabled=YES;
        [fpurposte setFont:[UIFont fontWithName:KUIFont size:12]];
        [cell addSubview:fpurposte];
    }
    if (indexPath.row ==4) {
        
        UITextView *fpurposte = [[UITextView alloc]initWithFrame:CGRectMake(85, 3, self.view.bounds.size.width-85, 97)];
        fpurposte.text =  [datadic objectForKey:@"proteam"];
        fpurposte.editable =NO;
        fpurposte.backgroundColor=[UIColor clearColor];
 
        [fpurposte setFont:[UIFont fontWithName:KUIFont size:12]];
        [cell addSubview:fpurposte];
        cell.userInteractionEnabled = YES;
        UIButton *buttn = [[UIButton alloc]initWithFrame:CGRectMake(230, 100, 100, 30)];
        [buttn setTitle:@"查看详情"  forState:UIControlStateNormal];
        [buttn addTarget:self action:@selector(pushCompanInVC) forControlEvents: UIControlEventTouchDown];
        [buttn.titleLabel  setFont:[UIFont fontWithName:KUIFont size:12]];
        [buttn setTitleColor:[UIColor blueColor]  forState:UIControlStateNormal];
        [cell addSubview:buttn];

    }
    if (indexPath.row==5) {
        UITextView *fpurposte = [[UITextView alloc]initWithFrame:CGRectMake(85, 3, self.view.bounds.size.width-85, 77)];
          fpurposte.text =  [datadic objectForKey:@"fpurpose"];
        fpurposte.editable =NO;
         cell.userInteractionEnabled = YES;
        [fpurposte setFont:[UIFont fontWithName:KUIFont size:12]];
        [cell addSubview:fpurposte];
 
    }
    if (indexPath.row ==6) {
        
        cell.detailetext.hidden = YES;
        cell.userInteractionEnabled = YES;
        NSArray *arr =[NSArray arrayWithObjects:@"相关网址",@"公众号", nil];
        UILabel *lable[1];
        for (int i=0; i<1; i++) {
            lable[i] = [[UILabel alloc]initWithFrame:CGRectMake(95, 10+i*20, 70, 30)];
            [lable[i] setFont:[UIFont fontWithName:KUIFont size:12]];
            [lable[i] setText:[arr objectAtIndex:i]];
            [cell addSubview:lable[i]];
        }
        UIButton *buttn = [[UIButton alloc]initWithFrame:CGRectMake(130, 10, 170, 30)];
        [buttn setTitle: [datadic objectForKey:@"url"]  forState:UIControlStateNormal];
        [buttn addTarget:self action:@selector(gotosafai:) forControlEvents: UIControlEventTouchDown];
        [buttn.titleLabel  setFont:[UIFont fontWithName:KUIFont size:12]];
        [buttn setTitleColor:[UIColor blueColor]  forState:UIControlStateNormal];
        [cell addSubview:buttn];
        
//        UIButton *buttn2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 30, 170, 30)];
//        [buttn2 setTitle:@"7758258"  forState:UIControlStateNormal];
//        [buttn2 addTarget:self action:@selector(gotosafai:) forControlEvents: UIControlEventTouchDown];
//        [buttn2.titleLabel  setFont:[UIFont fontWithName:KUIFont size:12]];
//        [buttn2 setTitleColor:[UIColor blueColor]  forState:UIControlStateNormal];
//        [cell addSubview:buttn2 ];
        
        
    }
    if (indexPath.row == 7) {
        cell.heradlable.hidden = YES;
        cell.userInteractionEnabled=YES;
//            cell.detailetext.hidden = YES;
//        cell.userInteractionEnabled = YES;
//        NSLog(@"%@", [datadic objectForKey:@"team"]);
//        UIImageView   *presonimage[[[datadic objectForKey:@"team"] count]];
//        UIButton *preson[[[datadic objectForKey:@"team"] count]] ;
//        UILabel  *presonname[[[datadic objectForKey:@"team"] count]];
//        for (int i =0; i<[[datadic objectForKey:@"team"] count]; i++) {
//            preson[i] = [[UIButton alloc]init];
//            presonname[i] = [[UILabel alloc]init];
//            presonimage[i] = [[UIImageView alloc]init];
//            preson[i].frame= CGRectMake(250-50*i, 10, 40, 40);
//            presonname[i].frame = CGRectMake(250-50*i,42, 40, 30);
//            presonimage[i].frame= CGRectMake(250-50*i, 10, 40, 40);
//            [presonname[i] setFont:[UIFont fontWithName:KUIFont size:8]];
//            
//            NSLog(@"%@",[datadic objectForKey:@"team"] );
//            presonname[i].text = [[[datadic objectForKey:@"team"] objectAtIndex:i]objectForKey:@"tname" ];
//            [preson[i] addTarget:self action:@selector(heradclick:) forControlEvents:UIControlEventTouchDown];
//            preson[i].tag=i;
//            [ presonimage[i]  setImageWithURL:[NSURL URLWithString:[[[datadic objectForKey:@"team"] objectAtIndex:i]objectForKey:@"photourl" ]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] ];
//            [cell addSubview:presonname[i]];
//            [cell addSubview:preson[i]];
//            [cell addSubview:presonimage[i]];
//            
//            UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(200, 10, 10, 20)];
//            [myview setImage:[UIImage imageNamed:@"accessory"]];
//            cell.accessoryView = myview;
//            
//        }


    }
    if (indexPath.row ==8) {
        NSLog(@"%@",[datadic objectForKey:@"docmentlist"]);
        cell.detailetext.hidden = YES;
        cell.userInteractionEnabled = YES;
        NSLog(@"%@",[datadic objectForKey:@"docmentlist"]);
        UIButton *preson[[[datadic objectForKey:@"docmentlist"] count]] ;
        UILabel  *presonname[[[datadic objectForKey:@"docmentlist"] count]];
        UIImageView *presonimage[[[datadic objectForKey:@"docmentlist"] count]];
        for (int i =0; i<[[datadic objectForKey:@"docmentlist"] count]; i++) {
            presonimage[i] = [[UIImageView alloc]init];
            preson[i] = [[UIButton alloc]init];
            presonname[i] = [[UILabel alloc]init];
            
            preson[i].frame= CGRectMake(90+40*i+20*i, 10, 45, 45);
            presonimage[i].frame= CGRectMake(90+40*i+20*i, 10, 45, 45);
            presonname[i].frame = CGRectMake(86+40*i+20*i, 50, 50,30);
            preson[i].backgroundColor = [UIColor clearColor];
            presonname[i].text = [[[datadic objectForKey:@"docmentlist"] objectAtIndex:i] objectForKey:@"dname"];
            [presonname[i] setFont:[UIFont fontWithName:KUIFont size:8]];
//            NSLog(@"%@",[[[datadic objectForKey:@"docmentlist"]objectAtIndex:i] objectForKey:@"node"]);
            [presonimage[i] setImage:[UIImage imageNamed:@"pdf"]];
            //[ UIImage imageNamed:[[[datadic objectForKey:@"docmentlist"]objectAtIndex:i] objectForKey:@"node"]]
           
//            [presonimage[i] setImageWithURL:[NSURL URLWithString:[[[datadic objectForKey:@"docmentlist"] objectAtIndex:i]objectForKey:@"docurl" ]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] ];

            preson[i].tag =i;
            [preson[i] addTarget:self action:@selector(getptf:) forControlEvents:UIControlEventTouchDown];
            [cell addSubview:presonimage[i]];
            [cell addSubview:presonname[i]];
            [cell addSubview:preson[i]];
            
  
        }

        
    }
    if (indexPath.row ==9) {
        if ([[[UserInfo sharedManager] usertype] isEqualToString:@"1"]) {
            return  cell;
        }
        cell.detailetext.hidden = YES;
        cell.userInteractionEnabled = YES;
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(135, 10, 160, 30)];
        [lable setFont:[UIFont fontWithName:KUIFont size:13]];
        [lable setTextColor:[UIColor blueColor]];
        UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(95, 40, 160, 30)];
        slider.userInteractionEnabled = NO;
        slider.maximumValue = 100;
        slider.value = [[datadic objectForKey:@"centprogress"] intValue];

        /*
        if (slider.value==100) {
            lable.text = [NSString stringWithFormat:@"已完成   %%%@",[datadic objectForKey:@"centprogress"]];
        }else
        {
            lable.text = [NSString stringWithFormat:@"推荐中   %%%@",[datadic objectForKey:@"centprogress"]];
        }
         */
        if (slider.value==100) {
            lable.text = [NSString stringWithFormat:@"已完成   %@%%",[datadic objectForKey:@"centprogress"]];
        }else
        {
            lable.text = [NSString stringWithFormat:@"推荐中   %@%%",[datadic objectForKey:@"centprogress"]];
        }

        [cell addSubview:slider];
        [cell addSubview:lable];
        UIButton *buttn = [[UIButton alloc]initWithFrame:CGRectMake(235, 35, 100, 30)];
        [buttn setTitle:@"查看详情"  forState:UIControlStateNormal];
        [buttn addTarget:self action:@selector(pushProjectFinanceVC) forControlEvents: UIControlEventTouchDown];
        [buttn.titleLabel  setFont:[UIFont fontWithName:KUIFont size:14]];
        [buttn setTitleColor:[UIColor blueColor]  forState:UIControlStateNormal];
        [cell addSubview:buttn];
     
        
        
    }
    if (indexPath.row == 10) {
        cell.detailetext.hidden = YES;
        cell.userInteractionEnabled = YES;
        NSLog(@"%@",[datadic objectForKey:@"dg"] );
        UIButton *preson[ [[datadic objectForKey:@"dg"] count]] ;
        UILabel  *presonname[ [[datadic objectForKey:@"dg"] count]];
        UIImageView  *presoimage[ [[datadic objectForKey:@"dg"] count]];
//        NSArray *arr=[NSArray arrayWithObjects:@"  大项目组",@"融资对接群  ",@" 内部讨论群", nil];
        for (int i =0; i< [[datadic objectForKey:@"dg"] count]; i++) {
            preson[i] = [[UIButton alloc]init];
            presonname[i] = [[UILabel alloc]init];
            presoimage[i] = [[UIImageView alloc]init];
            preson[i].frame= CGRectMake(90+40*i+20*i, 10, 45, 45);
            presoimage[i].frame= CGRectMake(90+40*i+20*i, 10, 45, 45);
            presonname[i].frame = CGRectMake(86+40*i+20*i, 50, 53,30);
            preson[i].backgroundColor  =[UIColor clearColor];
            presonname[i].text = [[[datadic objectForKey:@"dg"] objectAtIndex:i] objectForKey:@"dgname"];
            [presonname[i] setFont:[UIFont fontWithName:KUIFont size:8]];
           [ presoimage[i]  setImageWithURL:[NSURL URLWithString:[[[datadic objectForKey:@"dg"] objectAtIndex:i]objectForKey:@"dpicurl" ]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] ];
            preson[i] .tag = i;
            [preson[i] addTarget:self action:@selector(Crowdbt:) forControlEvents:UIControlEventTouchDown];
            [cell addSubview:presoimage[i]];
            [cell addSubview:presonname[i]];
            [cell addSubview:preson[i]];
            
        }
        
    }
 
     cell.heradlable .text =[cellarr objectAtIndex:indexPath.row-1];
    ////     cell.detailetext.frame=CGRectMake(90, 5, 230, 60);
//      cell.detailetext.frame=CGRectMake(90, 5, 230, cell.detailetext.text.length+30);

           return cell;
}


-(void)pushProjectFinanceVC
{
    ProjectFinanceTabelViewController *Finance = [[ProjectFinanceTabelViewController alloc]init];
    Finance.projectID=projectId;
    [self.navigationController pushViewController:Finance animated:NO];
}
-(void)getptf:(UIButton *)button
{

    [self pathForPDFWithUrl:button.tag];
     button.userInteractionEnabled = YES;
}


- (void)gotosafai:(UIButton *)acppbt
{
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:acppbt.titleLabel.text]];
}

-(void)Crowdbt:(UIButton *)crowdbt
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    NSDictionary *arrdic=[[datadic objectForKey:@"dg"] objectAtIndex:crowdbt.tag];
    [dic setObject:[arrdic objectForKey:@"dgname"] forKey:@"name"];
    [dic setObject:[arrdic objectForKey:@"dgid"] forKey:@"id"];
    [dic setObject:[arrdic objectForKey:@"mcnt"] forKey:@"mcnt"];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"lianxiren"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"lianxirenqun"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSArray *arr = [NSArray arrayWithObjects:[dic objectForKey:@"id"],[[[datadic objectForKey:@"dg"] objectAtIndex:crowdbt.tag]objectForKey:@"dtype"], nil];

    if ([[[UserInfo sharedManager] usertype] isEqualToString:@"1"]||[[[UserInfo sharedManager] usertype] isEqualToString:@"0"]) {
        arr = [NSArray arrayWithObjects:[dic objectForKey:@"id"],@"1", nil];
    }
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"relodataarr"];
    [Utils changeViewControllerWithTabbarIndex:5];
//    ChatWithFriendViewController *vc =[[ChatWithFriendViewController alloc]init];
//  
//    NSLog(@"%@",[[datadic objectForKey:@"dg"] objectAtIndex:crowdbt.tag]);
//    vc.entrance = @"qun";
//    vc.talkId=[dic objectForKey:@"dgid"];
//    vc.titleName=[dic objectForKey:@"dgname"];
//    vc.memberCount=[dic objectForKey:@"mcnt"];
//    vc.isPushString=@"is";

//    NSLog(@"%@",[[UserInfo sharedManager] usertype]);
//    if ([[[UserInfo sharedManager] usertype] isEqualToString:@"1"]||[[[UserInfo sharedManager] usertype] isEqualToString:@"0"]) {
//        arr = [NSArray arrayWithObjects:[dic objectForKey:@"dgid"],@"1", nil];
//    }

 
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)heradclick:(UIButton *)mybt
{
     FvaluePeopleData *vc = [[FvaluePeopleData alloc]init];
//    PersonalDataVC *detailView=[[PersonalDataVC alloc]init];
//    detailView.peopleid =[[[datadic objectForKey:@"team"] objectAtIndex:mybt.tag]objectForKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pushCompanInVC
{
     FvaProCompanInVC  *detailView=[[ FvaProCompanInVC alloc]init];
     detailView.datadic = datadic;
    [self.navigationController pushViewController:detailView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==4) {
        return 130;
    }
     if (indexPath.row ==0) {
         return 0;
     }
    if (indexPath.row == 7) {
        return 0;
    }
    if (indexPath.row ==6) {
        return 40;
    }
    if (indexPath.row==5) {
        return 80;
    }
    if ([[[UserInfo sharedManager] usertype] isEqualToString:@"1"]) {
        if (indexPath.row==9) {
            return 0;
            
        }
    }
  
    return 90;
}

@end
