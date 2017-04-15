//
//  ButtonView.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ButtonView;
@protocol ButtonViewDelegate <NSObject>

@required
- (void)buttonViewSelectIndex:(int)index buttonView:(ButtonView*)view;

@end

@interface ButtonView : UIView
{
    int currentIndex;
}
@property (nonatomic , assign)id<ButtonViewDelegate> delegate;
- (id) initWithFrame:(CGRect)frame delegate:(id)delegate;
- (id) initWithFrame:(CGRect)frame delegate:(id)delegate titles:(NSArray*)array;
@end
