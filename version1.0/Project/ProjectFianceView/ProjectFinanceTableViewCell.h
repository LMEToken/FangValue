//
//  ProjectFinanceTableViewCell.h
//  FangChuang
//
//  Created by chenlihua on 14-9-18.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FangChuangInsiderViewController.h"
@interface ProjectFinanceTableViewCell : UITableViewCell
{
    UILabel *contactLabel;
    UILabel *stateLabel;
    UIImageView *verticalLine;
    UILabel *lastContactLabel;
    UIImageView *horizontalLine;
    UILabel *psLabel;
    UIImageView *cellLine;
}
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *TitleLabel;
@property (nonatomic,strong) NSMutableArray *propertyArray;
@property (nonatomic,strong) UILabel *contactContentLabel;
@property (nonatomic,strong) UILabel *stateContentLabel;
@property (nonatomic,strong) UILabel *lastContactContentLabel;
@property (nonatomic,strong) UILabel *psContentLabel;

-(void)propertyWith:(NSString *)propertyString;

@end
