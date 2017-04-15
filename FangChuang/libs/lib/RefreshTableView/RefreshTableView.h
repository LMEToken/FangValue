//
//  RefreshTableView.h
//  cacheView
//
//  Created by 潘鸿吉 on 13-3-29.
//  Copyright (c) 2013年 潘鸿吉. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEGREE_2_RADIAN(x)  ( (x) * (M_PI) / (180) )

typedef NS_ENUM(NSInteger, RefreshTabelViewState) {
    RefreshTabelViewHeadStateNormal = 1,        //普通
    RefreshTabelViewHeadStateWillRefresh = 2,   //即将刷新
    RefreshTabelViewHeadStateRefreshing = 3,       //正在刷新
    RefreshTabelViewHeadStateDidRefresh = 4,    //刷新结束
    RefreshTabelViewFootStateNormal = /*5*/RefreshTabelViewHeadStateNormal,        //普通
    RefreshTabelViewFootStateAddmoreing = 6,       //正在刷新
};

//typedef NS_ENUM(NSInteger, RefreshTabelViewFootState) {
//    RefreshTabelViewFootStateNormal = 11,        //普通
//    RefreshTabelViewFootStateAddmoreing = 12,       //正在刷新
//};

@protocol RefreshTabelViewDelegate <NSObject>

@required//必选
- (CGFloat)RefreshTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)RefreshTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol RefreshTabelViewDataSource <NSObject>

@required//必选
- (NSInteger)RefreshTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)RefreshTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional//可选
- (NSInteger)RefreshTableViewNumberOfSectionsInTableView:(UITableView *)tableView;// Default is 1 if not implemented

- (void) RefreshTableViewRefreshDatas;

- (void) RefreshTableViewAddDatas;

@end

@interface RefreshTableView : UIView <UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate>
{
    UIImageView      *headView;
    
    UILabel *headTitleLabel;
    UITableView *myTableView;
    UILabel *headTimeLabel;
    NSMutableString *refreshTimeString;
    
    
    UIImageView *arrowImageView;
    UIActivityIndicatorView *aiView;
    UIActivityIndicatorView *addAiView;
    UILabel *addLabel;
    
    int     state;
    
    NSMutableDictionary *headTitleDic;
    NSMutableDictionary *footTitleDic;
    
//    int     page;
    
}


@property (nonatomic , retain) id <RefreshTabelViewDelegate> delegate;
@property (nonatomic , retain) id <RefreshTabelViewDataSource> dataSource;
@property (nonatomic , readonly) int page;

- (id)initWithFrame:(CGRect)frame tableViewSytle : (UITableViewStyle) _style;
- (void) RefreshTableViewLoadFinish;
- (void) RefreshTableViewAddFinish;


#pragma mark 设置head文字
- (void) setHeadViewLabelText : (NSString*) _text forState : (RefreshTabelViewState) _state;

#pragma mark 设置foot文字
- (void) setFootViewLabelText : (NSString*) _text forState : (RefreshTabelViewState) _state;

#pragma mark 设置headView背景
- (void) setHeadViewBackgroundImage : (UIImage*) _image;

#pragma mark 设置headTime文字
- (void) setHeadViewTimeLabelText : (NSString*) _text;

@end
