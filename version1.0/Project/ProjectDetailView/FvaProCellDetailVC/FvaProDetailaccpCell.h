//
//  FvaProDetailaccpCell.h
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FangChuangInsiderViewController.h"
@interface FvaProDetailaccpCell : UITableViewCell
{
    NSString *address;
}
@property (weak, nonatomic) IBOutlet UIButton *acppadress;
@property (weak, nonatomic) IBOutlet UIButton *allpeonum;
- (IBAction)acppbt:(UIButton *)sender;

@end
