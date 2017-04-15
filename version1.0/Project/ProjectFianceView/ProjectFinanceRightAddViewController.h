//
//  ProjectFinanceRightAddViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-18.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FangChuangInsiderViewController.h"
@interface ProjectFinanceRightAddViewController : ParentViewController
<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UILabel *organizationNameLabel;
    UIView *organizationNameContentView;
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
    UILabel *pslabel;
    UIView *psView;
    UILabel *recordMeetLabel;
    UIView *recordView;
    UITextField *recordTextField;
    UIScrollView *backScrollerView;
    UIButton *basicInformationStateButton;
    UIButton *basicInformationGroupButton;
    
}
@property (nonatomic,strong) UITextField *organizationNameTextField;
@property (nonatomic,strong) UITextField *basiInformationContactContentTextField;
@property (nonatomic,strong) UITextField *basicInformationStateMustTextField;
@property (nonatomic,strong) UITextField *basiInformationMeetContentTextField;
@property (nonatomic,strong) UITextField *basicInformationGroupMustTextField;
@property (nonatomic,strong) UITextView *psTextView;
@property (nonatomic,strong) UITextField *companyFlagTextField;
@property (nonatomic,strong) NSString *companyFlagString;
@property (nonatomic,strong) NSString *wherefrom;
@property (nonatomic,strong) NSString *proID;

@end
