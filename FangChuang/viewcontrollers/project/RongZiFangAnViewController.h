//
//  RongZiFangAnViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface RongZiFangAnViewController : ParentViewController
{
    UILabel *rongZiJinELab;
    UILabel *rongZiFangShiLab;
    UILabel *guZhiFangAnLab;
    UILabel *tuiChuFangShiLab;
    
    NSString *rzString;
    NSString *rzfsString;
    NSString *gzfsString;
    NSString *tcfsString;
    
    NSDictionary *dataDic;
}
@property (nonatomic,retain) NSString *proid;
- (void)reloadWithText:(NSString*)text1 Text:(NSString*)text2 Text:(NSString*)text3 Text:(NSString*)text4;

@end
