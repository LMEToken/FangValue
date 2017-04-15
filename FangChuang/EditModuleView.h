//
//  EditModuleView.h
//  FangChuang
//
//  Created by omni on 14-4-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditModuleView : UIView
{
    UIImageView* backImageView;
}

@property (nonatomic , strong) NSString* titleColor;
@property (nonatomic , strong) NSString* contentColor;
@property (nonatomic , strong) NSArray* titleArray;
@property (nonatomic , strong) NSArray* contentArray;


- (id)initWithFrame:(CGRect)frame
         titleArray:(NSArray*)tlArray
       contentArray:(NSArray*)ctArray
         titleColor:(NSString*)tlColor
       contentColor:(NSString*)ctColor;


- (void)setDataWithArray:(NSArray*)array;

@end
