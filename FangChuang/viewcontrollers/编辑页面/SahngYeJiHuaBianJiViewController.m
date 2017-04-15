//
//  SahngYeJiHuaBianJiViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-8.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//商业计划编辑界面，暂时取消

#import "SahngYeJiHuaBianJiViewController.h"
#import "RTLabel.h"
#import "CaiWuMoXingBianJiViewController.h"
#import "FaWuViewController.h"
#import "RongZiFangAnViewController.h"
#import "FangChuangGuanDianViewController.h"

@interface SahngYeJiHuaBianJiViewController ()

@end

@implementation SahngYeJiHuaBianJiViewController
@synthesize myDic;
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
    [self .titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
	[self.titleLabel setText:@"北极绒商业计划"];
    [self setTabBarHidden:YES];
    [self addBackButton];
    
    
    
    /*
     
     headerview
     
     cell
     
     footerView
     
     */
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setSeparatorColor:[UIColor grayColor]];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.contentView addSubview:myTableView];
    
    [self initHeadView];
    [self initFootView];
    [self initViewEnterTheInformation];
    
    
    
    
}
#pragma mark - init View

- (void) initHeadView
{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 660)];
    //[myTableView setTableHeaderView:headView];
    //[headView release];
    
    [headView setBackgroundColor:[UIColor clearColor]];
    //添加logo
    logoImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    
    [logoImageView setContentMode:UIViewContentModeScaleAspectFit];
    [headView addSubview:logoImageView];

    
    
    
    //添加按钮切换兰
    
    ButtonView* buttonView = [[ButtonView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(logoImageView.frame), 0, 0)
                                                      delegate:self
                                                        titles:[NSArray arrayWithObjects:@"财务模型",@"融资方案",@"法务",@"方创观点", nil]];
    
    [headView addSubview:buttonView];

    
    
    firstView = [[ModuleView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(buttonView.frame) + 20, 310, 100)
                                       titleArray:[NSArray arrayWithObjects:@"【定位】:",@"【模式】:",@"【卖点】:", nil]
                                     contentArray:[NSArray arrayWithObjects:[myDic objectForKey:@"position"],[myDic objectForKey:@"model"],[myDic objectForKey:@"factor"], nil]
                                       titleColor:nil
                                     contentColor:nil];
    
    
    [headView addSubview:firstView];

    
    
    secondView = [[ModuleView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(firstView.frame) + 20, 310, 100)
                                        titleArray:[NSArray arrayWithObjects:@"【【企业全称】:",@"【所在地区】:",@"【所在行业】:",@"【行业网址】:", nil]
                                      contentArray:[NSArray arrayWithObjects:[myDic objectForKey:@"fullname"],[myDic objectForKey:@"location"],[myDic objectForKey:@"industry"],[myDic objectForKey:@"url"], nil]
                                        titleColor:nil
                                      contentColor:nil];
    
    
    [headView addSubview:secondView];

    
    
    threedView = [[ModuleView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(secondView.frame) + 20, 310, 100)
                                        titleArray:[NSArray arrayWithObjects:@"【市场规模】:",@"【产品】:",@"【营销】:",@"【竞争力】:",@"【技术研发】:",@"【运营数据】:", nil]
                                      contentArray:[NSArray arrayWithObjects:[myDic objectForKey:@"marketsize"],[myDic objectForKey:@"product"],[myDic objectForKey:@"marketing"],[myDic objectForKey:@"compete"],[myDic objectForKey:@"rd"],[myDic objectForKey:@"finance"], nil]
                                        titleColor:nil
                                      contentColor:nil];
    
    
    [headView addSubview:threedView];

    
    
    
    sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(threedView.frame) + 10, 300, 20)];
    [sectionLabel setBackgroundColor:[UIColor clearColor]];
    [sectionLabel setTextColor:ORANGE];
    [sectionLabel setText:@"团队与人数:"];
    [sectionLabel setFont:[UIFont systemFontOfSize:15.f]];
    [headView addSubview:sectionLabel];

    
    
    UIImage *xianImage=[UIImage imageNamed:@"46_xian_1"];
    UIImageView *xianimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sectionLabel.frame)+10, 320, 1)];
    [xianimage setImage:xianImage];
    [headView addSubview:xianimage];

    
    [headView setFrame:CGRectMake(0, 0, 320, 550)];
    [myTableView setTableHeaderView:headView];

    
}


