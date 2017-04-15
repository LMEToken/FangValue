//
//  MineInFoemationViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FangChuangInsiderViewController.h"
@interface MineInFoemationViewController : ParentViewController<UIScrollViewDelegate,UITextViewDelegate>
{
    UIScrollView *inforView;
    UILabel *xingminglab;
    UILabel *xingbielab;
    UILabel *zhiweilab;
    UILabel *gangweilab;
    UILabel *fengonglab;
    UILabel *shoujilab;
    UILabel *weixinlab;
    UILabel *emaillab;
    UILabel *lvlilab;
    UIImageView *image1View;
    
    UITextView *xiatextView;
    
    NSMutableArray *dataArray;
}
@property(nonatomic,assign)BOOL ismine;
@property(nonatomic,retain)NSDictionary *dic;
-(void)removeEditButton;
- (void)reloadWithText:(NSString *)text1 Text:(NSString *)text2 Text:(NSString *)text3 Text:(NSString *)text4 Text:(NSString *)text5 Text:(NSString *)text6 Text:(NSString *)text7 Text:(NSString *)text8 Text:(NSString *)text9;

//2014.05.04 chenlihua 解决点击联系人聊天界面头像，详细信息里，头像错乱的问题。
@property (nonatomic,retain) NSString *flagPage;
@end
