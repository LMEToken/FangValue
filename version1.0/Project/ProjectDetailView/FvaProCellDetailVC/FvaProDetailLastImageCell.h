//
//  FvaProDetailLastImageCell.h
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageButton.h"
#import "FangChuangInsiderViewController.h"
@interface FvaProDetailLastImageCell : UITableViewCell
@property (nonatomic,strong)UILabel *heradlable;

@property (weak, nonatomic) IBOutlet ImageButton *Crowdbt1;

@property (weak, nonatomic) IBOutlet UIButton *Crowdbt2;

@property (weak, nonatomic) IBOutlet UIButton *Crowdbt3;
@end
