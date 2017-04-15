//
//  SingleLineEditableModule.h
//  FangChuang
//
//  Created by omni on 14-4-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@interface SingleLineEditableModule : UIView
{
    UIImageView* backImageView;
}
@property (nonatomic , strong) NSString* titleStr;
@property (nonatomic, strong) HPGrowingTextView* textView;
- (id)initWithFrame:(CGRect)frame WithTitle:(NSString*)title;

- (id)initWithFrame:(CGRect)frame WithTitle:(NSString*)title WithTitleColor:(UIColor*)color;

@end
