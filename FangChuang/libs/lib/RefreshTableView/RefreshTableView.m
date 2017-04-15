//
//  RefreshTableView.m
//  cacheView
//
//  Created by 潘鸿吉 on 13-3-29.
//  Copyright (c) 2013年 潘鸿吉. All rights reserved.
//

#import "RefreshTableView.h"

@implementation RefreshTableView

@synthesize delegate , dataSource , page;


- (id)initWithFrame:(CGRect)frame tableViewSytle : (UITableViewStyle) _style
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        page = 1;
        
        headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -80, self.bounds.size.width, 80)];
        [headView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:headView];
        
        headTitleDic = [[NSMutableDictionary alloc] init];
        footTitleDic = [[NSMutableDictionary alloc] init];
        
        headTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, self.bounds.size.width, 30)];
        [headTitleLabel setText:@""];
        [headTitleLabel setTextColor:[UIColor grayColor]];
        [headTitleLabel setBackgroundColor:[UIColor clearColor]];
        [headTitleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16.0f]];
        [headTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [headView addSubview:headTitleLabel];
        
        refreshTimeString = [[NSMutableString alloc] initWithString:@"刷新于"];
        
        headTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, self.bounds.size.width, 30)];
        NSString *cacheTimeString = [self getCacheTime];
        if (cacheTimeString) {
            [headTimeLabel setText:[NSString stringWithFormat:@"%@ %@",refreshTimeString,cacheTimeString]];
        }
        else
        {
            [headTimeLabel setText:@"未刷新"];
        }
        [headTimeLabel setTextColor:[UIColor grayColor]];
        [headTimeLabel setBackgroundColor:[UIColor clearColor]];
        [headTimeLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13.0f]];
        [headTimeLabel setTextAlignment:NSTextAlignmentCenter];
        [headView addSubview:headTimeLabel];
        
        arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 12, 30, 55)];
        arrowImageView.image = [UIImage imageNamed:@"whiteArrow.png"];
        [headView addSubview:arrowImageView];
        
        
        myTableView = [[UITableView alloc] initWithFrame:self.bounds style:_style];
        [myTableView setBackgroundColor:[UIColor clearColor]];
        [myTableView setDelegate:self];
        [myTableView setDataSource:self];
//        [myTableView setEditing:YES];
        [self addSubview:myTableView];
        
        addLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, myTableView.bounds.size.width, myTableView.rowHeight)];
        [addLabel setTextColor:[UIColor grayColor]];
        [addLabel setText:@""];
        [addLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16.0f]];
        [addLabel setTextAlignment:NSTextAlignmentCenter];
        
        addAiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [addAiView setFrame:CGRectMake(20, 0, myTableView.rowHeight, myTableView.rowHeight)];
        
        [self changeState:RefreshTabelViewHeadStateNormal];
    }
    return self;
}

#pragma mark 设置head文字
- (void) setHeadViewLabelText : (NSString*) _text forState : (RefreshTabelViewState) _state
{
    [headTitleDic setObject:_text forKey:[self getKeyForState:_state]];
    if (_state == RefreshTabelViewHeadStateDidRefresh || _state == RefreshTabelViewHeadStateNormal || _state == RefreshTabelViewHeadStateRefreshing || _state == RefreshTabelViewHeadStateWillRefresh) {
        [headTitleLabel setText:_text];
    }
}

#pragma mark 设置foot文字
- (void) setFootViewLabelText : (NSString *)_text forState : (RefreshTabelViewState) _state
{
    [footTitleDic setObject:_text forKey:[self getKeyForState:_state]];
    if (_state == RefreshTabelViewFootStateNormal || _state == RefreshTabelViewFootStateAddmoreing) {
        [addLabel setText:_text];
    }
    
}

#pragma mark 设置headView背景
- (void) setHeadViewBackgroundImage : (UIImage*) _image
{
    [headView setImage:_image];
}

#pragma mark 设置headTime文字
- (void) setHeadViewTimeLabelText : (NSString*) _text
{
    if (_text) {
        if (![_text isEqualToString:@""]) {
            [refreshTimeString setString:_text];
            NSString *cacheTimeString = [self getCacheTime];
            if (cacheTimeString) {
                [headTimeLabel setText:[NSString stringWithFormat:@"%@ %@",refreshTimeString,cacheTimeString]];
            }
            else
            {
                [headTimeLabel setText:@"未刷新"];
            }
        }
    }
    
}

