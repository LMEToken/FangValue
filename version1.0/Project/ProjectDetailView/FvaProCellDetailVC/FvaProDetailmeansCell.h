//
//  FvaProDetailmeansCell.h
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageButton.h"
#import "FangChuangInsiderViewController.h"
@interface FvaProDetailmeansCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *worlbt;
@property (weak, nonatomic) IBOutlet UIButton *worlbt2;
@property (weak, nonatomic) IBOutlet UIButton *worlbt3;
- (IBAction)worlbt1:(UIButton *)sender;

- (IBAction)worlbt2:(UIButton *)sender;

- (IBAction)worlbt3:(UIButton *)sender;



@end
