//
//  SendfailButton.h
//  FangChuang
//
//  Created by weiping on 14-9-15.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendfailButton : UIButton
@property(strong,nonatomic)UIImageView *btimage;
@property (strong,nonatomic)UIActivityIndicatorView  *ActivityIndicator;
@property (nonatomic,strong)NSString * stated;
@end
