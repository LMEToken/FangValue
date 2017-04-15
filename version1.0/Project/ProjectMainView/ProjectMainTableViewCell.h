//
//  ProjectMainTableViewCell.h
//  FangChuang
//
//  Created by chenlihua on 14-9-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FangChuangInsiderViewController.h"
@interface ProjectMainTableViewCell : UITableViewCell
{
    UIImageView *lineView;
    UIImageView *verticalLineView;
    UILabel *meetTitleLabel;
    UILabel *funsTitleLabel;
    UILabel *lookTitleLabel;
    UILabel *teamMemberTitleLabel;
    UIImageView *cellLineView;
    
    
}

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *attentionLabel;
@property (nonatomic,strong) UILabel *projectTitleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *placeLabel;
@property (nonatomic,strong) NSMutableArray *propertyArray;
@property (nonatomic,strong) UILabel *meetContentLabel;
@property (nonatomic,strong) UILabel *funsContentLabel;
@property (nonatomic,strong) UILabel *lookContentLabel;
@property (nonatomic,strong) UILabel *teamMemberConentLabel;


-(void)propertyWith:(NSString *)propertyString;

@end
