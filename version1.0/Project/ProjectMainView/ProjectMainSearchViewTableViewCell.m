//
//  ProjectMainSearchViewTableViewCell.m
//  FangChuang
//
//  Created by chenlihua on 14-9-13.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//


//筛选的cell

#import "ProjectMainSearchViewTableViewCell.h"


@implementation ProjectMainSearchViewTableViewCell

@synthesize headImageView;
@synthesize nameLabel;
@synthesize contentLabel;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        if (!headImageView) {
            headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 30, 30)];
            headImageView.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:headImageView];
        }
        
        if (!nameLabel) {
            nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(headImageView.frame.origin.x+headImageView.frame.size.width+10, 23, 60, 15)];
            nameLabel.backgroundColor=[UIColor clearColor];
            nameLabel.font=[UIFont fontWithName:KUIFont size:13];
            nameLabel.textColor=[UIColor grayColor];
            [self.contentView addSubview:nameLabel];

        }
        
        if (!contentLabel) {
            contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+105, 25, 75, 13)];
            contentLabel.backgroundColor=[UIColor clearColor];
            contentLabel.font=[UIFont fontWithName:KUIFont size:11];
            contentLabel.textColor=[UIColor grayColor];
            contentLabel.text=@"5000万以上";
            [self.contentView addSubview:contentLabel];
        }
        
        if (!arrowImage) {
            arrowImage=[[UIImageView alloc]initWithFrame:CGRectMake(contentLabel.frame.origin.x+contentLabel.frame.size.width, 25, 8, 13)];
            arrowImage.image=[UIImage imageNamed:@"project_search_arrow"];
            arrowImage.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:arrowImage];
        }
        
        if (!lineView) {
            lineView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 51.5, 286, 0.5)];
            lineView.image=[UIImage imageNamed:@"project-main-cell-line"];
            [self.contentView addSubview:lineView];

        }
       
        
    }
    return self;
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
