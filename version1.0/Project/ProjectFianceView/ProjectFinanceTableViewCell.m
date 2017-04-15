//
//  ProjectFinanceTableViewCell.m
//  FangChuang
//
//  Created by chenlihua on 14-9-18.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//融资进程cell
#import "ProjectFinanceTableViewCell.h"

@implementation ProjectFinanceTableViewCell
@synthesize headImageView;
@synthesize detailLabel;
@synthesize TitleLabel;
@synthesize propertyArray;
@synthesize contactContentLabel;
@synthesize stateContentLabel;
@synthesize lastContactContentLabel;
@synthesize psContentLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //头像
        if (!headImageView) {
            headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 65, 65)];
            headImageView.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:headImageView];
        }
        
        //详情
        if (!detailLabel) {
            detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, headImageView.frame.origin.y+headImageView.frame.size.height+5, 65, 16)];
            detailLabel.text=@"详 情";
            detailLabel.backgroundColor=[UIColor colorWithRed:77/255.0 green:76/255.0 blue:74/255.0 alpha:1.0];
            detailLabel.textAlignment=NSTextAlignmentCenter;
            detailLabel.font=[UIFont fontWithName:KUIFont size:10];
            detailLabel.textColor=[UIColor whiteColor];
            [self.contentView addSubview:detailLabel];
        }
        //题目
        if (!TitleLabel) {
            TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15+65+30, 10, 60, 15)];
            TitleLabel.font=[UIFont fontWithName:KUIFont size:13];
            TitleLabel.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:TitleLabel];
            
        }
        
         //TMT 科技 消费
      //  [self propertyWith:@"能源、矿产、农业食品、先进制造业、医药、医疗设备"];
        
        
        //联系人
        if (!contactLabel) {
            contactLabel=[[UILabel alloc]initWithFrame:CGRectMake(TitleLabel.frame.origin.x, TitleLabel.frame.origin.y+TitleLabel.frame.size.height+8, 30, 15)];
            contactLabel.text=@"联系人:";
            contactLabel.textColor=[UIColor grayColor];
            contactLabel.font=[UIFont fontWithName:KUIFont size:9];
            contactLabel.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:contactLabel];
        }

        //联系人内容
        if (!contactContentLabel) {
            contactContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(contactLabel.frame.origin.x+contactLabel.frame.size.width+5, contactLabel.frame.origin.y, 30, 15)];
         //   contactContentLabel.text=@"康梁";
            contactContentLabel.textColor=[UIColor grayColor];
            contactContentLabel.font=[UIFont fontWithName:KUIFont size:9];
            contactContentLabel.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:contactContentLabel];
        }

        //竖线
        if (!verticalLine) {
            verticalLine=[[UIImageView alloc]initWithFrame:CGRectMake(contactContentLabel.frame.origin.x+contactContentLabel.frame.size.width+3, contactContentLabel.frame.origin.y+2, 1,10)];
            verticalLine.image=[UIImage imageNamed:@"project-finance-vertical-line"];
            [self.contentView addSubview:verticalLine];
        }

        //状态
        if (!stateLabel) {
            stateLabel=[[UILabel alloc]initWithFrame:CGRectMake(verticalLine.frame.origin.x+verticalLine.frame.size.width+5, contactLabel.frame.origin.y, 25, 15)];
            stateLabel.text=@"状态:";
            stateLabel.textColor=[UIColor grayColor];
            stateLabel.font=[UIFont fontWithName:KUIFont size:9];
            stateLabel.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:stateLabel];
        }
        
        //状态内容
        if (!stateContentLabel) {
            stateContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(stateLabel.frame.origin.x+stateLabel.frame.size.width+5, stateLabel.frame.origin.y, 60, 15)];
          //  stateContentLabel.text=@"立项中  25%";
            stateContentLabel.textColor=[UIColor grayColor];
            stateContentLabel.font=[UIFont fontWithName:KUIFont size:9];
            stateContentLabel.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:stateContentLabel];
        }
        
        //上次联系
        if (!lastContactLabel) {
            lastContactLabel=[[UILabel alloc]initWithFrame:CGRectMake(contactLabel.frame.origin.x, contactLabel.frame.origin.y+contactLabel.frame.size.height+8, 40, 15)];
            lastContactLabel.text=@"上次联系:";
            lastContactLabel.textColor=[UIColor grayColor];
            lastContactLabel.font=[UIFont fontWithName:KUIFont size:9];
            lastContactLabel.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:lastContactLabel];
        }
        
        //上次联系内容
        if (!lastContactContentLabel) {
            lastContactContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(lastContactLabel.frame.origin.x+lastContactLabel.frame.size.width+5, lastContactLabel.frame.origin.y, 110, 15)];
          //  lastContactContentLabel.text=@"2014/08/17";
            lastContactContentLabel.textColor=[UIColor grayColor];
            lastContactContentLabel.font=[UIFont fontWithName:KUIFont size:9];
            lastContactContentLabel.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:lastContactContentLabel];
        }

        //横线
        if (!horizontalLine) {
            horizontalLine=[[UIImageView alloc]initWithFrame:CGRectMake(lastContactLabel.frame.origin.x,lastContactLabel.frame.origin.y+lastContactLabel.frame.size.height+5, 185, 0.5)];
            horizontalLine.image=[UIImage imageNamed:@"project-finance-horizonLine"];
            [self.contentView addSubview:horizontalLine];
        }

        //ps
        if (!psLabel) {
            psLabel=[[UILabel alloc]initWithFrame:CGRectMake(horizontalLine.frame.origin.x, horizontalLine.frame.origin.y+horizontalLine.frame.size.height+5, 20, 15)];
            psLabel.text=@"ps:";
            psLabel.textColor=[UIColor grayColor];
            psLabel.font=[UIFont fontWithName:KUIFont size:8];
            psLabel.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:psLabel];
        }
        
        //ps系内容
        if (!psContentLabel) {
            psContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(psLabel.frame.origin.x+psLabel.frame.size.width+5, psLabel.frame.origin.y, 140, 15)];
         //   psContentLabel.text=@"项目偏早期，方创感兴趣";
            psContentLabel.textColor=[UIColor grayColor];
            psContentLabel.font=[UIFont fontWithName:KUIFont size:8];
            psContentLabel.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:psContentLabel];
        }

        //单元格的线
        if (!cellLine) {
            cellLine=[[UIImageView alloc]initWithFrame:CGRectMake(15, 105.5,286 , 0.5)];
            cellLine.image=[UIImage imageNamed:@"project-finance-cell-line"];
            [self.contentView addSubview:cellLine];
            
        }


    }
    return self;
}

