//
//  ProjectBasicInfoViewController.m
//  FangChuang
//
//  Created by omni on 14-4-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//项目基本信息

#import "ProjectBasicInfoViewController.h"
#import "CacheImageView.h"
#import "SingleLineEditableModule.h"

@interface ProjectBasicInfoViewController ()
{
    SingleLineEditableModule* singleLine;
    UIScrollView *myScrollView;
    HPGrowingTextView* firstResponderText;
    float scrollViewOffset;
}
@end

@implementation ProjectBasicInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillShow:)
													 name:UIKeyboardWillShowNotification
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillHide:)
													 name:UIKeyboardWillHideNotification
												   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"项目基本信息";
    [self setTabBarIndex:1];
    [self setTabBarHidden:YES];
    
    [self addBackButton];
    [self createRightButton];
    
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [myScrollView setBackgroundColor:[UIColor clearColor]];
    [myScrollView setShowsVerticalScrollIndicator:YES];
    [myScrollView setContentSize:CGSizeMake(320, 530)];
    [myScrollView setDelegate:self];
    [self.contentView addSubview:myScrollView];
    
    
    NSArray* titleA = @[@"【定位】:",@"【模式】:",@"【卖点】:"];
    NSArray* titleB = @[@"【企业全称】:",@"【所在地区】:",@"【所在行业】:",@"【行业网址】:"];
    NSArray* titleC = @[@"【市场规模】:",@"【产品】:",@"【营销】:",@"【竞争力】:",@"【技术研发】:",@"【运营数据】:"];
    NSArray* titleArray = @[titleA,titleB,titleC];
    
    float height = 0;
     for (int j=0; j<3; j++) {
        NSArray* tmpArr = [titleArray objectAtIndex:j];
        
        for (int k=0; k<[tmpArr count]; k++) {
            singleLine = [[SingleLineEditableModule alloc] initWithFrame:CGRectMake(5, 20+35*k+5*k+height, 310, 35) WithTitle:[tmpArr objectAtIndex:k]];
            singleLine.textView.tag = 100+j*10+k;
            singleLine.textView.delegate = self;
           // singleLine.backgroundColor=[UIColor redColor];
            [myScrollView addSubview:singleLine];
        }
        height = CGRectGetMaxY(singleLine.frame);
    }
    
    myScrollView.contentSize = CGSizeMake(320, height+20);
}
#pragma -mark -functions
-(void)createRightButton
{
    //添加右边的按钮
    UIButton* rtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rtBtn setFrame:CGRectMake(320 - 44 - 10, 0, 44, 44)];
    [rtBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
    [rtBtn setImage:[UIImage imageNamed:@"44_anniu_1"] forState:UIControlStateNormal];
    [rtBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rtBtn isAutoFrame:NO];
    
}
- (void)rightButton:(UIButton*)sender
{
    [self.view endEditing:YES];
}
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    //临界值
    float edgeValue = self.view.bounds.size.height-keyboardBounds.size.height-statusBarHeight-navigationHeight-20;//20代表初始高度
    
    float bottom = CGRectGetMaxY([firstResponderText superview].frame)-scrollViewOffset;
    if ( bottom < edgeValue) {
        return;
    }else{
        
        float distance = bottom-edgeValue;
        
        // get a rect for the textView frame
        CGRect containerFrame = myScrollView.frame;
        
        containerFrame.origin.y -= distance;
        
        // animations settings
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:[duration doubleValue]];
        [UIView setAnimationCurve:[curve intValue]];
        
        //	// set views with new info
        myScrollView.frame = containerFrame;
        
        // commit animations
        [UIView commitAnimations];
    }
    
}
-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	
    //临界值
    float edgeValue = self.view.bounds.size.height-216-statusBarHeight-navigationHeight-20;
    
    float bottom = CGRectGetMaxY([firstResponderText superview].frame)-scrollViewOffset;
    
    if ( bottom < edgeValue) {
        return;
    }else{
        float distance = bottom-edgeValue;
        
        // get a rect for the textView frame
        CGRect containerFrame = myScrollView.frame;
        containerFrame.origin.y += distance;
        
        // animations settings
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:[duration doubleValue]];
        [UIView setAnimationCurve:[curve intValue]];
        //
        // set views with new info
        myScrollView.frame = containerFrame;
        
        // commit animations
        [UIView commitAnimations];
    }
    
}
#pragma -mark -scrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    scrollViewOffset = scrollView.contentOffset.y;
    NSLog(@"偏移量 %.1f",scrollViewOffset);
}
#pragma -mark -HPGrowingTextViewDelegate

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    
    float diff = (growingTextView.frame.size.height - height);

    SingleLineEditableModule* single = (SingleLineEditableModule*)[growingTextView superview];
    
    //改变父视图高度
	CGRect r = single.frame;
    r.size.height -= diff;
	single.frame = r;
    
    //改变比自己低的视图顶点位置
    for (UIView* view in [myScrollView subviews]) {
        if ([view isKindOfClass:[SingleLineEditableModule class]]) {
            SingleLineEditableModule* tmpModule = (SingleLineEditableModule*)view;
            //不是改变全部叔伯视图，只改变叔叔视图的顶点位置（比自己高度低的模块，位置上升）
            if (CGRectGetMaxY(tmpModule.frame) > CGRectGetMaxY(single.frame)) {
                CGRect s = tmpModule.frame;
                s.origin.y -= diff;//
                tmpModule.frame = s;
            }
        }
    }
    
    //改变scroll视图内容高度
	CGSize t = myScrollView.contentSize;
    t.height -= diff;
	myScrollView.contentSize = t;

    //临界值
    float edgeValue = self.view.bounds.size.height-216-20;//20代表初始高度
    
    float dis = CGRectGetMaxY([growingTextView superview].frame)-edgeValue-scrollViewOffset;
    NSLog(@"差距 %f",dis);
   
    
    //有bug，只点回车时，会改变frame
    /*
    if (dis>-50) {
        NSLog(@"需要调整");
        //改变视图
        CGRect containerFrame = myScrollView.frame;
        containerFrame.origin.y += diff;
        myScrollView.frame = containerFrame;
    }
     */
}

- (BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView{
    firstResponderText = growingTextView;
    return YES;
}
//2014.07.17 chenlihua 使点击done的时候键盘消失
-(BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView
{
    [growingTextView resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
