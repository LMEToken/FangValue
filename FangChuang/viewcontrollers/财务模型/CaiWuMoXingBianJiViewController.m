//
//  CaiWuMoXingBianJiViewController.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//财务模型编辑
#import "CaiWuMoXingBianJiViewController.h"
//2014.05.30 chenlihua 使点击保存按钮时，返回到财务信息界面。
#import "CaiWuMoXingViewController.h"

@interface CaiWuMoXingBianJiViewController ()

@end

@implementation CaiWuMoXingBianJiViewController


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
	[self.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.titleLabel setText:@"编辑"];
    [self addBackButton];
    [self setTabBarHidden:YES];
    
    //添加导航右按钮(图片中未显示)
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   // [rightBtn setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.height - 10 - 40, (45 - 25) / 2., 40, 25)];
    
    //2014.05.30 chenlihua 保存按钮未显示，改变其坐标，使其显示。
    [rightBtn setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-10-40  , (45 - 25) / 2., 40, 25)];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:rightBtn];
    
    //背景图片
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, self.contentViewHeight)];
  //  mainScrollView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:mainScrollView];
    
    //预留 50
    //年度选择Label
    UILabel* typeLb  =[[UILabel alloc] initWithFrame:CGRectMake(10, (40 - 15) / 2., 70, 20)];
    [typeLb setBackgroundColor:[UIColor clearColor]];
    [typeLb setTextColor:GRAY];
    [typeLb setText:@"年度选择"];
    [typeLb setFont:[UIFont systemFontOfSize:15]];
    [mainScrollView addSubview:typeLb];

    //年度选择按钮
    UIImage *chooseKuang = [UIImage imageNamed:@"15_anniu_1.png"];
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn setFrame:CGRectMake(CGRectGetMaxX(typeLb.frame)-5, 10, chooseKuang.size.width/2-20, chooseKuang.size.height/2)];
    [chooseBtn setBackgroundImage:chooseKuang forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(chooseYear:) forControlEvents:UIControlEventTouchUpInside];
  //  [self.contentView addSubview:chooseBtn];
    //2014.07.22 chenlihua 点击编辑时，“年度选择”按钮会浮起。
    [mainScrollView addSubview:chooseBtn];
    
    //年度选择前面的"年"
    yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(typeLb.frame), 10, 70, chooseKuang.size.height/2)];
    [yearLabel setBackgroundColor:[UIColor clearColor]];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"year2"]) {
        [yearLabel setText:@"2013"];
    }else{
        [yearLabel setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"year2"]];
    }
    [yearLabel setFont:[UIFont systemFontOfSize:14]];
    [yearLabel setTextColor:[UIColor grayColor]];
    //[self.contentView addSubview:yearLabel];
    [mainScrollView addSubview:yearLabel];

    //年度选择下的线
    UIView* xianV = [[UIView alloc] initWithFrame:CGRectMake(0 , 50, 320, 1)];
    [xianV setBackgroundColor:[UIColor grayColor]];
    [mainScrollView addSubview:xianV];

    //
    NSArray* titiles = [NSArray arrayWithObjects:@"收入:",@"上市时预计收入:",@"净利润:",@"上市时预计收入:",@"毛利润:",@"上市时预计收入:",@"收入:",@"现金流量:", nil];
    CGFloat height = CGRectGetMaxY(xianV.frame) + 5;
    for (int i = 0; i < titiles.count; i ++) {
        //第二部分前面的Label
        NSString* title = [titiles objectAtIndex:i];
        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20) lineBreakMode:NSLineBreakByCharWrapping];
        UILabel* titleLb = [[UILabel alloc] initWithFrame:CGRectMake( i % 2 ? 140 : 10, height , size.width, 20)];
        [titleLb setFont:[UIFont fontWithName:KUIFont size:16]];
//        [titleLb setTextColor:[]];
        [titleLb setText:title];
        [titleLb setLineBreakMode:NSLineBreakByCharWrapping];
        [titleLb setBackgroundColor:[UIColor clearColor]];
        [mainScrollView addSubview:titleLb];
        
        //第二部分内容textField
        UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLb.frame), CGRectGetMinY(titleLb.frame), (i % 2 ? 320 : 140 )-  CGRectGetMaxX(titleLb.frame), 20)];
