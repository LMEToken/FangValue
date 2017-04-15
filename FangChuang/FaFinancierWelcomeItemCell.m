//
//  FaFinancierWelcomeItemCell.m
//  FangChuang
//
//  Created by omni on 14-3-28.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//方创Cell

#import "FaFinancierWelcomeItemCell.h"

//2014.06.12 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"


@implementation FaFinancierWelcomeItemCell

@synthesize unReadLabel;
@synthesize stickButton;
@synthesize deleteButton;
@synthesize bcImgV;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //背景框
        UIImage* bcImg = [UIImage imageNamed:@"63_kuang_1"];
//         UIImageView *bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 55)];
        //2014.05.07 chenlihua 方创首页左边滑动增加置顶和删除按钮
        //2014.08.14 chenlihua 修改方创部分单元格的线的宽度。由55改成了56.
        bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame)+110, 60)];
        bcImgV.hidden = YES;
        [bcImgV setImage:bcImg];
        [self.contentView addSubview:bcImgV];
//        UIImageView *cellline = [[UIImageView alloc]initWithFrame:CGRectMake(58, 60, 320, 1)];
//        cellline.image = [UIImage imageNamed:@"cellfenge"];
//        [self.contentView addSubview:cellline];
        //        UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 60, 320, 1)];
        //        myview.image = [UIImage imageNamed:@"celllin@2x"];
        //        [self addSubview:myview];
        
        //2014.05.07 chenlihua 方创首页左边滑动增加置顶和删除按钮
        
        //置顶按钮
     
        
        
        //        //向右滑动
        //        UISwipeGestureRecognizer *recognizerLeft;
        //        recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromLeft:)];
        //        [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        //        [self.contentView addGestureRecognizer:recognizerLeft];
        //
        //        //向左滑动
        //        UISwipeGestureRecognizer *recognizerRight;
        //        recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromRight:)];
        //        [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
        //        [self.contentView addGestureRecognizer:recognizerRight];
        
        self.timelable = [[UILabel alloc]initWithFrame:CGRectMake(190, 15, 120, 30)];
        self.timelable.textAlignment = UITextAlignmentRight;
        [self.timelable setFont:[UIFont fontWithName:KUIFont size:10]];
        [self.timelable setTextColor:[UIColor grayColor]];
        
        [self.contentView addSubview:self.timelable];
        
        //头像的图标
        _avatar = [self addAvatarView];
        
        //2014.04.29 chenlihua 未读消息的条数
        unReadLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 18, 18)];
        unReadLabel.backgroundColor=[UIColor redColor];
        [unReadLabel setTextColor:[UIColor whiteColor]];
        
        [unReadLabel setFont:[UIFont fontWithName:KUIFont size:8]];
        unReadLabel.textAlignment=NSTextAlignmentCenter;
        [unReadLabel.layer setCornerRadius:10];
        [unReadLabel.layer setMasksToBounds:YES];
        [unReadLabel setHidden:YES];
        [self.contentView addSubview:unReadLabel];
        
        //项目名称
        /*
         _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.avatar.frame)+15, CGRectGetMinY(self.avatar.frame)+1, 200, 20)];
         [_titleLab setTextColor:ORANGE];
         [_titleLab setFont:[UIFont boldSystemFontOfSize:17.0]];
         [_titleLab setBackgroundColor:[UIColor clearColor]];
         [self.contentView addSubview:_titleLab];
         */
        
        //2014.04.29 chenlihua 修改字体的颜色为黑色。副标题为灰色。
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.avatar.frame)+23, CGRectGetMinY(self.avatar.frame)+3, 230, 20)];
        [_titleLab setTextColor:[UIColor blackColor]];
        [_titleLab setFont:[UIFont fontWithName:KUIFont size:17]];
        //[_titleLab setFont:[UIFont boldSystemFontOfSize:17.0]];
        [_titleLab setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_titleLab];
        
        //项目内容
        //2014.05.04 chenlihua 在方创首页讨论组中在群组名称下显示聊天记录，实现像微信一样的功能
        _subTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.avatar.frame)+22, CGRectGetMaxY(self.titleLab.frame)+3, 205, 20)];
        // [_subTitleLab setBackgroundColor:[UIColor redColor]];
        [_subTitleLab setTextColor:GRAY];
        [_subTitleLab setFont:[UIFont fontWithName:KUIFont size:14]];
        // [_subTitleLab setFont:[UIFont systemFontOfSize:14]];
       [self.contentView addSubview:_subTitleLab];
        
        //方创任务的未读图标。
        UIImage *check = [UIImage imageNamed:@"ic_unread.png"];
        _unReadImageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.subTitleLab.frame), CGRectGetMinY(self.titleLab.frame)+17, check.size.width/2, check.size.height/2)];
        //2014.08.15 chenlihua 将方创任务的未读图标暂时去掉
        // [_unReadImageV setImage:check];
        
        
        stickButton=[UIButton buttonWithType:UIButtonTypeCustom];
        stickButton.backgroundColor=[UIColor grayColor];
        stickButton.frame=CGRectMake(210,0, 55, 65);
        [stickButton setTitle:@"置顶" forState:UIControlStateNormal];
        [stickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:stickButton];
        stickButton.hidden = YES;
        
        
        //删除按钮
        
        deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.backgroundColor=[UIColor redColor];
        deleteButton.frame=CGRectMake(265,0,55, 65);
        [deleteButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:15]];     [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        deleteButton.hidden = YES;
        [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:deleteButton];
        
        
    }
    return self;
}

