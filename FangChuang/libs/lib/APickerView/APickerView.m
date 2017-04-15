//
//  APickerView.m
//  TestApplication
//
//  Created by 潘鸿吉 on 13-8-26.
//  Copyright (c) 2013年 潘鸿吉. All rights reserved.
//

#import "APickerView.h"

@implementation APickerView
@synthesize myPickerView , delegate;

- (void) dealloc
{
    if (delegate) {
        [delegate release];
        delegate = nil;
    }
    [super dealloc];
}

-(id)initWithData:(NSArray *)data
{
    self = [super init];
    if (self) {
        LandScape = NO;
        dataArray = [[NSArray alloc] initWithArray:data];
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        //rect.size.height = rect.size.height - 20;

        //[self setFrame:rect];
        [self setFrame:CGRectMake(0,rect.size.height, 320, rect.size.height)];
        [self setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.7]];
        [self setUserInteractionEnabled:YES];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, rect.size.height-216-30)];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn release];
        
        myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, rect.size.height-216, rect.size.width, 216)];
        [myPickerView setShowsSelectionIndicator:YES];
        [myPickerView setBackgroundColor:[UIColor whiteColor]];
        [myPickerView setDelegate:self];
        [myPickerView setDataSource:self];
        [self addSubview:myPickerView];
        [myPickerView release];
        
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, rect.size.height-216-30, rect.size.width, 30)];
        [toolBar setBarStyle:UIBarStyleBlack];
        [toolBar setUserInteractionEnabled:YES];
        [self addSubview:toolBar];
        [toolBar release];
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmAction)];
        
        [toolBar setItems:[NSArray arrayWithObjects:leftButton,space,rightButton, nil]];
        [space release];
        [leftButton release];
        [rightButton release];
        
        [UIView animateWithDuration:0.5f
                         animations:^{
                             [self setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
                             //[myPickerView setFrame:CGRectMake(0, rect.size.height-180, rect.size.width, 180)];
                             //[toolBar setFrame:CGRectMake(0, 0, rect.size.width, 30)];
                         } completion:^(BOOL finished) {
                             if (delegate && [delegate respondsToSelector:@selector(pickerViewStartAnimationFinish:)])
                             {
                                 [delegate pickerViewStartAnimationFinish:self];
                             }
                         }];
    }
    return self;
}
- (id) initWithData:(NSArray *)data :(BOOL)isLandScape
{
    LandScape = YES;
    isLandScape = LandScape;
    self = [super init];
    if (self) {
        if (isLandScape) {
            //CGRect rect = CGRectMake(0, 0, screenHeight, 320);
            //NSLog(@"RECT=%@",NSStringFromCGRect(rect));
            dataArray = [[NSArray alloc] initWithArray:data];
            
            
            //rect.size.height = rect.size.height - 20;
            
            //[self setFrame:rect];
            [self setFrame:CGRectMake(0,320, screenHeight+20, 320)];
            [self setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.7]];
            [self setUserInteractionEnabled:YES];
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, screenHeight+20, 320-216-30)];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btn release];
            
            myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 320-216, screenHeight+20, 216)];
            [myPickerView setShowsSelectionIndicator:YES];
            [myPickerView setBackgroundColor:[UIColor whiteColor]];
            [myPickerView setDelegate:self];
            [myPickerView setDataSource:self];
            [self addSubview:myPickerView];
            [myPickerView release];
            
            toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 320-216-30, screenHeight+20, 30)];
            [toolBar setBarStyle:UIBarStyleBlack];
            [toolBar setUserInteractionEnabled:YES];
            [self addSubview:toolBar];
            [toolBar release];
            
            UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
            
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
            
            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmAction)];
            
            [toolBar setItems:[NSArray arrayWithObjects:leftButton,space,rightButton, nil]];
            [space release];
            [leftButton release];
            [rightButton release];
            
            [UIView animateWithDuration:0.5f
                             animations:^{
                                 [self setFrame:CGRectMake(0, -45, screenHeight+20, 320)];
                                 //[myPickerView setFrame:CGRectMake(0, rect.size.height-180, rect.size.width, 180)];
                                 //[toolBar setFrame:CGRectMake(0, 0, rect.size.width, 30)];
                             } completion:^(BOOL finished) {
                                 if (delegate && [delegate respondsToSelector:@selector(pickerViewStartAnimationFinish:)])
                                 {
                                     [delegate pickerViewStartAnimationFinish:self];
                                 }
                             }];
        }

    }
    return self;
}
- (void)back:(UIButton*)sender
{
    [UIView animateWithDuration:.3f animations:^{
        CGRect rect = [[UIScreen mainScreen] bounds];
        [self setFrame:CGRectMake(0,rect.size.height, 320, rect.size.height)];
    }];
}
- (void) setSelectRow : (NSInteger) row inComponent : (NSInteger) component animated : (BOOL) animated
{
    NSLog(@"aaaaaaaaaaaaaaaaaaa");
    if (component > [myPickerView numberOfComponents] - 1) {
        return;
    }
    if (row > [myPickerView numberOfRowsInComponent:component] - 1) {
        return;
    }
    [myPickerView selectRow:row inComponent:component animated:animated];
}

#pragma mark - UIToolBar Action
- (void) cancelAction
{
    NSLog(@"------");
    [self removeAnimation];
}

- (void) confirmAction
{
    NSLog(@"++++++");
    if (delegate && dataArray && dataArray.count > 0 && [delegate respondsToSelector:@selector(pickerViewSelectObject:index:)]) {
        int index = [myPickerView selectedRowInComponent:0];
        [delegate pickerViewSelectObject:[dataArray objectAtIndex:index] index:index];
    }
    if (delegate && dataArray && dataArray.count > 0 && [delegate respondsToSelector:@selector(pickerview: SelectObject:index:)]) {
        int index = [myPickerView selectedRowInComponent:0];

        [delegate pickerview:self SelectObject:[dataArray objectAtIndex:index] index:index];
    }
    
    [self removeAnimation];
}

#pragma mark - UIPickerViewDelegate , UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (dataArray && dataArray.count > 0) {
        return dataArray.count;
    }
    return 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 290.0f;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [label setBackgroundColor:[UIColor clearColor]];
    if (dataArray && dataArray.count > 0) {
        [label setText:[NSString stringWithFormat:@"%@",[dataArray objectAtIndex:row]]];
    }
    else
    {
        [label setText:@"暂无数据"];
    }
    return [label autorelease];
}

#pragma mark - self remove animation
- (void) removeAnimation
{
    [UIView animateWithDuration:0.3f
                     animations:^{
        
                         if (LandScape) {
                             [self setFrame:CGRectMake(0,320, screenHeight+40, 320)];
                         }else{
                             [self setFrame:CGRectMake(0,screenHeight, 320, screenHeight)];
                         }
                         
//                         rect.size.height = rect.size.height - 20;
//                         CGRect toolRect = toolBar.frame;
//                         CGRect mpvRect = myPickerView.frame;
//                         [toolBar setFrame:CGRectMake(toolRect.origin.x, rect.size.height, toolRect.size.width, toolRect.size.height)];
//                         [myPickerView setFrame:CGRectMake(mpvRect.origin.x, rect.size.height, mpvRect.size.width, mpvRect.size.height)];
                         //[self setFrame:CGRectMake(0,rect.size.height, 320, rect.size.height)];
                     } completion:^(BOOL finished) {
                         if (delegate && [delegate respondsToSelector:@selector(pickerViewEndAnimationFinish:)])
                         {
                             [delegate pickerViewEndAnimationFinish:self];
                         }
//                         [self removeFromSuperview];
                         
                     }];
}

@end
