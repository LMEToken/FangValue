//
//  RongZiBianJiViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "RongZiFangAnViewController.h"
@interface RongZiBianJiViewController : ParentViewController<UITextFieldDelegate>
{
    UITextField *rzjeTextField;
    UITextField *rzfsTextField;
    UITextField *gzfaTextField;
    UITextField *tcfsTextField;

//    NSString *rzLable;
//    NSString *rzfsLable;
//    NSString *gzfsLable;
//    NSString *tcfsLable;

}
@property(retain , nonatomic) NSDictionary *dataDic;
@property(assign , nonatomic) id delegate;
//- (id)initValueString:(NSString *)zetext rzfsText:(NSString *)rzfsText gzfaText:(NSString *)gzfa tcfsText:(NSString *)tcfsText;

@end