#pragma -mark -手势滑动
//2014.05.07 chenlihua 方创首页左边滑动增加置顶和删除按钮
//向左滑动
-(void)handleSwipeFromLeft:(UISwipeGestureRecognizer *)recognizer {
    stickButton.hidden = NO ;
    deleteButton.hidden = NO;
    NSLog(@"-------进入向左手势滑动姿势-------------");
    if (recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        
        //        self.contentView.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame)+110, 65);
        //        [UIView beginAnimations:@"animationID"context:nil];
        //        [UIView setAnimationDuration:0.5f];
        //        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //        [UIView setAnimationRepeatAutoreverses:NO];
        //         self.contentView.frame=CGRectMake(150, 0, CGRectGetWidth(self.frame)+110, 65);
        //
        //        [UIView commitAnimations];
        //
        
        //将删除去掉，只显示置顶
        /*
         self.contentView.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame)+55, 65);
         [UIView beginAnimations:@"animationID"context:nil];
         [UIView setAnimationDuration:0.3f];
         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
         [UIView setAnimationRepeatAutoreverses:NO];
         self.contentView.frame=CGRectMake(-55, 0, CGRectGetWidth(self.frame)+110, 65);
         [UIView commitAnimations];
         */
        
    }
}

//2014.05.07 chenlihua 方创首页左边滑动增加置顶和删除按钮
//向右滑动
-(void)handleSwipeFromRight:(UISwipeGestureRecognizer *)recognizer {
    stickButton.hidden = YES ;
    deleteButton.hidden = YES;
    NSLog(@"-------进入向右手势滑动姿势-------------");
    if (recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        
        //        self.contentView.frame=CGRectMake(-110, 0, CGRectGetWidth(self.frame)+110,65);
        //        [UIView beginAnimations:@"animationID"context:nil];
        //        [UIView setAnimationDuration:0.3f];
        //        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //        [UIView setAnimationRepeatAutoreverses:NO];
        //        self.contentView.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame)+110, 65);
        //        [UIView commitAnimations];
        
        /*
         //2014.09.03 chenlihua 将删除去掉，只显示置顶
         
         self.contentView.frame=CGRectMake(-55, 0, CGRectGetWidth(self.frame)+55,65);
         [UIView beginAnimations:@"animationID"context:nil];
         [UIView setAnimationDuration:0.3f];
         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
         [UIView setAnimationRepeatAutoreverses:NO];
         self.contentView.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame)+55, 65);
         [UIView commitAnimations];
         */
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
    
    // Configure the view for the selected state
}
/*
 - (CacheImageView*)addAvatarView{
 if (!_avatar) {
 _avatar = [[CacheImageView alloc] initWithFrame:CGRectMake(10, (55 - 80 / 2) / 2, 40, 40)];
 [_avatar setBackgroundColor:ORANGE];
 //  [_avatar setBackgroundColor:[UIColor blueColor]];
 [_avatar.layer setCornerRadius:8.0];
 [_avatar.layer setMasksToBounds:YES];
 [self.contentView addSubview:self.avatar];
 }
 return _avatar;
 }
 */
//2014.06.12 chenlihua 修改头像的缓存方式

- (UIImageView*)addAvatarView{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, (55 - 80 / 2) / 2, 46, 46)];
        //2014.07.23 chenlihua 修改前面的图标
        /*
         [_avatar setBackgroundColor:ORANGE];
         [_avatar setBackgroundColor:[UIColor blueColor]];
         */
        [_avatar.layer setCornerRadius:8.0];
        [_avatar.layer setMasksToBounds:YES];
        [self.contentView addSubview:self.avatar];
    }
    return _avatar;
}

@end
