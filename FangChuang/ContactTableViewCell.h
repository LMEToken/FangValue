//
//  ContactTableViewCell.h
//  FangChuang
//
//  Created by omni on 14-4-9.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheImageView.h"
#import "FangChuangInsiderViewController.h"
@interface ContactTableViewCell : UITableViewCell

//2014.06.12 chenlihua 修改图片缓存的方式
//@property (nonatomic,strong) CacheImageView *headView;
@property(nonatomic,strong) UIImageView *headView;

@property (nonatomic,strong) UILabel *xingmlab;
@end
