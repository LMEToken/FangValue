//
//  AddTimeViewController.h
//  FangChuang
//
//  Created by 顾 思谨 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "APickerView.h"
#import "CYCustomMultiSelectPickerView.h"
#import "NetManager.h"
@interface AddTimeViewController : ParentViewController <UITextFieldDelegate,APickerViewDelegate,CYCustomMultiSelectPickerViewDelegate>
{
    UIDatePicker *datePicker;
    UILabel *startLabel;
    UILabel *finishLabel;
    UITapGestureRecognizer *timeTap1;
    UITapGestureRecognizer *timeTap2;
    int number;
    UITextField *personTextField;
    UILabel *remindTimeLabel;
    NSDictionary *_myDic;
    CYCustomMultiSelectPickerView *multiPickerView;

}
@property(nonatomic ,retain)NSDictionary *myDic;
@property(nonatomic,assign)int  editeType;
@property(nonatomic,copy)NSString*  proid;
@property(nonatomic,copy)NSString*  starDate;
@property (nonatomic , retain) NSArray* projectIDArray;
@property(nonatomic , retain) NSArray * projectNameArray;
@property (nonatomic , retain) NSArray* uesrNameArray;
@property (nonatomic , retain) NSArray* userIDArray;
@property (nonatomic , retain) NSString* attend;

@end
