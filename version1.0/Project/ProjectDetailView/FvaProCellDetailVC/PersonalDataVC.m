//
//  PersonalDataVC.m
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "PersonalDataVC.h"
#import "UIImageView+WebCache.h"
@interface PersonalDataVC ()

@end

@implementation PersonalDataVC

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
    [self setTitle:@"投资人或创业者详细资料"];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self addTableview];
    [self addfriedview];
    NSLog(@"%@",self.peopleid);
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addfriedview
{
//    NSLog(@"%f",self.contentView.frame.size.height);
    UIView *downview = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height-50, 320, 50)];
    downview.backgroundColor = [UIColor whiteColor];
    UIButton *addbt = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
    [addbt setBackgroundImage:[UIImage imageNamed:@"addfired"] forState:UIControlStateNormal ];
    [addbt addTarget:self action:@selector(addfrieds) forControlEvents: UIControlEventTouchDown];
    [downview addSubview:addbt];
    [self.contentView addSubview:downview];
    
}
- (void)addfrieds
{
    NSLog(@"你申请了加好友");
}
- (void)addTableview
{
    self.PersonTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height-50) style:UITableViewStylePlain];
    //UITableViewStylePlain];
    [self.PersonTableview setDelegate:self];
    [ self.PersonTableview setDataSource:self];
    [self.contentView addSubview:self.PersonTableview];
    
    tableArray = [[NSMutableArray alloc]init];
    //为表单数组添加元素
    [tableArray addObject:[self newSectionArr:0 andRow:1]];
    [tableArray addObject:[self newSectionArr:1 andRow:4]];
    [tableArray addObject:[self newSectionArr:2 andRow:5]];
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
#pragma mark - TableVIewDelegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 return [[tableArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *seectionarr = [NSArray arrayWithObjects:@"签名",@"公司",@"职位",@"邮箱",@"机构信息",nil];
    NSArray * seection3arr= [NSArray arrayWithObjects:@"阶段",@"团队规模",@"融资状态",@"所属领域",@"公司介绍",nil];

     PresonlabelCell *cell = [[PresonlabelCell alloc]init];
    UILabel *rightlable= [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 70, 30)];
    [rightlable  setFont:[UIFont fontWithName:KUIFont size:12]];
      [cell addSubview:rightlable ];
    
    UILabel *leftlable= [[UILabel alloc]initWithFrame:CGRectMake(230, 10, 70, 30)];
    [leftlable  setFont:[UIFont fontWithName:KUIFont size:12]];
    leftlable.text= @"动态数据";
    [cell addSubview:leftlable];

    if (indexPath.row==0&&indexPath.section==0) {
        leftlable.hidden = YES;
        
     rightlable.hidden = YES;
        UIImageView *herdimage = [[UIImageView alloc]initWithFrame:CGRectMake(20  , 10, 60 , 60)];
             [herdimage setImageWithURL:[NSURL URLWithString:[self.peopledic objectForKey:@"picurl2"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
        herdimage.layer.cornerRadius = 10;//设置那个圆角的有多圆
        herdimage.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
        herdimage.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
        herdimage.layer.masksToBounds = YES;
        
        [cell addSubview:herdimage];
        UILabel *heradlable = [[UILabel alloc]initWithFrame:CGRectMake(100  , 10, 60 , 60)];
        heradlable.text = [self.peopledic objectForKey:@"username"];
        [cell addSubview:heradlable];
        
    }
    if (indexPath.section==1) {
        rightlable.text = [seectionarr objectAtIndex:indexPath.row];
    }
    if (indexPath.section==2) {
        rightlable.text = [seection3arr objectAtIndex:indexPath.row];
    }

    if (indexPath.section==2&&indexPath.row==4) {
        
        leftlable.hidden = YES;
        UITextView *conpantext = [[UITextView alloc]init];
        conpantext.text = @"拉拉拉阿拉拉拉阿拉拉拉阿拉拉拉拉拉拉阿拉拉拉阿拉拉拉拉拉阿拉拉拉拉拉拉拉";
        conpantext.frame = CGRectMake(20,30, 280, 120);
        conpantext.userInteractionEnabled = NO;
        [cell addSubview:conpantext];
    }
   return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return @"个人资料";
    }
    if (section==2) {
        return @"机构信息";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==2&&indexPath.row==4) {
        return 130;
    }
    if (indexPath.section ==0) {
        return 80;
    }

    return 50;
}


@end