- (void)initFootView
{
    
 
    
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 550)];
    [footView setBackgroundColor:[UIColor clearColor]];
    [footView setUserInteractionEnabled:YES];
    [myTableView setTableFooterView:footView];

    
    UILabel* sectionLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10,  0, 300, 20)];
    [sectionLabel1 setBackgroundColor:[UIColor clearColor]];
    [sectionLabel1 setTextColor:ORANGE];
    [sectionLabel1 setText:@"留言:"];
    [sectionLabel1 setFont:[UIFont systemFontOfSize:15.f]];
    [footView addSubview:sectionLabel1];

    
    
    
    
    NSArray *dataArray=[NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"key1",@"2222",@"key2",@"3333",@"key3", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"key1",@"2222",@"key2",@"3333",@"key3", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"key1",@"2222",@"key2",@"3333",@"key3", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"key1",@"2222",@"key2",@"3333",@"key3", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"key1",@"2222",@"key2",@"3333",@"key3", nil],
                        nil];
    
    
    NSArray *array=[NSArray arrayWithObjects:@"发表于",@"标题",@"回复内容", nil];
    
    CGFloat nextHeight = 20;
    
    for (int i = 0; i < dataArray.count; i ++) {
        
        NSDictionary* dic = [dataArray objectAtIndex:i];
        
        
        UIImageView *xianIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, nextHeight, 320, 1)];
        [xianIMG setImage:[UIImage imageNamed:@"004_fengexian_1"]];
        [footView addSubview:xianIMG];

        
        
        
        
        for (int j = 0; j < array.count; j++) {
            
            UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(5, nextHeight, 50, 20)];
            [lab setText:[array objectAtIndex:j]];
            [lab setBackgroundColor:[UIColor clearColor]];
            [lab setTextColor:[UIColor grayColor]];
            [lab setTag:j+100];
            [Utils setDefaultFont:lab size:12];
            [footView addSubview:lab];

            
            if (lab.tag==100) {
                [lab setText:[NSString stringWithFormat:@"%@:%@",[array objectAtIndex:j],dic[@"key1"]]];
            }else if (lab.tag==101){
                [lab setText:[NSString stringWithFormat:@"%@:%@",[array objectAtIndex:j],dic[@"key2"]]];
            }else if(lab.tag==102){
                [lab setText:[NSString stringWithFormat:@"%@:%@",[array objectAtIndex:j],dic[@"key3"]]];
            }
            
            CGSize size = [lab.text sizeWithFont:lab.font constrainedToSize:CGSizeMake(MAXFLOAT, 20) lineBreakMode:lab.lineBreakMode];
            [lab setFrame:CGRectMake(5, nextHeight, size.width, 20)];
            nextHeight = CGRectGetMaxY(lab.frame) ;
            
            NSLog(@"nextheig =%f",nextHeight);
            
        }
        
        UIImageView *xianNextIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, nextHeight, 320, 1)];
        [xianNextIMG setImage:[UIImage imageNamed:@"004_fengexian_1"]];
        [footView addSubview:xianNextIMG];

        
        
    }
    
    
//    [footView setFrame:CGRectMake(0, 0, 320, nextHeight)];
    
    UILabel *tiltelab =[[UILabel alloc]initWithFrame:CGRectMake(5, nextHeight+10, 50, 30)];
    [tiltelab setBackgroundColor:[UIColor clearColor]];
    [tiltelab setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:tiltelab size:13];
    [tiltelab setText:@"标题:"];
    [footView addSubview:tiltelab];

    
    UIImageView *kuangimageView=[[UIImageView alloc]initWithFrame:CGRectMake(50, nextHeight+10, 260, 30)];
    [kuangimageView setImage:[UIImage imageNamed:@"10_shurukuang_3"]];
    [footView addSubview:kuangimageView];

    
    UITextField *titleTextfield=[[UITextField alloc]initWithFrame:CGRectMake(55, nextHeight+10, 260-10, 30-4)];
    [titleTextfield setBackgroundColor:[UIColor clearColor]];
    [titleTextfield setBorderStyle:UITextBorderStyleNone];
    [titleTextfield setKeyboardType:UIKeyboardTypeEmailAddress];
    [titleTextfield setDelegate:self];
    [footView addSubview:titleTextfield];

    
    
    UIImageView *kuangImageView=[[UIImageView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(kuangimageView.frame)+10, 260, 100)];
    [kuangImageView setImage:[UIImage imageNamed:@"10_shurukuang_4"]];
    [footView addSubview:kuangImageView];

    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(kuangimageView.frame)+10, 260, 100)] ;
    [textView setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:textView size:12];
    [textView.layer setCornerRadius:10];
    [textView setDelegate:self];
    [textView setBackgroundColor:[UIColor greenColor]];
    [textView setText:@"请输入文本"];
    [textView setReturnKeyType:UIReturnKeyDefault];
    [textView setKeyboardType:UIKeyboardTypeDefault];
    [textView setScrollEnabled:YES];
    [textView setUserInteractionEnabled:YES];
    [textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [footView addSubview: textView];

    
    
    UIImage *image2=[UIImage imageNamed:@"03_anniu_1"];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake((320-254)/2, CGRectGetMaxY(textView.frame)+20, 508/2, 66/2)];
    [button setBackgroundImage:image2 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Submit:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:button];
    
    

    
}

