//
//  FvaProCrowdDataVC.m
//  FangChuang
//
//  Created by weiping on 14-9-20.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaProCrowdDataVC.h"

@interface FvaProCrowdDataVC ()

@end

@implementation FvaProCrowdDataVC

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
    [self setTitle:@"群详细资料"];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self addTableview];
    [self addfriedview];
    // Do any additional setup after loading the view.
}
-(void)addfriedview
{
    //    NSLog(@"%f",self.contentView.frame.size.height);
    UIView *downview = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height-50, 320, 50)];
    downview.backgroundColor = [UIColor whiteColor];
    UIButton *addbt = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
    [addbt setBackgroundImage:[UIImage imageNamed:@"sendadd"] forState:UIControlStateNormal ];
    [addbt addTarget:self action:@selector(sendadd) forControlEvents: UIControlEventTouchDown];
    [downview addSubview:addbt];
    [self.contentView addSubview:downview];
    
}
- (void)sendadd
{
    NSLog(@"你申请加入了");
}
- (void)addTableview
{
    self.CrowdTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height-50) style:UITableViewStylePlain];
    //UITableViewStylePlain];
    [self.CrowdTableview setDelegate:self];
    [ self.CrowdTableview setDataSource:self];
    [self.contentView addSubview:self.CrowdTableview];
    
    tableArray = [[NSMutableArray alloc]init];
    //为表单数组添加元素
    [tableArray addObject:[self newSectionArr:0 andRow:1]];
    [tableArray addObject:[self newSectionArr:1 andRow:1]];
    [tableArray addObject:[self newSectionArr:2 andRow:1]];
    [tableArray addObject:[self newSectionArr:3 andRow:1]];
}
//定义这是第几块，块里面有多少行，数组里面保存行的内容
- (NSMutableArray*)newSectionArr:(NSInteger)section andRow:(NSInteger)row
{
    NSMutableArray *sectionArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < row; i ++) {
        [sectionArr addObject:[NSString stringWithFormat:@"Section:%ld,Row:%ld",(long)section,(long)i]];
    }
    return sectionArr;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableVIewDelegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[tableArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FvaProCrowdDataCell *cell = [[FvaProCrowdDataCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        UIImageView *herdimage = [[UIImageView alloc]initWithFrame:CGRectMake(20  , 10, 60 , 60)];
        herdimage.image = [UIImage imageNamed:@"PresonImage"];
        [cell addSubview:herdimage];
        UILabel *heradlable = [[UILabel alloc]initWithFrame:CGRectMake(100  , 10, 60 , 60)];
        heradlable.text = @"UMI";
        [cell addSubview:heradlable];
    }
    if (indexPath.section==1) {
               UIButton *preson[3] ;
        for (int i =0; i<3; i++) {
            preson[i] = [[UIButton alloc]init];
            preson[i].frame = CGRectMake(20+80*i+i*20, 10, 90, 80);
            [preson[i] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"qunimage%d",i+1]] forState:UIControlStateNormal];
            [cell addSubview:preson[i]];
        }
    }
    if (indexPath.section==2) {
        UIButton *preson[6] ;
        for (int i =0; i<6; i++) {
            preson[i] = [[UIButton alloc]init];
            preson[i].frame= CGRectMake(20+40*i+5*i, 3, 40, 40);
            [preson[i] setImage:[UIImage imageNamed:@"qunimage4"] forState:UIControlStateNormal];
            [preson[i] addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchDown];
            [cell addSubview:preson[i]];
            UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(200, 10, 10, 20)];
            [myview setImage:[UIImage imageNamed:@"accessory"]];
            cell.accessoryView = myview;
        }
    }
    if (indexPath.section==3) {
        UILabel *mylable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 300, 40)];
        [mylable  setFont:[UIFont fontWithName:KUIFont size:13]];
        mylable.textColor = [UIColor grayColor];
        mylable.text = @"方创内部交流。进群后请修改备注";
      
        [cell addSubview:mylable];
    }
    return cell;

}
-(void)add
{
    NSLog(@"aaaa");
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return @"群相册";
    }
    if (section==2) {
        return @"群成员";
    }
    if (section==3) {
        return @"备注";
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section!=0) {
        return 35;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 80;
    }
    if (indexPath.section==1) {
        return 100;
    }
    if (indexPath.section==3) {
        return 150;
    }
    

    
    return 50;
}


@end
