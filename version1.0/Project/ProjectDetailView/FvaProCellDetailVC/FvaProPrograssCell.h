//
//  FvaProPrograssCell.h
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FangChuangInsiderViewController.h"
@interface FvaProPrograssCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISlider *prograse;
@property (weak, nonatomic) IBOutlet UIButton *graselabe;

- (IBAction)DetailBT:(UIButton *)sender;

@end
