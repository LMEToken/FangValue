//
//  FvalueChangePWD.m
//  FangChuang
//
//  Created by Tom on 14-11-22.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvalueChangePWD.h"

@interface FvalueChangePWD ()

@end

@implementation FvalueChangePWD

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
    [self setTitle:@"修改密码"];
//    [self addbackview];
////    [self setTabBarHidden:YES];
//    [self addview];
//    self.contentView.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)addview
{
    
//    backScrollerView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
//    [backScrollerView setBackgroundColor:[UIColor clearColor]];
//    [backScrollerView setShowsVerticalScrollIndicator:NO];
//    [backScrollerView setContentSize:CGSizeMake(320,self.contentViewHeight+3
//                                        )];
//    [backScrollerView setDelegate:self];
//    backScrollerView.backgroundColor=[UIColor clearColor];
//    [self.contentView addSubview:backScrollerView];
//    
//    UITextField *NewPwd = [[UITextField alloc]initWithFrame:CGRectMake(30, 50, self.contentView.frame.size.width-60, 40)];
////    NewPwd.borderStyle =
//    [backScrollerView addSubview:NewPwd];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
