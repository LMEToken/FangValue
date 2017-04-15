//
//  FvaproDetailImageCell.h
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FangChuangInsiderViewController.h"
@interface FvaproDetailImageCell : UITableViewCell
{
    NSArray *imagearr;
    NSArray *lableaarr;
    NSInteger changeindex;
}
@property (weak, nonatomic) IBOutlet UIButton *heradbt;
@property (weak, nonatomic) IBOutlet UILabel *heradlabe;
@property (weak, nonatomic) IBOutlet UIButton *heradbt2;
@property (weak, nonatomic) IBOutlet UILabel *heradbt2labe;
@property (weak, nonatomic) IBOutlet UIButton *heradbt3;
@property (weak, nonatomic) IBOutlet UILabel *heradbt3labe;
@property (weak, nonatomic) IBOutlet UIButton *heradbt4;
@property (weak, nonatomic) IBOutlet UILabel *heradbt4labe;


@end