-(void)propertyWith:(NSString *)propertyString
{
    //TMT 科技 消费
    // propertyString=@"TMT、 科技 、消费";
    //propertyString=@"能源、矿产、农业食品、先进制造业、医药、医疗设备";
    NSLog(@"--cell--propertyString--%@",propertyString);
    if (propertyString.length==0) {
        ;
    }else{
        if (!propertyArray) {
            propertyArray=[[NSMutableArray alloc]init];
        }
        propertyArray=[[NSMutableArray alloc]initWithArray:[propertyString componentsSeparatedByString:@","]];
        NSLog(@"---propertyArray-%@--",propertyArray);
        NSLog(@"--propertyArray.count-%i",propertyArray.count);
        if (propertyArray.count==0) {
            ;
        }else{
            if (propertyArray.count<3||propertyArray.count==3) {
                
                for (int i=0; i<propertyArray.count; i++) {
                    
                    UILabel *propertyLabel=[[UILabel alloc]initWithFrame:CGRectMake(TitleLabel.frame.origin.x+TitleLabel.frame.size.width+12+32*i, TitleLabel.frame.origin.y, 27, 14)];
                    if (i==0) {
                        propertyLabel.backgroundColor=[UIColor colorWithRed:238/255.0 green:205/255.0 blue:93/255.0 alpha:1.0];
                        
                    }else if (i==1){
                        propertyLabel.backgroundColor=[UIColor colorWithRed:164/255.0 green:215/255.0 blue:35/255.0 alpha:1.0];
                    }else if (i==2){
                        propertyLabel.backgroundColor=[UIColor colorWithRed:255/255.0 green:0/255.0 blue:150/255.0 alpha:1.0];
                    }
                    propertyLabel.text=[propertyArray objectAtIndex:i];
                    propertyLabel.textColor=[UIColor whiteColor];
                    propertyLabel.textAlignment=NSTextAlignmentCenter;
                    propertyLabel.font=[UIFont fontWithName:KUIFont size:9];
                    [self.contentView addSubview:propertyLabel];
                    
                }
                
            }else if(propertyArray.count>3){
                
                for (int i=0; i<propertyArray.count; i++) {
                    
                    UILabel *propertyLabel=[[UILabel alloc]initWithFrame:CGRectMake(TitleLabel.frame.origin.x+TitleLabel.frame.size.width+12+32*i, TitleLabel.frame.origin.y, 27, 14)];
                    if (i==0) {
                        propertyLabel.backgroundColor=[UIColor colorWithRed:238/255.0 green:205/255.0 blue:93/255.0 alpha:1.0];
                        
                    }else if (i==1){
                        propertyLabel.backgroundColor=[UIColor colorWithRed:164/255.0 green:215/255.0 blue:35/255.0 alpha:1.0];
                    }else if (i==2){
                        propertyLabel.backgroundColor=[UIColor colorWithRed:255/255.0 green:0/255.0 blue:150/255.0 alpha:1.0];
                    }
                    propertyLabel.text=[propertyArray objectAtIndex:i];
                    propertyLabel.textColor=[UIColor whiteColor];
                    propertyLabel.textAlignment=NSTextAlignmentCenter;
                    propertyLabel.font=[UIFont fontWithName:KUIFont size:9];
                    [self.contentView addSubview:propertyLabel];
                    
                }
            }
        }
    }
    

}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