- (void)initViewEnterTheInformation{
    UIView *informationView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(footView.frame), 320, self.contentViewHeight)];
    [informationView setBackgroundColor:[UIColor clearColor]];
    [myTableView addSubview:footView];

    
   

}



#pragma mark - buttonView delegate

- (void)buttonViewSelectIndex:(int)index buttonView:(ButtonView *)view
{
    if (index == 0) {
        CaiWuMoXingBianJiViewController* viewController = [[CaiWuMoXingBianJiViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];

        
        
    }
    else if (index == 1) {
        FaWuViewController* viewController = [[FaWuViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];

        
    }
    else if (index == 2) {
        RongZiFangAnViewController* viewController = [[RongZiFangAnViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];

        
        
    }
    else if (index == 3) {
        FangChuangGuanDianViewController* viewController = [[FangChuangGuanDianViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];

        
        
    }
    
}


#pragma mark - button action
- (void)talkWithFangChuang:(UIButton*)button
{
    printf(__FUNCTION__);
}


#pragma mark - tableview delegate and dataSoucre

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = nil;
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        
        
        CacheImageView* headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(10, 10, 92 / 2., 92 / 2.)];
        [headImageView setImage:[UIImage imageNamed:@"61_touxiang_1"]];
        [cell.contentView addSubview:headImageView];

        
        
        
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 10, CGRectGetMinY(headImageView.frame), 320 - CGRectGetMaxX(headImageView.frame) - 20, 15)];
        [nameLabel setFont:[UIFont systemFontOfSize:13]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:nameLabel];

        
        
        UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame), CGRectGetWidth(nameLabel.frame), 50)];
        [contentLabel setNumberOfLines:0];
        [contentLabel setFont:[UIFont systemFontOfSize:11]];
        [contentLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        [contentLabel setTextColor:GRAY];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:contentLabel];

        
        
        [nameLabel setText:@"张三"];
        [contentLabel setText:@"zhangdjfladjfajdfajdlfaldfazhangdjfladjfajdfajdlfaldfazhangdjfladjfajdfajdlfaldfazhangdjfladjfajdfajdlfaldfazhangdjfladjfajdfajdlfaldfazhangdjfladjfajdfajdlfaldfa;dfasdf;adf;ad;dafjdl;ajdfl;adfj"];
        
        UIImage *xianImage=[UIImage imageNamed:@"46_xian_1"];
        UIImageView *xianimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(contentLabel.frame)+5, 320, 1)];
        [xianimage setImage:xianImage];
        [cell.contentView addSubview:xianimage];

        
    }
    
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85 ;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [UIView beginAnimations:@"" context:nil];
    self.contentView.frame=CGRectMake(0, 64, 320, self.contentViewHeight);
    [UIView commitAnimations];
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView beginAnimations:@"" context:nil];
    self.contentView.frame=CGRectMake(0, -64, 320, self.contentViewHeight);
    [UIView commitAnimations];
    return YES;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [UIView beginAnimations:@"" context:nil];
        self.contentView.frame=CGRectMake(0, 64, 320, self.contentViewHeight);
        [UIView commitAnimations];
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    [UIView beginAnimations:@"" context:nil];
    self.contentView.frame=CGRectMake(0, -90, 320, self.contentViewHeight);
    [UIView commitAnimations];
    return YES;
}


- (void)Submit:(UIButton *)sender{
    NSLog(@"发送");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