//        [textField setTextColor:GRAY];
        [textField setBorderStyle:UITextBorderStyleNone];
       // textField.backgroundColor=[UIColor redColor];
        [mainScrollView addSubview:textField];
        [textField setDelegate:self];
        [textField setTag:100 + i];
        [textField setFont:[UIFont fontWithName:KUIFont size:16]];
        [textField setText:@""];
        
        if (i % 2) {
            height = CGRectGetMaxY(titleLb.frame) + 5;
        }
    }
    //第二部分下划线
    UIView* xianV1 = [[UIView alloc] initWithFrame:CGRectMake(0 , height + 5, 320, 1)];
    [xianV1 setBackgroundColor:[UIColor grayColor]];
    [mainScrollView addSubview:xianV1];

    //第三部分背景图
    UIImageView* backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(xianV1.frame) + 20 , 310, 280)];
    [backImageView setImage:[UIImage imageNamed:@"60_kuang_2"]];
    [mainScrollView addSubview:backImageView];
    
    //第三部分前面的Label
    NSArray* titiles1 = [NSArray arrayWithObjects:@"【融资轮数】:",@"【融资模式】:",@"【上市时间】:",@"【技术研发】:",@"【同行业上市公司平均市盈率】:",@"【估值依据年度】:",@"【估值方法】:",@"【倍数】:",@"【本次融资金额】:",@"【总估值】:",@"【年预计回报率（IRR）】:", nil];
    height = CGRectGetMinY(backImageView.frame) + 10;
    for (int i = 0; i < titiles1.count; i ++) {
        
        NSString* title = [titiles1 objectAtIndex:i];
        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20) lineBreakMode:NSLineBreakByCharWrapping];
        
        //第三部分前面的Label
        UILabel* titleLb = [[UILabel alloc] initWithFrame:CGRectMake( 5, height , size.width, 20)];
        [titleLb setFont:[UIFont systemFontOfSize:16]];
[titleLb setTextColor:ORANGE];
        [titleLb setText:title];
        [titleLb setLineBreakMode:NSLineBreakByCharWrapping];
        [titleLb setBackgroundColor:[UIColor clearColor]];
        [mainScrollView addSubview:titleLb];

        //第三部分后面的textField
        UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLb.frame), CGRectGetMinY(titleLb.frame), 310 - 5 -  CGRectGetMaxX(titleLb.frame), 20)];
        //        [textField setTextColor:GRAY];
        [textField setBorderStyle:UITextBorderStyleNone];
       // textField.backgroundColor=[UIColor redColor];
        [mainScrollView addSubview:textField];
        [textField setDelegate:self];
        [textField setTag:100 + i];
        [textField setFont:[UIFont systemFontOfSize:16]];
        [textField setText:@""];
        
        height = CGRectGetMaxY(titleLb.frame) + 5;
    }
    [mainScrollView setContentSize:CGSizeMake(320, height)];
}
#pragma  -mark -UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect rect = textField.frame;
    rect = [self.view convertRect:rect fromView:mainScrollView];
    
    if (CGRectGetMaxY(rect) < [[UIScreen mainScreen] bounds].size.height - 216 - 20) {
        return;
    }
    
    CGPoint point = [mainScrollView convertPoint:rect.origin toView:self.view];
    NSLog(@"point = %@",NSStringFromCGPoint(point));
    
    [UIView animateWithDuration:.35 animations:^{
        [mainScrollView setFrame:CGRectMake(0,  [[UIScreen mainScreen] bounds].size.height - 216 - point.y - CGRectGetHeight(rect) - 65, CGRectGetWidth(mainScrollView.frame), CGRectGetHeight(mainScrollView.frame))];
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (CGRectGetMinY(mainScrollView.frame) == 0) {
        return;
    }
    [UIView animateWithDuration:.35 animations:^{
        [mainScrollView setFrame:CGRectMake(0,  0, CGRectGetWidth(mainScrollView.frame), CGRectGetHeight(mainScrollView.frame))];

    }];
}
#pragma  -mark -doClickAction
//完成按钮
- (void)rightButton:(UIButton*)button
{
    //2014.05.30 chenlihua 使点击保存按钮，使其跳转到财务信息界面。
    CaiWuMoXingViewController *caiView=[[CaiWuMoXingViewController alloc]init];
    [self.navigationController pushViewController:caiView animated:YES];
}
//选择年
- (void)chooseYear:(UIButton*)sender
{
    yearArray = [[NSArray alloc]initWithObjects:@"2012",@"2013",@"2014", nil];
    myPickerView = [[APickerView alloc]initWithData:yearArray];
    myPickerView.delegate = self;
    [self.contentView addSubview:myPickerView];

    [myPickerView setSelectRow:[[[NSUserDefaults standardUserDefaults]objectForKey:@"year2Index"]intValue] inComponent:0 animated:YES];
}
#pragma -mark -APickerViewDelegate
- (void) pickerViewSelectObject : (id) object index : (NSInteger) index
{
    [[NSUserDefaults standardUserDefaults]setObject:[yearArray objectAtIndex:index] forKey:@"year2"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",index] forKey:@"year2Index"];
    [[NSUserDefaults standardUserDefaults]synchronize];
        
    //    [UIView animateWithDuration:.5f delay:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        [myPickerView setFrame:CGRectMake(0, self.contentViewHeight+216, 320, 216)];
    //    } completion:nil];
    yearLabel.text = [yearArray objectAtIndex:index];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