#pragma mark - refresh datas finish
- (void) RefreshTableViewLoadFinish
{
    if (aiView) {
        [aiView removeFromSuperview];
        aiView = nil;
    }
    
    [self changeState:RefreshTabelViewHeadStateDidRefresh];
    page = 1;
    
    
    [arrowImageView setHidden:NO];
    
    NSString *timeString = [self getSystemTime];
    [self saveTime:timeString];
    [headTimeLabel setText:[NSString stringWithFormat:@"%@ %@" ,refreshTimeString, timeString]];
    
    [self performSelector:@selector(finishAnimation) withObject:nil afterDelay:0.3f];
    
    [myTableView reloadData];
}

- (void) RefreshTableViewAddFinish
{
    [addAiView stopAnimating];
    [self changeState:RefreshTabelViewHeadStateNormal];
    page++;
    [myTableView reloadData];
}

- (void) finishAnimation
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
	[myTableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /******************** set headview frame ********************/
    [headView setFrame:CGRectMake(0, myTableView.contentOffset.y*(-1) - headView.bounds.size.height, headView.bounds.size.width, headView.bounds.size.height)];
    
    if (state == RefreshTabelViewHeadStateRefreshing || state == RefreshTabelViewHeadStateDidRefresh || state == RefreshTabelViewFootStateAddmoreing) {
        return;
    }
    
    //下拉
    /******************** animation ********************/
    if (scrollView.contentOffset.y < -80.0f) {
        [UIView animateWithDuration:0.3 animations:^{
            arrowImageView.transform = CGAffineTransformMakeRotation(DEGREE_2_RADIAN(180));
        }];
        [self changeState:RefreshTabelViewHeadStateWillRefresh];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            arrowImageView.transform = CGAffineTransformMakeRotation(DEGREE_2_RADIAN(0));
        }];
        [self changeState:RefreshTabelViewHeadStateNormal];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y < - 80.0f) {
        [self changeState:RefreshTabelViewHeadStateRefreshing];
        
        [UIView animateWithDuration:0.3 animations:^{
            arrowImageView.transform = CGAffineTransformMakeRotation(DEGREE_2_RADIAN(0));
        }];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        [myTableView setContentInset:UIEdgeInsetsMake(80.0f, 0.0f, 0.0f, 0.0f)];
        [UIView commitAnimations];
        
        [arrowImageView setHidden:YES];
        
        if (!aiView) {
            aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }
        [aiView setFrame:CGRectMake(25, 12, 30, 55)];
        [aiView startAnimating];
        [aiView setHidden:YES];
        [headView addSubview:aiView];

        
        if (dataSource) {
            if ([dataSource respondsToSelector:@selector(RefreshTableViewRefreshDatas)]) {
                [dataSource RefreshTableViewRefreshDatas];
            }
        }
    }
    
    //上拉
