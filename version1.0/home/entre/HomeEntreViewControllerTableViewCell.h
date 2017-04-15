//
//  HomeEntreViewControllerTableViewCell.h
//  FangChuang
//
//  Created by chenlihua on 14-10-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeEntreViewControllerTableViewCell : UITableViewCell
{
    UIImageView *arrowImage;
    UIImageView *lineView;
}
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;


@end
