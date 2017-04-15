//
//  SubordinateFieldVC.m
//  FangChuang
//
//  Created by weiping on 14-10-13.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "SubordinateFieldVC.h"

@interface SubordinateFieldVC ()

@end

@implementation SubordinateFieldVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)typeclick:(UIButton *)mybtn
{
    if (mybtn.backgroundColor ==[UIColor grayColor]) {
           mybtn.backgroundColor = [UIColor whiteColor];
        [typearr removeObject:[savearr objectAtIndex:mybtn.tag]];
    }else
    {
        mybtn.backgroundColor = [UIColor grayColor];
        NSLog(@"%@",[savearr objectAtIndex:mybtn.tag]);
        [typearr addObject:[savearr objectAtIndex:mybtn.tag]];
    
        NSLog(@"%@",typearr);
    }

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UserInfo sharedManager] usertype]isEqualToString:@"1"]) {
        [self setTitle:@"基金币种"];
        
    }else
    {
    [self setTitle:@"所属领域"];
    }
    [self setTabBarHidden:YES];
    [self addBackButton];
    
    UIButton *heardbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    heardbtn.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:heardbtn];
    UILabel *heradllable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 40)];
    [heradllable setFont:[UIFont fontWithName:KUIFont size:13]];
    [heradllable setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:heradllable];
    typearr = [[NSMutableArray alloc]init];
    
    if ([[[UserInfo sharedManager] usertype]isEqualToString:@"1"]) {
      savearr = [NSArray arrayWithObjects:@"人民币",@"美元",@"不限",@"添加", nil];
        heradllable.text = @"投资人基金币种";
    }else
    {
    savearr = [NSArray arrayWithObjects:@"电子商务",@"移动互联网",@"大健康",@"O2O",@"企业服务",@"快消品",@"旅游服务",@"新媒体", @"在线教育",@"互联网金融",@"文化创意",@"智能硬件",@"新农业",@"游戏动漫",@"大数据",@"高端制造",@"新材料",@"环保能源",@"不限",nil];
          heradllable.text = @"创业者领域";
    }


    NSInteger count=[savearr count];
    NSInteger line=4;
    NSInteger sheng=count-line*(count/line);
    for (int i = 0; i<count/line; i++) {
        for (int j =0;j<line; j++) {
            UILabel *typebutton[line][count/line];
            UIButton *typebutton2[line][count/line];
      
            typebutton2[i][j]= [[UIButton alloc]initWithFrame:CGRectMake(20+75*j, 60+70*i, 65, 50)];
            typebutton2[i][j].backgroundColor = [UIColor whiteColor];
            typebutton2[i][j].tag=line*i+j;
            [typebutton2[i][j] addTarget:self action:@selector(typeclick:) forControlEvents:UIControlEventTouchDown];
            [self.contentView addSubview:typebutton2[i][j]];
            typebutton[i][j]= [[UILabel alloc]initWithFrame:CGRectMake(20+75*j, 60+70*i, 65, 50)];
            typebutton[i][j].textAlignment = UITextAlignmentCenter;
            typebutton[i][j].text =[savearr objectAtIndex:line*i+j];
            [typebutton[i][j] setFont:[UIFont fontWithName:KUIFont size:13]];
            [self.contentView addSubview:typebutton[i][j]];
        }
    }
    
    for (int n=0; n<sheng; n++) {
        UIButton *typebutton = [[UIButton alloc]initWithFrame:CGRectMake(20+75*n, 60+70*(count/line), 65, 50)];
        [typebutton addTarget:self action:@selector(typeclick:) forControlEvents:UIControlEventTouchDown];
        typebutton.tag =(line *(count/line))+n;
        typebutton.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:typebutton];
        UILabel *typelable = [[UILabel alloc]initWithFrame:CGRectMake(20+75*n, 60+70*(count/line), 65, 50)];
        
         typelable.textAlignment = UITextAlignmentCenter;
        typelable.text =[savearr objectAtIndex:(line *(count/line))+n];
        [typelable setFont:[UIFont fontWithName:KUIFont size:13]];
        [self.contentView addSubview:typelable];

    }

    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];   [rightButton setTitle:@"确认" forState:UIControlStateNormal];
    //    [rightButton setTitle:@"完成" forState:UIControlStateHighlighted];
     [rightButton addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchDown];
    [rightButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:13]];
    [self addRightButton:rightButton isAutoFrame:NO];

    // Do any additional setup after loading the view.
}
-(void)goback
{
   [[NSNotificationCenter defaultCenter] postNotificationName:@"changeSubord" object:typearr];
   [self.navigationController popViewControllerAnimated:NO];
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
