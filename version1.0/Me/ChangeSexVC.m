//
//  ChangeSexVC.m
//  FangChuang
//
//  Created by weiping on 14-10-13.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ChangeSexVC.h"

@interface ChangeSexVC ()

{
    UIButton *sexbt;
    UIButton *sexbt2;
    UIImageView *imageView;
    UIImageView *imageView2;
    NSString *sextext;
}
@end

@implementation ChangeSexVC

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
    [self setTitle:@"性别"];
    [self setTabBarHidden:YES];
    [self addBackButton];
   
//    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    

    
//    UIView *sexview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 100)];
//    sexview.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:sexview];
   sexbt = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 320, 50)];
    sexbt.tag=1;
    sexbt.backgroundColor = [UIColor whiteColor];
    [sexbt.titleLabel setTextColor:[UIColor blackColor]];
    [sexbt addTarget:self action:@selector(changesex:) forControlEvents:UIControlEventTouchDown ];
    [self.contentView addSubview:sexbt];
    
    UILabel *sexlable = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 50, 50)];
    sexlable.text = @"男";
    [self.contentView addSubview:sexlable];
    
  
    
    sexbt2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 70, 320, 50)];
    sexbt2.tag=2;
     [sexbt2 addTarget:self action:@selector(changesex:) forControlEvents:UIControlEventTouchDown ];
    sexbt2.backgroundColor = [UIColor whiteColor];
    [sexbt2.titleLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:sexbt2];
    UILabel *sexlable2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 50, 50)];
    sexlable2.text = @"女";
    [self.contentView addSubview:sexlable2];
    
    UIImageView *imageViewline=[[UIImageView alloc]initWithFrame:CGRectMake(20,70 ,280,1)];
    [imageViewline setImage:[UIImage imageNamed:@"60_fengexian_1"]];
    [self.contentView addSubview:imageViewline];
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(270,30,20,20)];
    [imageView setImage:[UIImage imageNamed:@"checksex"]];
    [self.contentView addSubview:imageView];
    imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(270,80,20,20)];
    [imageView2 setImage:[UIImage imageNamed:@"checksex"]];
    [self.contentView addSubview:imageView2];
    imageView2.hidden=YES;
    imageView.hidden=YES;
    if ([sextext isEqualToString:@"男"]) {
        imageView.hidden=NO;
    }else
    {
        imageView2.hidden=NO;
    }


//    imageView2.hidden=YES;
//     imageView.hidden=YES;

    // Do any additional setup after loading the view.
}
- (id)initWithSex:(NSString *)sex
{
    sextext=sex;
    return self;
}
-(void)changesex:(UIButton *)sexbtn
{
    if (sexbtn.tag==1) {
      
        imageView.hidden=NO;
        imageView2.hidden=YES;
     
         [[NSNotificationCenter defaultCenter] postNotificationName:@"changesex" object:@"男"];
    }else
    {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"changesex" object:@"女"];
        imageView.hidden=YES;
         imageView2.hidden=NO;

    }
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
