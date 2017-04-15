//
//  ModuleView.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-4.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleView : UIView
{
    UIImageView* backImageView;
    
    
}
@property (nonatomic , retain) NSString* titleColor;
@property (nonatomic , retain) NSString* contentColor;
@property (nonatomic , retain) NSArray* titleArray;
@property (nonatomic , retain) NSArray* contentArray;
/*
 
 init
 */
- (id)initWithFrame:(CGRect)frame
         titleArray:(NSArray*)tlArray
       contentArray:(NSArray*)ctArray
         titleColor:(NSString*)tlColor
       contentColor:(NSString*)ctColor;


/*
 
 reload data;
 */

- (void)setDataWithArray:(NSArray*)array;

@end
