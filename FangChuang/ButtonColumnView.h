//
//  ButtonColumnView.h
//  FangChuang
//
//  Created by chenlihua on 14-4-24.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtonColumnView;
@protocol ButtonColumnViewDelegate <NSObject>

@required
- (void)buttonViewSelectIndex:(int)index buttonView:(ButtonColumnView*)view;

@end


@interface ButtonColumnView : UIView
{
    int currentIndex;
}
@property (nonatomic , assign)id<ButtonColumnViewDelegate> delegate;

- (id) initWithFrame:(CGRect)frame delegate:(id)delegate;
- (id) initWithFrame:(CGRect)frame delegate:(id)delegate titles:(NSArray*)array;

//2014.05.27 chenlihua 在方创主页的“方创人”，“项目方”，“投资方”，“对接群”有新消息的时候，要有提示。
@property (nonatomic,retain) UILabel *unGroupLabel;

@end
