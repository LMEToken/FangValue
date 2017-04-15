//
//  ProjectFinanceTopButtonView.h
//  FangChuang
//
//  Created by chenlihua on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FangChuangInsiderViewController.h"
@class ProjectFinanceTopButtonView;
@protocol ProjectFinanceTopButtonViewDelegate <NSObject>
@required

- (void)buttonViewSelectIndex:(int)index buttonView:(ProjectFinanceTopButtonView *)view;

@end


@interface ProjectFinanceTopButtonView : UIView
{
    int currentIndex;
}
@property (nonatomic , assign)id<ProjectFinanceTopButtonViewDelegate> delegate;

- (id) initWithFrame:(CGRect)frame delegate:(id)delegate;
- (id) initWithFrame:(CGRect)frame delegate:(id)delegate titles:(NSArray*)array;


@end
