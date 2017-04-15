//
//  UserInfo.h
//  RongYi
//
//  Created by 潘鸿吉 on 13-6-4.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
+ (id)sharedManager;


@property (nonatomic , assign) BOOL islogin;
@property (nonatomic , strong) NSString* usertype; //用户类型 0 融资 | 1 投资 | 2 其他
@property (nonatomic , retain) NSString* apptoken; // 接口需要传token  接口控制，无需手动传
@property (nonatomic , retain) NSString* username;
@property (nonatomic , retain) NSString* userpicture;
@property (nonatomic , retain) NSString* userphone;
@property (nonatomic , retain) NSString* useremail;
@property (nonatomic , retain) NSString* userid;
@property (nonatomic , retain) NSString* weixin;
@property (nonatomic , retain) NSString* record;
@property (nonatomic , retain) NSString* post;
@property (nonatomic , retain) NSString* usergender;
@property (nonatomic , retain) NSString* divide;
@property (nonatomic , retain) NSString* duty;
@property (nonatomic , retain) NSString* comname;//公司名称
@property (nonatomic , retain) NSString* base;//所在地
@property (nonatomic , retain) NSString* lingyu;//创者者所属领域
@property (nonatomic , retain) NSString* jieduan;//创者者阶段
@property (nonatomic , retain) NSString* guimo;//创者者规模
@property (nonatomic , retain) NSString* rongzi;//创者者融资
@property (nonatomic , retain) NSString* gongsijianjie;//创者者公司简介
@property (nonatomic , retain) NSString *fmoney;//投资人:偏好额度
@property (nonatomic , retain) NSString *statge;//投资人:投资轮次
@property (nonatomic , retain) NSString *industry;//投资人:关注领域
@property (nonatomic , retain) NSString *currency;//投资人: 币种
@property (nonatomic , retain) NSString *pdesc;//投资人：公司简介
@property (nonatomic , retain) NSString* user_name; //名字
@property (nonatomic, assign) BOOL isUploadProject;
@property (nonatomic,strong) NSString *diffID; //0 创业者  1 投资者

@end
//"data":{"username":"fcapp","usertype":"0","userpicture":"fcapp","userphone":"","useremail":"","userid":"57"}