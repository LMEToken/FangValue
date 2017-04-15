//
//  APickerView.h
//  TestApplication
//
//  Created by 潘鸿吉 on 13-8-26.
//  Copyright (c) 2013年 潘鸿吉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class APickerView;
@protocol APickerViewDelegate <NSObject>
@optional
- (void) pickerViewStartAnimationFinish : (APickerView*) aPickerView;
- (void) pickerViewEndAnimationFinish : (APickerView*) aPickerView;
- (void) pickerViewSelectObject : (id) object index : (NSInteger) index;
- (void) pickerview:(APickerView*)view SelectObject : (id) object index : (NSInteger) index;
@end

@interface APickerView : UIView <UIPickerViewDataSource , UIPickerViewDelegate>
{
    UIToolbar       *toolBar;
    UIPickerView    *myPickerView;
    NSArray         *dataArray;
    BOOL            LandScape;
}
@property (nonatomic , assign) UIPickerView    *myPickerView;
@property (nonatomic , retain) id <APickerViewDelegate> delegate;

- (id) initWithData : (NSArray *) data;
- (id) initWithData:(NSArray *)data :(BOOL)isLandScape;
- (void) setSelectRow : (NSInteger) row inComponent : (NSInteger) component animated : (BOOL) animated;
@end
