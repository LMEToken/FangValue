//
//  ProjectMainTableViewCell.m
//  FangChuang
//
//  Created by chenlihua on 14-9-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//项目主界面的cell

#import "ProjectMainTableViewCell.h"

@implementation ProjectMainTableViewCell

@synthesize headImageView;
@synthesize attentionLabel;
@synthesize projectTitleLabel;
@synthesize contentLabel;
@synthesize placeLabel;
@synthesize propertyArray;
@synthesize meetContentLabel;
@synthesize funsContentLabel;
@synthesize lookContentLabel;
@synthesize teamMemberConentLabel;




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //头像
        if (!headImageView) {
            headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 17, 55, 55)];
            headImageView.backgroundColor=[UIColor clearColor];
          //  headImageView.image=[UIImage imageNamed:@"project-main-headImage"];
            [self.contentView addSubview:headImageView];
        }
        
        //已关注
        if (!attentionLabel) {
            attentionLabel=[[UILabel alloc]initWithFrame:CGRectMake(11, headImageView.frame.origin.y+headImageView.frame.size.height+3, 53, 13.5)];
            attentionLabel.backgroundColor=[UIColor colorWithRed:123/255.0 green:125/255.0 blue:129/255.0 alpha:1.0];
          //  attentionLabel.text=@"已关注";
            attentionLabel.textColor=[UIColor whiteColor];
            attentionLabel.textAlignment=NSTextAlignmentCenter;
            attentionLabel.font=[UIFont fontWithName:KUIFont size:9];
            [self.contentView addSubview:attentionLabel];

        }
        
        
        //项目标题
        if (!projectTitleLabel) {
            projectTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+55+8, 18, 220, 20)];
          //  projectTitleLabel.text=@"云 SPACE";
            projectTitleLabel.font=[UIFont fontWithName:KUIFont size:13];
            projectTitleLabel.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:projectTitleLabel];

        }
        
        
        //内容
        if (!contentLabel) {
            contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(projectTitleLabel.frame.origin.x, projectTitleLabel.frame.origin.y+projectTitleLabel.frame.size.height+2, projectTitleLabel.frame.size.width, 12)];
           // contentLabel.text=@"打造活动场地的Airbnb";
            contentLabel.font=[UIFont fontWithName:KUIFont size:10];
            contentLabel.backgroundColor=[UIColor clearColor];
            contentLabel.textColor=[UIColor grayColor];
            [self.contentView addSubview:contentLabel];

        }
        
        
        //地点
        if (!placeLabel) {
            placeLabel=[[UILabel alloc]initWithFrame:CGRectMake(contentLabel.frame.origin.x+1, contentLabel.frame.origin.y+contentLabel.frame.size.height+6, 58, 10)];
         //   placeLabel.text=@"上海，静安";
            placeLabel.font=[UIFont fontWithName:KUIFont size:10];
            placeLabel.backgroundColor=[UIColor clearColor];
            placeLabel.textColor=[UIColor grayColor];
            [self.contentView addSubview:placeLabel];

        }
        
        //竖线
               
        if (!verticalLineView) {
            verticalLineView=[[UIImageView alloc]initWithFrame:CGRectMake(placeLabel.frame.origin.x+placeLabel.frame.size.width-3, placeLabel.frame.origin.y+1, 1,9)];
            verticalLineView.image=[UIImage imageNamed:@"project-main-verticalLine"];
            [self.contentView addSubview:verticalLineView];
        }


        //TMT 科技 消费
       // [self propertyWith:@"能源、矿产、农业食品、先进制造业、医药、医疗设备"];
        
        
        //横线
        if (!lineView) {
            lineView=[[UIImageView alloc]initWithFrame:CGRectMake(placeLabel.frame.origin.x, placeLabel.frame.origin.y+placeLabel.frame.size.height+4, 185, 0.5)];
            lineView.image=[UIImage imageNamed:@"project-main-duan-line"];
            [self.contentView addSubview:lineView];
        }
        
        
        //约见Title
        if (!meetTitleLabel) {
            meetTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(lineView.frame.origin.x, lineView.frame.origin.y+5, 24, 12)];
            meetTitleLabel.backgroundColor=[UIColor clearColor];
            meetTitleLabel.text=@"约见:";
            meetTitleLabel.font=[UIFont fontWithName:KUIFont size:9];
            meetTitleLabel.textColor=[UIColor grayColor];
            [self.contentView addSubview:meetTitleLabel];
        }
       
        
        //约见内容
        if (!meetContentLabel) {
            meetContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(meetTitleLabel.frame.origin.x+meetTitleLabel.frame.size.width, lineView.frame.origin.y+5, 20, 12)];
            meetContentLabel.backgroundColor=[UIColor clearColor];
            meetContentLabel.font=[UIFont fontWithName:KUIFont size:9];
            meetContentLabel.textColor=[UIColor grayColor];
          //  meetContentLabel.text=@"8";
            [self.contentView addSubview:meetContentLabel];

        }
        
      
        //粉丝Title
        if (!funsTitleLabel) {
            funsTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(meetContentLabel.frame.origin.x+meetContentLabel.frame.size.width, lineView.frame.origin.y+5, 24, 12)];
            funsTitleLabel.backgroundColor=[UIColor clearColor];
            funsTitleLabel.text=@"粉丝:";
            funsTitleLabel.font=[UIFont fontWithName:KUIFont size:9];
            funsTitleLabel.textColor=[UIColor grayColor];
            [self.contentView addSubview:funsTitleLabel];

        }
        
        //粉丝内容
        if (!funsContentLabel) {
            funsContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(funsTitleLabel.frame.origin.x+funsTitleLabel.frame.size.width, lineView.frame.origin.y+5, 20, 12)];
            funsContentLabel.backgroundColor=[UIColor clearColor];
            funsContentLabel.font=[UIFont fontWithName:KUIFont size:9];
            funsContentLabel.textColor=[UIColor grayColor];
         //   funsContentLabel.text=@"20";
            [self.contentView addSubview:funsContentLabel];
        }
        
        

        //浏览Title
        if (!lookTitleLabel) {
            lookTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(funsContentLabel.frame.origin.x+funsContentLabel.frame.size.width, lineView.frame.origin.y+5, 24, 12)];
            lookTitleLabel.backgroundColor=[UIColor clearColor];
            lookTitleLabel.text=@"浏览:";
            lookTitleLabel.font=[UIFont fontWithName:KUIFont size:9];
            lookTitleLabel.textColor=[UIColor grayColor];
            [self.contentView addSubview:lookTitleLabel];
        }
        
        
        //浏览内容
        if (!lookContentLabel) {
            lookContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(lookTitleLabel.frame.origin.x+lookTitleLabel.frame.size.width, lineView.frame.origin.y+5, 30, 12)];
            lookContentLabel.backgroundColor=[UIColor clearColor];
            lookContentLabel.font=[UIFont fontWithName:KUIFont size:9];
            lookContentLabel.textColor=[UIColor grayColor];
          //  lookContentLabel.text=@"366";
            [self.contentView addSubview:lookContentLabel];
        }
        
        
        //团队人数title
        if (!teamMemberTitleLabel) {
            teamMemberTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(lookContentLabel.frame.origin.x+lookContentLabel.frame.size.width, lineView.frame.origin.y+5, 40, 12)];
            teamMemberTitleLabel.backgroundColor=[UIColor clearColor];
            teamMemberTitleLabel.text=@"团队人数:";
            teamMemberTitleLabel.textColor=[UIColor grayColor];
            teamMemberTitleLabel.font=[UIFont fontWithName:KUIFont size:9];
            [self.contentView addSubview:teamMemberTitleLabel];
        }
        
        
        //团队人数内容
        if (!teamMemberConentLabel) {
            teamMemberConentLabel=[[UILabel alloc]initWithFrame:CGRectMake(teamMemberTitleLabel.frame.origin.x+teamMemberTitleLabel.frame.size.width, lineView.frame.origin.y+5, 40, 12)];
            teamMemberConentLabel.backgroundColor=[UIColor clearColor];
            teamMemberConentLabel.font=[UIFont fontWithName:KUIFont size:9];
            teamMemberConentLabel.textColor=[UIColor grayColor];
           // teamMemberConentLabel.text=@"30";
            [self.contentView addSubview:teamMemberConentLabel];

        }
       
        //单元格的线
        if (!cellLineView) {
            cellLineView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 99.5, 286, 0.5)];
            cellLineView.image=[UIImage imageNamed:@"project-main-cell-line"];
            [self.contentView addSubview:cellLineView];

        }
        
    }
    return self;
}
#pragma -mark -functions
-(void)propertyWith:(NSString *)propertyString
{
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
                    
                    UILabel *propertyLabel=[[UILabel alloc]initWithFrame:CGRectMake(verticalLineView.frame.origin.x+verticalLineView.frame.size.width+7+32*i, placeLabel.frame.origin.y-3, 27, 14)];
                    if (i==0) {
                        propertyLabel.backgroundColor=[UIColor colorWithRed:238/255.0 green:205/255.0 blue:93/255.0 alpha:1.0];
                        
                    }else if (i==1){
                        propertyLabel.backgroundColor=[UIColor colorWithRed:164/255.0 green:215/255.0 blue:35/255.0 alpha:1.0];
                    }else if (i==2){
                        propertyLabel.backgroundColor=[UIColor colorWithRed:84/255.0 green:186/255.0 blue:190/255.0 alpha:1.0];
                    }
                    propertyLabel.text=[propertyArray objectAtIndex:i];
                    propertyLabel.textColor=[UIColor whiteColor];
                    propertyLabel.textAlignment=NSTextAlignmentCenter;
                    propertyLabel.font=[UIFont fontWithName:KUIFont size:9];
                    [self.contentView addSubview:propertyLabel];
                    
                }
                
            }else if(propertyArray.count>3){
                
                for (int i=0; i<propertyArray.count; i++) {
                    
                    UILabel *propertyLabel=[[UILabel alloc]initWithFrame:CGRectMake(verticalLineView.frame.origin.x+verticalLineView.frame.size.width+7+32*i, placeLabel.frame.origin.y-3, 27, 14)];
                    if (i==0) {
                        propertyLabel.backgroundColor=[UIColor colorWithRed:238/255.0 green:205/255.0 blue:93/255.0 alpha:1.0];
                        
                    }else if (i==1){
                        propertyLabel.backgroundColor=[UIColor colorWithRed:164/255.0 green:215/255.0 blue:35/255.0 alpha:1.0];
                    }else if (i==2){
                        propertyLabel.backgroundColor=[UIColor colorWithRed:86/255.0 green:186/255.0 blue:190/255.0 alpha:1.0];
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


@end
