//
//  ProjectFinanceTableViewCellDetailViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-20.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "ReaderViewController.h"
#import "FangChuangInsiderViewController.h"
@interface ProjectFinanceTableViewCellDetailViewController : ParentViewController
<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,ReaderViewControllerDelegate>
{
    UILabel *organizationNameLabel;
    UIView *organizationNameContentView;
    UIImageView *organizationHeadImageView;
    
    UILabel *companyLabel;
    UIView *companyContentView;
    UIButton *companyAddButton;
    UILabel *basicInformationLabel;
    UIView *basicInformationContactView;
    UILabel *basicInformationContactLabel;
    UIImageView *lineContactView;
    UIView *basicInformationStateView;
    UILabel  *basicInformationStateLabel;
    UIImageView *stateArrowImageView;
    UIImageView *lineStateView;
    UIView *basicInformationMeetView;
    UILabel *basicInformationMeetLabel;
    UIImageView *lineMeetView;
    UIView *basicInformationGroupView;
    UILabel *basicInformationGroupLabel;
    UIImageView *GroupArrowImageView;
    UIImageView *lineGroupView;
    UILabel *psLabel;
    UIView *psView;
    UILabel *recordMeetLabel;
    UIView *recordView;
    UIScrollView *backScrollerView;
    UIButton *basicInformationStateButton;
    UIButton *basicInformationGroupButton;
    UIButton *recordFirstButton;
    UIButton *recordSecondButton;
    UITextView *recordFirstView;
    UITextView *recordSecondView;
    NSDictionary *dic;

}
@property (nonatomic,strong) UITextField *basiInformationContactContentTextField;
@property (nonatomic,strong) UITextField *basicInformationStateMustTextField;
@property (nonatomic,strong) UITextField *basiInformationMeetContentTextField;
@property (nonatomic,strong) UITextField *basicInformationGroupMustTextField;
@property (nonatomic,strong) UITextView *psTextView;
@property (nonatomic,strong) NSString *companyFlagString;
@property (nonatomic,strong) NSString *whereFromString;
@property (nonatomic,strong) NSString *proID;
@property (nonatomic,strong) NSString *piid;
@property (nonatomic,strong) NSDictionary *beforeDic;
@property (nonatomic,strong) NSString *group;

@end
