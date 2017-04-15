//
//  FvaMecell.h
//  FangChuang
//
//  Created by weiping on 14-9-23.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FangChuangInsiderViewController.h"
@interface FvaMecell : UITableViewCell
@property (nonatomic,strong) NSString *imagename;
@property  (nonatomic,strong) UIImageView *rightimage;
@property  (nonatomic,strong) UILabel *leftlable;
@property (nonatomic,strong) UIImageView *cellline;
@end
