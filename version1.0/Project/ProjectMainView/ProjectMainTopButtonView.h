//
//  ProjectMainTopButtonView.h
//  FangChuang
//
//  Created by chenlihua on 14-9-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FangChuangInsiderViewController.h"
@class ProjectMainTopButtonView;
@protocol ProjectMainTopButtonViewDelegate <NSObject>
@required

- (void)buttonViewSelectIndex:(int)index buttonView:(ProjectMainTopButtonView *)view;

@end

@interface ProjectMainTopButtonView : UIView
{
    int currentIndex;
}
@property (nonatomic , assign)id<ProjectMainTopButtonViewDelegate> delegate;

- (id) initWithFrame:(CGRect)frame delegate:(id)delegate;
- (id) initWithFrame:(CGRect)frame delegate:(id)delegate titles:(NSArray*)array;

@end
