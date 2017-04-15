//
//  FaFinancierWelcomeItemCell.h
//  FangChuang
//
//  Created by omni on 14-3-28.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheImageView.h"

@interface FaFinancierWelcomeItemCell : UITableViewCell

//2014.06.12 chenlihua 修改图片的缓存方式
//@property (nonatomic,strong) CacheImageView* avatar;

@property (nonatomic,strong) UIImageView* avatar;

@property (nonatomic,strong) UILabel* titleLab;
@property (nonatomic,strong) UILabel* subTitleLab;
@property (nonatomic,strong) UIImageView* unReadImageV;
@property (nonatomic,strong) UILabel *unReadLabel;
@property(nonatomic,strong)UIImageView *bcImgV;
//2014.05.07 chenlihua 方创首页左边滑动增加置顶和删除按钮
@property(nonatomic,strong) UIButton *stickButton;
@property(nonatomic,strong) UIButton *deleteButton;
@property (nonatomic , strong)UILabel *timelable;

@property (nonatomic,strong) UILabel *peoplecount;

@end
