//
//  14BianJiViewController.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "14BianJiViewController.h"

@interface _4BianJiViewController ()

@end

@implementation _4BianJiViewController
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
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
	[self.titleLabel setText:@"编辑"];
    [self setTabBarHidden:YES];
    [self addBackButton];
    
    
    /*
     
     headerview
     
     cell
     
     footerView
     
     */
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [self.contentView addSubview:myTableView];

    
    [self initHeadView];
    
    
    
    
}
#pragma mark - init View

- (void) initHeadView
{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    [myTableView setTableHeaderView:headView];

    
    
    
    UIImageView* iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 70, 58 / 2)];
    [iconImgV setBackgroundColor:[UIColor blackColor]];
    [headView addSubview:iconImgV];

    
    
    ButtonView* buttonView = [[ButtonView alloc] initWithFrame:CGRectMake(10, 10, 0, 0)
                                                      delegate:self
                                                        titles:[NSArray arrayWithObjects:@"财务模型",@"融资方案",@"法务",@"方创观点", nil]];
    
    [headView addSubview:buttonView];

    
    UIImageView* backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(buttonView.frame) + 20 , 310, 280)];
    [backImageView setImage:[UIImage imageNamed:@"60_kuang_2"]];
    [headView addSubview:backImageView];

    
    
    
    CGFloat height = CGRectGetMinY(backImageView.frame) + 5;
    NSArray* titiles1 = [NSArray arrayWithObjects:@"【定位】:",@"【模式】:",@"【卖点】:", nil];
    
    for (int i = 0; i < titiles1.count; i ++) {
        
        NSString* title = [titiles1 objectAtIndex:i];
        
        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20) lineBreakMode:NSLineBreakByCharWrapping];
        
        UILabel* titleLb = [[UILabel alloc] initWithFrame:CGRectMake( 5, height , size.width, 20)];
        [titleLb setFont:[UIFont systemFontOfSize:16]];
        [titleLb setTextColor:ORANGE];
        [titleLb setText:title];
        [titleLb setLineBreakMode:NSLineBreakByCharWrapping];
        [titleLb setBackgroundColor:[UIColor clearColor]];
        [headView addSubview:titleLb];

        
        
        
        UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLb.frame), CGRectGetMinY(titleLb.frame), 310 - 5 -  CGRectGetMaxX(titleLb.frame), 20)];
        //        [textField setTextColor:GRAY];
        [textField setBorderStyle:UITextBorderStyleNone];
        [headView addSubview:textField];
        textField.delegate = (id<UITextFieldDelegate>)self;
        [textField setTag:100 + i];
        [textField setFont:[UIFont systemFontOfSize:16]];
        [textField setText:@"60"];
        
        
        height = CGRectGetMaxY(titleLb.frame) + 5;
        
    }

    
    
    
    
    
    
}




@end