//    if (scrollView.contentOffset.y > scrollView.contentSize.height / 2 + myTableView.rowHeight*2) {
    if (scrollView.contentOffset.y+scrollView.frame.size.height>scrollView.contentSize.height+5) {
        if (state != RefreshTabelViewFootStateAddmoreing) {
            [self changeState:RefreshTabelViewFootStateAddmoreing];
            [addAiView startAnimating];
            if (dataSource) {
                if ([dataSource respondsToSelector:@selector(RefreshTableViewAddDatas)]) {
                    [dataSource RefreshTableViewAddDatas];
                }
            }
        }
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (delegate) {
        return [delegate RefreshTableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (delegate) {
        [delegate RefreshTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([dataSource respondsToSelector:@selector(RefreshTableViewNumberOfSectionsInTableView:)]) {
        return [dataSource RefreshTableViewNumberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataSource) {
        return [dataSource RefreshTableView:tableView numberOfRowsInSection:section] + 1;
    }
    return 0.0f;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        
        [cell.contentView addSubview:addLabel];
        [cell.contentView addSubview:addAiView];
        
        return cell;
    }
    
    if (dataSource) {
        return [dataSource RefreshTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    
    
    
    
    return nil;
}


- (NSString *) getKeyForState : (RefreshTabelViewState) _state
{
    NSString *stateString = nil;
    if (_state == RefreshTabelViewHeadStateDidRefresh) {
        stateString = [NSString stringWithFormat:@"%d",RefreshTabelViewHeadStateDidRefresh];
    }
    else if(_state == RefreshTabelViewHeadStateNormal)
    {
        stateString = [NSString stringWithFormat:@"%d",RefreshTabelViewHeadStateNormal];
    }
    else if (_state == RefreshTabelViewHeadStateRefreshing) {
        stateString = [NSString stringWithFormat:@"%d",RefreshTabelViewHeadStateRefreshing];
    }
    else if(_state == RefreshTabelViewHeadStateWillRefresh)
    {
        stateString = [NSString stringWithFormat:@"%d",RefreshTabelViewHeadStateWillRefresh];
    }
    else if (_state == RefreshTabelViewFootStateNormal) {
        stateString = [NSString stringWithFormat:@"%d",RefreshTabelViewFootStateNormal];
    }
    else if(_state == RefreshTabelViewFootStateAddmoreing)
    {
        stateString = [NSString stringWithFormat:@"%d",RefreshTabelViewFootStateAddmoreing];
    }
    return stateString;
}


- (void) changeState : (RefreshTabelViewState) _state
{
    
    if (state == _state) {
        return;
    }
    
    NSString *stateString = [self getKeyForState:_state];
    
    if (_state == RefreshTabelViewHeadStateDidRefresh) {
        state = RefreshTabelViewHeadStateDidRefresh;
        NSString *headTitleString = [headTitleDic objectForKey:stateString];
        if (headTitleString) {
            [headTitleLabel setText:headTitleString];
        }
        else
        {
            [headTitleLabel setText:@"刷新完成"];
        }
    }
    else if(_state == RefreshTabelViewHeadStateNormal)
    {
        state = RefreshTabelViewHeadStateNormal;
        NSString *headTitleString = [headTitleDic objectForKey:stateString];
        if (headTitleString) {
            [headTitleLabel setText:headTitleString];
        }
        else
        {
            [headTitleLabel setText:@"下拉刷新"];
        }
        
        NSString *footTitleString = [footTitleDic objectForKey:stateString];
        if (footTitleString) {
            [addLabel setText:footTitleString];
        }
        else
        {
            [addLabel setText:@"上拉加载更多..."];
        }
    }
    else if (_state == RefreshTabelViewHeadStateRefreshing) {
        state = RefreshTabelViewHeadStateRefreshing;
        NSString *headTitleString = [headTitleDic objectForKey:stateString];
        if (headTitleString) {
            [headTitleLabel setText:headTitleString];
        }
        else
        {
            [headTitleLabel setText:@"正在刷新"];
        }
    }
    else if(_state == RefreshTabelViewHeadStateWillRefresh)
    {
        state = RefreshTabelViewHeadStateWillRefresh;
        NSString *headTitleString = [headTitleDic objectForKey:stateString];
        if (headTitleString) {
            [headTitleLabel setText:headTitleString];
        }
        else
        {
            [headTitleLabel setText:@"释放刷新"];
        }
    }
    else if(_state == RefreshTabelViewFootStateNormal)
    {
        state = RefreshTabelViewFootStateNormal;
        NSString *headTitleString = [headTitleDic objectForKey:stateString];
        if (headTitleString) {
            [headTitleLabel setText:headTitleString];
        }
        else
        {
            [headTitleLabel setText:@"下拉刷新"];
        }
        
        NSString *footTitleString = [footTitleDic objectForKey:stateString];
        if (footTitleString) {
            [addLabel setText:footTitleString];
        }
        else
        {
            [addLabel setText:@"上拉加载更多..."];
        }
    }
    else if (_state == RefreshTabelViewFootStateAddmoreing)
    {
        state = RefreshTabelViewFootStateAddmoreing;
        NSString *footTitleString = [footTitleDic objectForKey:stateString];
        if (footTitleString) {
            [addLabel setText:footTitleString];
        }
        else
        {
            [addLabel setText:@"正在加载..."];
        }
    }
}

- (void) animationDidStop
{
    [self changeState:RefreshTabelViewHeadStateNormal];
}

- (NSString*) getSystemTime
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

- (BOOL) saveTime : (NSString*) _time
{
    NSArray* cachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [NSString stringWithFormat:@"%@",[cachesPaths objectAtIndex:0]];
    NSString *path = [cachesPath stringByAppendingPathComponent:@"RefreshTime.txt"];
    return [_time writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *) getCacheTime
{
    NSArray* cachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [NSString stringWithFormat:@"%@",[cachesPaths objectAtIndex:0]];
    NSString *path = [cachesPath stringByAppendingPathComponent:@"RefreshTime.txt"];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
