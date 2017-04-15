//
//  NetManager.m
//  RongYi
//
//  Created by wen yu on 13-5-23.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "NetManager.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Utils.h"
#import "UIDevice+IdentifierAddition.h"
//#import "LoginViewController.h"
static NetManager *_manager;

static int  showHud ; // 标志时候弹框
NSString* const PDFDOCMENTDIDGOT = @"PDFDOCMENTDIDGOT";


//

//生产
//#define serverAddress @"http://www.duiduila.com"
@implementation NetManager


-(void)dealloc
{
    [_manager release];
    [super dealloc];
}

#pragma mark - 获取单例
+ (id)sharedManager{
    if (!_manager) {
        _manager = [[NetManager alloc]init];
    }
    return _manager;
}
#pragma -mark ------------新版项目部分---------------------------------------
#pragma -mark -跟进信息接口
- (void)getpipinfoWithUsername:(NSString*)username
                     apptoken:(NSString *)apptoken
                     projectid:(NSString *)projectid
                          piid:(NSString *)piid
                       hudDic:(NSDictionary*)hudDic
                      success:(void (^)(id responseDic))_success
                         fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",projectid,@"projectid",piid,@"piid",nil];
    NSLog(@"------上传服务器---跟进信息---- dic %@-------",dic);
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getpipinfo",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:_success
                            failure:_fail];
}


#pragma -mark -选择身份的时候显示土豪
- (void)gethaonumWithUsername:(NSString*)username
                       apptoken:(NSString *)apptoken
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    NSLog(@"------上传服务器---tuhao---- dic %@-------",dic);
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@gethaonum",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:_success
                            failure:_fail];
}

#pragma -mark --上传名片
- (void)uptcardWithUsername:(NSString*)username
                    apptoken:(NSString *)apptoken
                     userpicture:(NSString *)userpicture
                       hudDic:(NSDictionary*)hudDic
                     success:(void (^)(id responseDic))_success
                        fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",userpicture,@"userpicture",nil];
    NSLog(@"---------向服务器发送文件消息----- dic %@-------",dic);
    
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@uptcard",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:_success
                            failure:_fail];
}


#pragma -mark --忘记密码接口

- (void)resetPasswordWithusername:(NSString*)username
                          apptoken:(NSString *)apptoken
                             verifycode:(NSString *)verifycode
                      newpassword:(NSString *)newpassword
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))success
                              fail:(void (^)(id errorString))fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",apptoken,@"apptoken",verifycode,@"verifycode",newpassword,@"newpassword",nil];
    
    NSLog(@"---------上传服务器的数据--resetpassword--- dic %@-------",dic);
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@resetpassword",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:success
                            failure:fail];
    
}


#pragma -mark -获取验证码接口

- (void)GetverifycodeWithmobile:(NSString*)mobile
                          apptoken:(NSString *)apptoken
                             rflag:(NSString *) rflag
                         deviceid:(NSString *)deviceid
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))success
                              fail:(void (^)(id errorString))fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile",apptoken,@"apptoken",rflag,@"rflag",deviceid,@"deviceid",nil];
    
    
    NSLog(@"---------上传服务器的数据--getverifycode--- dic %@-------",dic);
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getverifycode",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:success
                            failure:fail];
    
}



#pragma -mark -项目关注部分接口（十一)
- (void)getProjectLikeWithusername:(NSString*)username
                          apptoken:(NSString *)apptoken
                           rflag:(NSString *) rflag
                             projectid:(NSString *)projectid
                           hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))success
                              fail:(void (^)(id errorString))fail
{
     NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",apptoken,@"apptoken",rflag,@"rflag",projectid,@"projectid",nil];
    
    
    NSLog(@"---------上传服务器的数据--like--- dic %@-------",dic);
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@projectlike",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:success
                            failure:fail];
    
}


#pragma -mark -注册接口（五)
- (void)getRegisterWithusername:(NSString*)username
                           apptoken:(NSString *)apptoken
                       password:(NSString *)password
                   registertype:(NSString *)registertype
                              deviceid:(NSString *)deviceid
               verificationcode:(NSString *)verificationcode
                         mobile:(NSString *)mobile
                       realname:(NSString *)realname
                        comname:(NSString *)comname
                       position:(NSString *)position
                          email:(NSString *)email
                         comurl:(NSString *)comurl
                         fmoney:(NSString *)fmoney
                         statge:(NSString *)statge
                       industry:(NSString *)industry
                          pdesc:(NSString *)pdesc
                        proteam:(NSString *)proteam
                       teamsize:(NSString *)teamsize
                       currency:(NSString *)currency
                             hudDic:(NSDictionary*)hudDic
                            success:(void (^)(id responseDic))success
                               fail:(void (^)(id errorString))fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",apptoken,@"apptoken",password,@"password",registertype,@"registertype",deviceid,@"deviceid",verificationcode,@"verificationcode",mobile,@"mobile",realname,@"realname",comname,@"comname",position,@"position",email,@"email",comurl,@"comurl",fmoney,@"fmoney",statge,@"statge",industry,@"industry",pdesc,@"pdesc",proteam,@"proteam",teamsize,@"teamsize",currency,@"currency",nil];
    NSLog(@"---------上传服务器的数据--register--- dic %@-------",dic);
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@register",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:success
                            failure:fail];
    
}

#pragma -mark -项目部分列表,筛选部分显示接口(十一)
- (void)getProjectListWithusername:(NSString*)username
                       apptoken:(NSString *)apptoken
                       tabflag:(NSString *) tabflag
                             rflag:(NSString *)rflag
                             rpara:(NSString *)rpara
                           perpage:(NSString *)perpage
                           pagenum:(NSString *)pagenum
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))success
                           fail:(void (^)(id errorString))fail
{
   // NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",apptoken,@"apptoken",tabflag,@"tabflag",rflag,@"rflag",rpafa,@"rpafa",perpage,"perpage",pagenum,@"pagenum",nil];
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:username forKey:@"username"];
    [dic setObject:apptoken forKey:@"apptoken"];
    [dic setObject: tabflag forKey:@"tabflag"];
    [dic setObject:rflag forKey:@"rflag"];
    [dic setObject:rpara forKey:@"rpara"];
    [dic setObject:perpage forKey:@"perpage"];
    [dic setObject:pagenum forKey:@"pagenum"];

    NSLog(@"---------上传服务器的数据----- dic %@-------",dic);
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getprojectlist",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:success
                            failure:fail];
    
}
#pragma -mark -融资进程部分接口（二十四)
- (void)getProjectInvestorWithusername:(NSString*)username
                          apptoken:(NSString *)apptoken
                          projectid:(NSString *)projectid
                          tabflag:(NSString *)tabflag
                          hudDic:(NSDictionary*)hudDic
                          success:(void (^)(id responseDic))success
                              fail:(void (^)(id errorString))fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",apptoken,@"apptoken",projectid,@"projectid",tabflag,@"tabflag",nil];
    NSLog(@"---------上传服务器的数据---finance-- dic %@-------",dic);
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getprojectinvestor",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:success
                            failure:fail];
    
}
#pragma -mark -筛选部分选项（十九)
- (void)getProFilterOptWithusername:(NSString*)username
                              apptoken:(NSString *)apptoken
                              rflag:(NSString *)rflag
                                hudDic:(NSDictionary*)hudDic
                               success:(void (^)(id responseDic))success
                                  fail:(void (^)(id errorString))fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",apptoken,@"apptoken",rflag,@"rflag",nil];
    NSLog(@"---------上传服务器的数据----- dic %@-------",dic);
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getprofilteropt",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:success
                            failure:fail];
    
}


#pragma -mark ------------新版项目部分结束------------------------------------
#pragma -mark -上传文件使用http协议
//2014.06.24 chenlihua 上传文件使用HTTP协议
- (void)sendfileWithusername:(NSString*)username
                    apptoken:(NSString *)apptoken
                     msgtype:(NSString *)msgtype
                       files:(NSString *)files
                      hudDic:(NSDictionary*)hudDic
                     success:(void (^)(id responseDic))_success
                        fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[[UserInfo sharedManager] username],@"username",[[UserInfo sharedManager] apptoken],@"apptoken",msgtype,@"msgtype",files,@"files",nil];
    NSLog(@"---------向服务器发送文件消息----- dic %@-------",dic);
    
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@sendfile",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}

#pragma -mark -主页4个tab子页面消息数目
//chenlihua 2014.05.29 主页4个tab子页面消息数目
- (void)getdtypenumWithusername:(NSString*)username
                       apptoken:(NSString *)apptoken
                      pushtoken:(NSString *)pushtoken
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",pushtoken,@"pushtoken",nil];
    NSLog(@"---------主页4个tab子页面消息数目,上传服务器----- dic %@-------",dic);
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getdtypenum",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}
#pragma -mark -头像本地缓存接口
//chenlihua 2014.05.28 头像缓存本地接口。
- (void)getuserinfoHeadImageWithusername:(NSString*)username
                                apptoken:(NSString *)apptoken
                                  hudDic:(NSDictionary*)hudDic
                                 success:(void (^)(id responseDic))_success
                                    fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    NSLog(@"---------头像缓存本地接口,上传服务器----- dic %@-------",dic);
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getcmd",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}
#pragma http 判断 Locaid 发送是否成功-
-(void)getlocaidinServerWithusername:(NSString *)username
                            apptoken:(NSString *)apptoken
                             localid:(NSString *)localid
                              hudDic:(NSDictionary*)hudDic
                             success:(void (^)(id responseDic))_success
                                fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",localid,@"localid",nil];
    
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@chkmsg",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:_success
                            failure:_fail];
    
}


#pragma -mark -内部新消息提醒，增加接口，减消息。
//chenlihua 2014.05.09 内部新消息提醒，从由本地数据库查询，改为了从服务器返回。解决，有新消息时，点击到别的页面，回来后，新消息为0的问题。
- (void)setPushJobNumWithusername:(NSString*)username
                         apptoken:(NSString *)apptoken
                             dgid:(NSString *)dgid
                        pushtoken:(NSString *)pushtoken
                           jobnum:(NSString *)jobnum
                           hudDic:(NSDictionary*)hudDic
                          success:(void (^)(id responseDic))_success
                             fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",dgid,@"dgid",pushtoken,@"pushtoken",jobnum,@"jobnum",nil];
    
    //2014.08.05 chenlihua 重新修改dic
    /*
     NSMutableDictionary *dic=[NSMutableDictionary dictionary];
     [dic setObject:username forKey:@"username"];
     [dic setObject:[[UserInfo sharedManager] apptoken] forKey:@"apptoken"];
     [dic setObject:dgid forKey:@"dgid"];
     [dic setObject:pushtoken forKey:@"pushtoken"];
     [dic setObject:jobnum forKey:@"jobnum"];
     */
    
    
    
    NSLog(@"---------新消息清零，上传服务器----- dic %@-------",dic);
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@setpushjobnum",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma -mark -方创主页讨论组置顶
//2014.05.09 chenlihua 解决讨论组置顶的问题。
- (void)getDiscussionGroupSortWithusername:(NSString*)username
                                       did:(NSString *)did
                                     order:(NSString *)order
                                    hudDic:(NSDictionary*)hudDic
                                   success:(void (^)(id responseDic))_success
                                      fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",did,@"did",order,@"order",nil];
    NSLog(@"---------方创主页讨论组置顶排序----- dic %@-------",dic);
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@orderdisg",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}

#pragma  -mark -点击cell中的头像，获取联系人的详细信息
//2014.04.30 chenlihua 点击联系人的头像，获取联系人的详细信息
- (void)getHeadImageDetailInformationWithusername:(NSString*)username
                                           hudDic:(NSDictionary*)hudDic
                                          success:(void (^)(id responseDic))_success
                                             fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    NSLog(@"---------点击联系人的头像，获取联系人的详细信息------ dic %@-------",dic);
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getuserinfo",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}



#pragma  -mark -获取push token
//2014.04.24 chenlihua 信鸽推送
- (void)getPushTokenWithpushtoken:(NSString*)pushtoken
                           hudDic:(NSDictionary*)hudDic
                          success:(void (^)(id responseDic))_success
                             fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[[UserInfo sharedManager]username],@"username",[[UserInfo sharedManager] apptoken],@"apptoken",[[UIDevice currentDevice] uniqueDeviceIdentifier]  ,@"deviceid",pushtoken,@"pushtoken",@"4",@"devicetype", nil];
    
    //2014.08.07 chenlihua 测试pushtoken
    /*
     NSMutableDictionary *dic=[NSMutableDictionary dictionary];
     [dic setObject:[[UserInfo sharedManager]username] forKey:@"username"];
     [dic setObject:[[UserInfo sharedManager] apptoken] forKey:@"apptoken"];
     [dic setObject:[[UIDevice currentDevice] uniqueDeviceIdentifier] forKey:@"deviceid"];
     [dic setObject:pushtoken forKey:pushtoken];
     [dic setObject:@"devicetype" forKey:@"4"];
     */
    
    
    NSLog(@"----------传服务器的PushToken----- dic %@-------",dic);
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getpushtoken",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}

#pragma -mark -获取登陆token

- (void)getTokenWithdeviceid:(NSString*)deviceid
                      hudDic:(NSDictionary*)hudDic
                     success:(void (^)(id responseDic))_success
                        fail:(void (^)(id errorString))_fail
{
    showHud = 1;
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:deviceid,@"deviceid", nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getapptoken",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
    
}


#pragma mark-企业团队
-(void)getproteamWithUsername:(NSString *)username
                    projectid:(NSString *)projectid
                       hudDic:(NSDictionary *)hudDic
                      success:(void (^)(id))_success
                         fail:(void (^)(id))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",projectid ,@"projectid",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getproteam",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}

#pragma mark - 登陆获取验证码

- (void)GetLoginVerificationCodeWithusername:(NSString*)username
                                      hudDic:(NSDictionary*)hudDic
                                     success:(void (^)(id responseDic))_success
                                        fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UIDevice currentDevice] uniqueDeviceIdentifier] ,@"deviceid",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getLoginVerificationCode",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}



#pragma mark - 登陆

- (void)LoginWithusername:(NSString*)username
                 password:(NSString*)password
         verificationcode:(NSString*)verificationcode
                   hudDic:(NSDictionary*)hudDic
                  success:(void (^)(id responseDic))_success
                     fail:(void (^)(id errorString))_fail
{
    
    //  NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",password,@"password",[[UIDevice currentDevice] uniqueDeviceIdentifier] ,verificationcode,@"verificationcode" ,@"deviceid",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    
    //解决登录后，ios7下能运行，ios7崩溃的问题。原因是dic中验证码为空
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",password,@"password",[[UIDevice currentDevice] uniqueDeviceIdentifier] ,@"verificationcode",@"verificationcode" ,@"deviceid",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    NSLog(@"****************dic %@",dic);
    
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@login",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
    
    
}
#pragma mark - 注册获取验证码

- (void)GetRegisterVerificationCodeWithuserphonenumber:(NSString*)userphonenumber
                                                hudDic:(NSDictionary*)hudDic
                                               success:(void (^)(id responseDic))_success
                                                  fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:userphonenumber,@"userphonenumber",[[UIDevice currentDevice] uniqueDeviceIdentifier] ,@"deviceid",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getRegisterVerificationCode",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}




#pragma mark - 注册

- (void)registerWithuseraccout:(NSString*)useraccout
                      password:(NSString*)password
                   userpicture:(NSString*)userpicture
                  registertype:(NSString*)registertype
              verificationcode:(NSString*)verificationcode
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail
{
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         verificationcode,@"verificationcode",
                         useraccout,@"mobile",
                         registertype,@"registertype",
                         userpicture,@"files",
                         password,@"password",
                         useraccout,@"username",
                         [[UIDevice currentDevice] uniqueDeviceIdentifier] ,@"deviceid",
                         [[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@register",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}

#pragma mark - 忘记密码
- (void)getPasswordWithUsername:(NSString*)username
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,[[UserInfo sharedManager]username],[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getpassword",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma  -mark - 用讨论组ID 获得讨论组详细信息

-(void)getdisginfoWithusername:(NSString *)username
                      apptoken:(NSString *)apptoken
                          dgid:(NSString*)dgid
                      hudDic:(NSDictionary*)hudDic
                     success:(void (^)(id responseDic))_success
                      fail:(void (^)(id errorString))_fail
{
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",dgid,@"dgid",nil];
        NSLog(@"clh方创部分获取群名称上传的数据%@",dic);
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getdisginfo",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:_success
                            failure:_fail];
    



}


#pragma  -mark  - 进入方创讨论组的首页
//2014.05.09 chenlihua 接口暂时整体改动。重写函数
- (void)indexWithusername:(NSString*)username
                    dtype:(NSString*)dtype
                  perpage:(NSString *)perpage
                  pagenum:(NSString *)pagenum
                   hudDic:(NSDictionary*)hudDic
                  success:(void (^)(id responseDic))_success
                     fail:(void (^)(id errorString))_fail
{
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",dtype,@"dtype",perpage,@"perpage",pagenum,@"pagenum",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    
    
    NSLog(@"-------获取群组----------------dic--%@",dic);
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@appindex",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}


#pragma mark - 主页
//2014.05.09 chenlihua 接口改动。暂时无用。
/*
 - (void)indexWithuserid:(NSString*)userid
 dtype:(NSString*)dtype
 hudDic:(NSDictionary*)hudDic
 success:(void (^)(id responseDic))_success
 fail:(void (^)(id errorString))_fail
 {
 
 NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"username",dtype,@"dtype",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
 
 [self formRequestWithUrlString :[NSString stringWithFormat:@"%@appindex",serverAddress]
 postParamDic : dic
 hudString : hudDic
 success:_success
 failure:_fail];
 
 }
 */


#pragma mark - 方创任务列表

- (void)getrecenttaskWithuserid:(NSString*)userid
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getrecenttask",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}

#pragma mark - 方创任务列表2
- (void)getAllTaskWithUsername:(NSString*)username
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getalltask",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 方创任务详情
- (void)getTaskInfoWithTaskid:(NSString*)taskid
                     username:(NSString*)username
                       hudDic:(NSDictionary*)hudDic
                      success:(void (^)(id responseDic))_success
                         fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:taskid,@"taskid",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@gettaskinfo",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}
#pragma mark-项目进度
- (void)getprojectscheduleWithProjectid:(NSString*)projectid
                               username:(NSString*)username
                                 hudDic:(NSDictionary*)hudDic
                                success:(void (^)(id responseDic))_success
                                   fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:projectid,@"projectid",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getprojectschedule",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}
#pragma mark - 项目进展列表

- (void)getallproboardWithuserid:(NSString*)userid
                         perpage:(NSString*)perpage
                          pageid:(NSString*)pageid
                          hudDic:(NSDictionary*)hudDic
                         success:(void (^)(id responseDic))_success
                            fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"username",perpage,@"perpage",pageid,@"pageid",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getallproboard",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}

#pragma mark - 项目进展详情
- (void)getBoradInfoWithBoardid:(NSString*)boardid
                       username:(NSString*)username
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:boardid,@"boardid",username,[[UserInfo sharedManager]username],[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getboardinfo",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 留言列表
- (void)getMessageListWithProjectid:(NSString*)proid
                           username:(NSString*)username
                             hudDic:(NSDictionary*)hudDic
                            success:(void (^)(id responseDic))_success
                               fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:proid,@"projectid",username,[[UserInfo sharedManager]username],[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getmessagelist",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 发表留言
- (void)sendMessageWithProjectid:(NSString*)proid
                           title:(NSString*)title
                         content:(NSString*)content
                        username:(NSString*)username
                          hudDic:(NSDictionary*)hudDic
                         success:(void (^)(id responseDic))_success
                            fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:proid,@"projectid",title,@"title",content,@"content",username,[[UserInfo sharedManager]username],[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@message",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}


//#pragma mark - 联系人列表
//
//- (void)getContactListWithuserid:(NSString*)userid
//                          hudDic:(NSDictionary*)hudDic
//                         success:(void (^)(id responseDic))_success
//                            fail:(void (^)(id errorString))_fail
//{
//    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
//    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getcontactlist",serverAddress]
//                      postParamDic : dic
//                         hudString : hudDic
//                            success:_success
//                            failure:_fail];
//}



#pragma mark - 项目列表
- (void)getProjectListWithusername:(NSString*)username
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail
{
    showHud = 1;
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getprojectlist",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 项目点击
- (void)sendeProjectClickWithProjectid:(NSString*)proid
                                 cflag:(NSString*)flag
                              username:(NSString*)username
                                hudDic:(NSDictionary*)hudDic
                               success:(void (^)(id responseDic))_success
                                  fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:proid,@"projectid",flag,@"cflag",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    
    NSLog(@".........sendeProjectClickWithProjectid.....%@",dic);
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@sendprojectclick",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 项目文档
- (void)getDocumentListWithProjectid:(NSString*)proid
                        documenttype:(NSString*)docuType
                            username:(NSString*)username
                              hudDic:(NSDictionary*)hudDic
                             success:(void (^)(id responseDic))_success
                                fail:(void (^)(id errorString))_fail
{
    
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:proid,@"projectid",docuType,@"docmenttype",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getdocmentlist",serverAddress]
                      postParamDic : dic
                         hudString : hudDic
                            success:_success
                            failure:_fail];
    /*
     dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
     dispatch_async(quueue, ^{
     [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getdocmentlist",serverAddress]
     postParamDic : dic
     hudString : hudDic
     success:_success
     failure:_fail];
     });
     */
}

#pragma mark - 商业计划
- (void)getBusinessPlanWithProjectid:(NSString*)proid
                            username:(NSString*)username
                              hudDic:(NSDictionary*)hudDic
                             success:(void (^)(id responseDic))_success
                                fail:(void (^)(id errorString))_fail
{
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:proid,@"projectid",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getbusinessplan",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}

#pragma mark - 融资方案
- (void)getFinancingPlanWithProjectid:(NSString*)proid
                             username:(NSString*)username
                               hudDic:(NSDictionary*)hudDic
                              success:(void (^)(id responseDic))_success
                                 fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:proid,@"projectid",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getfinancingplan",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 法务
- (void)getLawworksListWithProjectid:(NSString*)proid
                            username:(NSString*)username
                              hudDic:(NSDictionary*)hudDic
                             success:(void (^)(id responseDic))_success
                                fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:proid,@"projectid",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getlawworkslist",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 方创观点
- (void)getFangchuangStandpointWithProjectid:(NSString*)proid
                                    username:(NSString*)username
                                      hudDic:(NSDictionary*)hudDic
                                     success:(void (^)(id responseDic))_success
                                        fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:proid,@"projectid",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getfcstandpoint",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 财务模型
- (void)getFinancialPlanWithProjectid:(NSString*)proid
                                cyear:(NSString*)year
                             username:(NSString*)username
                               hudDic:(NSDictionary*)hudDic
                              success:(void (^)(id responseDic))_success
                                 fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:proid,@"projectid",year,@"cyear",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    NSLog(@"----财务模型---dic---%@",dic);
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getfmlist",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}

#pragma mark - 项目投资人
- (void)getProjectInvestorWithProjectid:(NSString*)proid
                               username:(NSString*)username
                                 hudDic:(NSDictionary*)hudDic
                                success:(void (^)(id responseDic))_success
                                   fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:proid,@"projectid",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getprojectinvestor",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 轮次
- (void)getRoundsWithProjectid:(NSString*)proid
                       roundid:(NSString*)roundid
                      username:(NSString*)username
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:proid,@"projectid",roundid,@"roundid",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getrounds",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 见面记录详情
- (void)getMeetingDetailWithMeetid:(NSString*)meetid
                          username:(NSString*)username
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:meetid,@"meetid",username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getmeetingdetail",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}


#pragma mark -聊天信息提交

- (void)senddiscussionWithusername:(NSString*)username
                               did:(NSString*)did
                           msgtype:(NSString*)msgtype
                           msgtext:(NSString*)msgtext
                      opendatetime:(NSString*)opendatetime
                            openby:(NSString*)openby
                             files:(NSString*)files
                              vsec:(NSString*)vsec
                            locaid:(NSString *)locaid
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail
{
    showHud = 1 ;
    
    /*
     NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
     username,@"username",
     did,@"did",
     msgtype,@"msgtype",
     opendatetime,@"opendatetime",
     openby,@"openby",
     msgtext,@"msgtext",
     files,@"files",
     vsec,@"vsec",
     [[UserInfo sharedManager] apptoken],@"apptoken",nil];
     */
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    [dic setObject:username forKey:@"username"];
    [dic setObject:did forKey:@"did"];
    [dic setObject:msgtype forKey:@"msgtype"];
    [dic setObject:opendatetime forKey:@"opendatetime"];
    [dic setObject:openby forKey:@"openby"];
    [dic setObject:msgtext forKey:@"msgtext"];
    [dic setObject:files forKey:@"files"];
    [dic setObject:vsec forKey:@"vsec"];
    //2014.08.05 chenlihua 增加localid。
    [dic setObject:locaid forKey:@"localid"];
    
    if (![[UserInfo sharedManager] apptoken] ) {
        [dic setObject:@"" forKey:@"apptoken"];
        
    }else
    {
        [dic setObject:[[UserInfo sharedManager] apptoken] forKey:@"apptoken"];
        
    }
    
    
    NSLog(@"-------服务器接口函数中，files--%@---",files);
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@senddiscussion",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}



- (void)senddiscussionWithusername:(NSString*)username
                               did:(NSString*)did
                           msgtype:(NSString*)msgtype
                          msgterxt:(NSString*)msgtext
                      opendatetime:(NSString*)opendatetime
                            openby:(NSString*)openby
                            locaid:(NSString *)locaid
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail
{
    showHud = 1 ;
    
    /*
     NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
     username,@"username",
     did,@"did",
     msgtype,@"msgtype",
     opendatetime,@"opendatetime",
     openby,@"openby",
     msgtext,@"msgtext",
     [[UserInfo sharedManager] apptoken],@"apptoken",nil];
     */
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    [dic setObject:username forKey:@"username"];
    [dic setObject:did forKey:@"did"];
    [dic setObject:msgtype forKey:@"msgtype"];
    [dic setObject:opendatetime forKey:@"opendatetime"];
    [dic setObject:openby forKey:@"openby"];
    [dic setObject:msgtext forKey:@"msgtext"];
    
    //2014.08.05 chenlihua 增加localid。
    [dic setObject:locaid forKey:@"localid"];
    
    if (![[UserInfo sharedManager] apptoken]) {
        [dic setObject:@"" forKey:@"apptoken"];
    }else{
        [dic setObject:[[UserInfo sharedManager] apptoken] forKey:@"apptoken"];
    }
    
    
    
    NSLog(@"-------服务器接口函数中，content--%@---",msgtext);
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@senddiscussion",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    NSLog(@"-------服务器接口函数完成，content--%@---",msgtext);
}


#pragma mark - 接收消息

- (void)getdiscussionWithusername:(NSString*)username
                              did:(NSString*)did
                        rdatetime:(NSString*)rdatetime
                            dflag:(NSString*)dflag
                          perpage:(NSString*)perpage
                           hudDic:(NSDictionary*)hudDic
                            msgid:(NSString *)msgid
                          success:(void (^)(id responseDic))_success
                             fail:(void (^)(id errorString))_fail
{
    
    showHud = 1;
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",did,@"did",rdatetime,@"rdatetime",dflag,@"dflag",perpage,@"perpage",[[UserInfo sharedManager] apptoken],@"apptoken",msgid,@"msgid",nil];
    NSLog(@"%@",dic);
    

        
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getdiscussion",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
        

    
}

#pragma mark - 联系人列表

- (void)getcontactlistWithusername:(NSString*)username
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail
{
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getcontactlist",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}

#pragma mark - 联系人简介

- (void)contactlistdetail:(NSString*)contactid
                 username:(NSString *)username
                   hudDic:(NSDictionary*)hudDic
                  success:(void (^)(id responseDic))_success
                     fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:contactid,@"contactid",username, @"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@contactlistdetail",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 修改头像
- (void)SetUserPhotoWithUsername:(NSString*)username
                     userpicture:(NSString*)userpicture
                          hudDic:(NSDictionary*)hudDic
                         success:(void (^)(id responseDic))_success
                            fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",userpicture,@"files",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@setuserphoto",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}
#pragma mark - 我的资料

-(void)getuserinfoWithUsername:(NSString *)username
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getuserinfo",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
    
}
#pragma mark - 编辑我的资料
-(void)setUserInfoWithUsername:(NSString *)username user_name:(NSString *)realnamename usergender:(NSString *)gender  post:(NSString *)post base:(NSString *)base comname:(NSString *)comname email:(NSString *)email fmoney:(NSString *)fmoney statge:(NSString *)statge frounds2:(NSString *)frounds2 pdesc:(NSString *)pdesc teamsize:(NSString *)teamsize industry:(NSString *)industry currency:(NSString *)currency apptoken:(NSString *)apptoken hudDic:(NSDictionary *)hudDic success:(void (^)(id))_success fail:(void (^)(id))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",
                         realnamename,@"realname",
                         gender,@"usergender",
                         post,@"post",
                         base,@"base",
                         comname,@"comname",
                         email,@"email",
                          fmoney,@"fmoney",
                         statge,@"statge",
                         frounds2,@"frounds2",
                         pdesc,@"pdesc",
                         teamsize,@"teamsize",
                         industry,@"industry",
                         currency,@"currency",
                         [[UserInfo sharedManager] apptoken],@"apptoken",nil];
    NSLog(@"%@",dic);
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@setuserinfo",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}



#pragma mark - 修改密码
- (void)changePasswordWithUsername:(NSString*)username
                       oldpassword:(NSString*)oldpassword
                       newpassword:(NSString*)newpassword
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",oldpassword,@"oldpassword",newpassword,@"newpassword",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@changepassword",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 修改群聊名称
- (void)changeDiscussNameWithUsername:(NSString*)username
                                  did:(NSString*)did
                              newname:(NSString*)newname
                               hudDic:(NSDictionary*)hudDic
                              success:(void (^)(id responseDic))_success
                                 fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",did,@"did",newname,@"newname",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@chgdisname",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 删除群组
- (void)deleteDisCussWithUsername:(NSString*)username
                              did:(NSString*)did
                           hudDic:(NSDictionary*)hudDic
                          success:(void (^)(id responseDic))_success
                             fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",did,@"did",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@deletedisg",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}

#pragma mark - 日程主界面
- (void)getScheduleListWithUsername:(NSString*)username
                          startdate:(NSString*)startdate
                            enddate:(NSString*)enddate
                             hudDic:(NSDictionary*)hudDic
                            success:(void (^)(id responseDic))_success
                               fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",startdate,@"startdate",enddate,@"enddate",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@schedulelist",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}
#pragma mark-日程创建
-(void)schedulecreateWithUsername:(NSString *)username
                            sdate:(NSString *)sdate
                            stime:(NSString *)stime
                            etime:(NSString *)etime
                           attend:(NSString *)attend
                              pri:(NSString *)pri
                          project:(NSString *)project
                            sname:(NSString *)sname
                            sdesc:(NSString *)sdesc
                         location:(NSString *)location
                        alertmode:(NSString *)alertmode
                            alert:(NSString *)alert
                           hudDic:(NSDictionary *)hudDic
                          success:(void (^)(id))_success
                             fail:(void (^)(id))_fail
{
    
    /* NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
     username,@"username",
     [[UserInfo sharedManager] apptoken],@"apptoken",
     sdate,@"sdate",
     stime,@"stime",
     etime,@"etime",
     attend,@"attend",
     pri,@"pri",
     project,@"project",
     sname,@"sname",
     sdesc,@"sdesc",
     location,@"location",
     alert,@"alert",nil];
     */
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:username forKey:@"username"];
    [dic setObject:[[UserInfo sharedManager] apptoken] forKey:@"apptoken"];
    [dic setObject:sdate forKey:@"sdate"];
    [dic setObject:stime forKey:@"stime"];
    [dic setObject:etime forKey:@"etime"];
    [dic setObject:attend forKey:@"attend"];
    [dic setObject:pri forKey:@"pri"];
    [dic setObject:project forKey:@"project"];
    [dic setObject:sname forKey:@"sname"];
    [dic setObject:sdesc forKey:@"sdesc"];
    [dic setObject:location forKey:@"location"];
    [dic setObject:alert forKey:@"alert"];
    
    
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        NSLog(@"---dic---%@",dic);
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@schedulecreate",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
    
    
    
}

#pragma mark - 日程删除
-(void)scheduledelWithUsername:(NSString *)username
             andWithScheduleid:(NSString *)scheduleid
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail

{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",scheduleid,@"scheduleid",nil];
    
    NSLog(@"----dic---%@",dic);
    
    
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@scheduledel",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
}
#pragma mark-日程参与人用户列表
-(void)scheduleacclistWithUsername:(NSString *)username
                         projectid:(NSString *)projectid
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail{
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",projectid,@"projectid",nil];
    showHud = 1;
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@scheduleacclist",serverAddress]
                          postParamDic : dic
                             hudString : nil
                                success:_success
                                failure:_fail];
    });
    
    
    
}
#pragma mark-项目关键字搜索项目列表
-(void)prosearchWithUsername:(NSString *)username
                      search:(NSString *)search
                      hudDic:(NSDictionary*)hudDic
                     success:(void (^)(id responseDic))_success
                        fail:(void (^)(id errorString))_fail{
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",[[UserInfo sharedManager] apptoken],@"apptoken",search,@"search",nil];
    showHud = 1;
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@prosearch",serverAddress]
                          postParamDic : dic
                             hudString : nil
                                success:_success
                                failure:_fail];
    });
    
    
    
}

#pragma mark - 日程编辑

-(void)scheduleeditWithUsername:(NSString *)username
                     scheduleid:(NSString *)scheduleid
                          sdate:(NSString *)sdate
                          stime:(NSString *)stime
                          etime:(NSString *)etime
                         attend:(NSString *)attend
                            pri:(NSString *)pri
                        project:(NSString *)project
                          sname:(NSString *)sname
                          sdesc:(NSString *)sdesc
                       location:(NSString *)location
                      alertmode:(NSString *)alertmode
                          alert:(NSString *)alert
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         username,@"username",
                         [[UserInfo sharedManager] apptoken],@"apptoken",
                         scheduleid,@"scheduleid",
                         sdate,@"sdate",
                         stime,@"stime",
                         etime,@"etime",
                         attend,@"attend",
                         pri,@"pri",
                         project,@"project",
                         sname,@"sname",
                         sdesc,@"sdesc",
                         location,@"location",
                         alert,@"alert",nil];
    NSLog(@"---dic---%@",dic);
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@scheduleedit",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    
    
    
}

#pragma mark - 与方创沟通获取talkid
-(void)getcallidWithUsername:(NSString *)username
               withprojectid:(NSString *)projectid
             andWithCallflag:(NSString *)callflag
                      hudDic:(NSDictionary*)hudDic
                     success:(void (^)(id responseDic))_success
                        fail:(void (^)(id errorString))_fail

{
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         username,@"username",
                         [[UserInfo sharedManager] apptoken],@"apptoken",
                         projectid,@"projectid",
                         callflag,@"callflag",
                         nil];
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getcallid",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
}


#pragma mark - 讨论组—获得会话Id
- (void)getdid_by121Withusername:(NSString*)username
                          sendto:(NSString*)sendto
                          hudDic:(NSDictionary*)hudDic
                         success:(void (^)(id responseDic))_success
                            fail:(void (^)(id errorString))_fail
{
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         username,@"username",
                         [[UserInfo sharedManager] apptoken],@"apptoken",
                         sendto,@"sendto",
                         nil];
    NSLog(@"%@",dic);
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getdid_by121",serverAddress]
                          postParamDic : dic
                             hudString : hudDic
                                success:_success
                                failure:_fail];
    });
    //2014.07.04 chenlihua 无法给联系人里的投资人发消息，接口错误，修改接口。
    /*
     [self formRequestWithUrlString :[NSString stringWithFormat:@"%@getcallid",serverAddress]
     postParamDic : dic
     hudString : hudDic
     success:_success
     failure:_fail];
     */
}




#pragma mark - 方创内部联系人列表

- (void) getdiscussion_ulistWithuserName:(NSString*)username
                                  hudDic:(NSDictionary*)hudDic
                                 success:(void (^)(id responseDic))_success
                                    fail:(void (^)(id errorString))_fail
{
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username , @"username",[[UserInfo sharedManager] apptoken],@"apptoken", nil];
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString:[NSString stringWithFormat:@"%@getdiscussion_ulist",serverAddress]
                          postParamDic:dic
                             hudString:hudDic
                               success:_success
                               failure:_fail];
    });
    
    
}
#pragma -mark -群组增加新成员
//2014.04.25 chenlihua 群组增加新成员
- (void)createGroupMemberWithusername:(NSString*)username
                                  did:(NSString*)did
                            grpmember:(NSString*)grpmemeber
                               hudDic:(NSDictionary*)hudDic
                              success:(void (^)(id responseDic))_success
                                 fail:(void (^)(id errorString))_fail
{
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username , @"username",did, @"did",grpmemeber ,@"grpmember",[[UserInfo sharedManager] apptoken],@"apptoken", nil];
    
    NSLog(@"----添加新成员操作--dic-----%@-----",dic);
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString:[NSString stringWithFormat:@"%@adddisgmem",serverAddress]
                          postParamDic:dic
                             hudString:hudDic
                               success:_success
                               failure:_fail];
    });
    
    
}


#pragma mark - 创建讨论组
- (void)createdisWithusername:(NSString*)username
                      members:(NSString*)members
                       hudDic:(NSDictionary*)hudDic
                      success:(void (^)(id responseDic))_success
                         fail:(void (^)(id errorString))_fail
{
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username , @"username",members , @"members",[[UserInfo sharedManager] apptoken],@"apptoken", nil];
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString:[NSString stringWithFormat:@"%@createdis",serverAddress]
                          postParamDic:dic
                             hudString:hudDic
                               success:_success
                               failure:_fail];
    });
    
    
}
#pragma mark - 讨论组成员

- (void)getgrpmembersWithusername:(NSString*)username
                             dgid:(NSString*)dgid
                           hudDic:(NSDictionary*)hudDic
                          success:(void (^)(id responseDic))_success
                             fail:(void (^)(id errorString))_fail
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username , @"username",dgid , @"dgid",[[UserInfo sharedManager] apptoken],@"apptoken", nil];
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        [self formRequestWithUrlString:[NSString stringWithFormat:@"%@getgrpmembers",serverAddress]
                          postParamDic:dic
                             hudString:hudDic
                               success:_success
                               failure:_fail];
    });
    
}
#pragma mark - 删除成员

- (void)deletedisgWithusername:(NSString*)username
                           did:(NSString*)did
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail
{
      [Utils hudShow];
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username , @"username",did , @"did",[[UserInfo sharedManager] apptoken],@"apptoken",nil];
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
       
        [self formRequestWithUrlString:[NSString stringWithFormat:@"%@deletedisg",serverAddress]
                          postParamDic:dic
                             hudString:hudDic
                               success:_success
                               failure:_fail];
    });
    
}

#pragma mark - 退出群组

- (void)retreatdisgWithusername:(NSString*)username
                            did:(NSString*)did
                      grpmember:(NSString*)grpmember
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail
{
    // NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username , @"username",did , @"did",[[UserInfo sharedManager] apptoken],grpmember,@"grpmember",@"apptoken", nil];
    //2014.05.04 chenlihua 群主删除群成员
    dispatch_queue_t queue = dispatch_queue_create("gcd", NULL);
    dispatch_async(queue, ^{
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:username , @"username",did , @"did",grpmember,@"grpmember",[[UserInfo sharedManager] apptoken],@"apptoken", nil];
        [self formRequestWithUrlString:[NSString stringWithFormat:@"%@retreatdisg",serverAddress]
                          postParamDic:dic
                             hudString:hudDic
                               success:_success
                               failure:_fail];
    });
}


//************************************* 华丽丽的分割线 *************************************//
//****************************************************************************************//
/*
 #pragma mark - 网络请求入口
 - (void) sendRequestWithUrlString : (NSString*) _urlString
 hudString : (NSDictionary*) hudDic
 success:(void (^)(id responseDic)) _success
 failure:(void(^)(id errorString)) _failure
 {
 if (!hudDic) {
 [Utils hudShow];
 }
 else
 {
 NSString *showStr = [hudDic objectForKey:@"show"];
 if (showStr) {
 [Utils hudShow:showStr];
 }
 else
 {
 [Utils hudShow];
 }
 }
 
 _urlString = [Utils getEncodingWithUTF8:_urlString];
 NSLog(@"_urlString : %@" , _urlString);
 __block ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
 [request setUseCookiePersistence:NO];
 [request startAsynchronous];
 [request setCompletionBlock:^{
 //        NSLog(@"completion : %@" , request.responseString);
 NSUInteger location = [request.responseString rangeOfString:@"{"].location;
 NSUInteger length = [request.responseString length] - location;
 NSRange range = NSMakeRange(location, length);
 NSString *resoponse = [request.responseString substringWithRange:range];
 
 resoponse = [resoponse stringByReplacingOccurrencesOfString:@"\r" withString:@"*1*"];
 resoponse = [resoponse stringByReplacingOccurrencesOfString:@"\n" withString:@"*2*"];
 resoponse = [resoponse stringByReplacingOccurrencesOfString:@"&lt;" withString:@"*3*"];
 resoponse = [resoponse stringByReplacingOccurrencesOfString:@"<p>" withString:@"*4*"];
 resoponse = [resoponse stringByReplacingOccurrencesOfString:@"</p>" withString:@"*5*"];
 resoponse = [resoponse stringByReplacingOccurrencesOfString:@"&gt;" withString:@"*6*"];
 resoponse = [resoponse stringByReplacingOccurrencesOfString:@"&amp;" withString:@"*7*"];
 resoponse = [resoponse stringByReplacingOccurrencesOfString:@"nbsp;" withString:@"*8*"];
 resoponse = [resoponse stringByReplacingOccurrencesOfString:@"\t" withString:@"*9*"];
 
 
 
 [request clearDelegatesAndCancel];
 JSONDecoder* jd = [[JSONDecoder alloc] init];
 //        SBJson4Parser *jsonParser = [[SBJson4Parser alloc] init];
 NSError *error = nil;
 
 //        NSMutableDictionary *responseDic = [jsonParser objectWithString:resoponse error:&error];
 //        [jsonParser release];
 //response 这里会出错！
 NSMutableDictionary *responseDic = [jd objectWithData:[resoponse JSONData] error:&error];
 
 
 if (error) {
 if (!hudDic) {
 [Utils hudFailHidden];
 }
 else
 {
 NSString *failStr = [hudDic objectForKey:@"fail"];
 if (failStr) {
 [Utils hudFailHidden:failStr];
 }
 else
 {
 [Utils hudFailHidden];
 }
 }
 _failure([error localizedDescription]);
 return ;
 }
 if (responseDic == nil) {
 NSDictionary *userInfo=[NSDictionary dictionaryWithObjectsAndKeys:@"网络连接出错",NSLocalizedDescriptionKey, nil];
 NSError *customError=[NSError errorWithDomain:@"xingka" code:500 userInfo:userInfo];
 if (!hudDic) {
 [Utils hudFailHidden];
 }
 else
 {
 NSString *failStr = [hudDic objectForKey:@"fail"];
 if (failStr) {
 [Utils hudFailHidden:failStr];
 }
 else
 {
 [Utils hudFailHidden];
 }
 }
 _failure(customError);
 
 }else {
 //            NSLog(@"responseDic : %@" , responseDic);
 int status=[[responseDic objectForKey:@"status"] intValue];
 if (status == 0) {
 //请求成功
 if (!hudDic) {
 [Utils hudSuccessHidden];
 }
 else
 {
 NSString *successStr = [hudDic objectForKey:@"success"];
 if (successStr) {
 [Utils hudSuccessHidden:successStr];
 }
 else
 {
 [Utils hudSuccessHidden];
 }
 }
 _success(responseDic);
 
 }
 else
 {
 //请求失败
 NSString *resultString=[responseDic objectForKey:@"msg"];
 if (!hudDic) {
 [Utils hudFailHidden];
 }
 else
 {
 NSString *failStr = [hudDic objectForKey:@"fail"];
 if (failStr) {
 [Utils hudFailHidden:failStr];
 }
 else
 {
 [Utils hudFailHidden];
 }
 }
 _failure(resultString);
 }
 }
 [request release];
 }];
 [request setFailedBlock:^{
 [request clearDelegatesAndCancel];
 NSString *errorMsg = @"网络连接失败";
 if (!hudDic) {
 [Utils hudFailHidden];
 }
 else
 {
 NSString *failStr = [hudDic objectForKey:@"fail"];
 if (failStr) {
 [Utils hudFailHidden:failStr];
 }
 else
 {
 [Utils hudFailHidden];
 }
 }
 _failure(errorMsg);
 [request release];
 }];
 }
 
 */



#pragma mark - form请求入口
- (void) formRequestWithUrlString : (NSString*) _urlString
                     postParamDic : (NSDictionary*) _postParamDic
                        hudString : (NSDictionary*) hudDic
                           success:(void (^)(id responseDic)) _success
                           failure:(void(^)(id errorString)) _failure
{
    if (showHud == 0) {
        if (!hudDic) {
            // NSString *showStr = [hudDic objectForKey:@"show"];
            NSLog(@"-----进入if (!hudDic)----if----");
            [Utils hudShow];
        }
        else
        {
            NSLog(@"-----进入if (!hudDic)--else------");
            NSString *showStr = [hudDic objectForKey:@"show"];
            if (showStr) {
                [Utils hudShow:showStr];
            }
            else
            {
                [Utils hudShow];
            }
        }
        
    }
    
    //2014.06.20 chenlihua 获取中文字符串转码utf8
    _urlString = [Utils getEncodingWithUTF8:_urlString];
    NSLog(@"_urlString : %@" , _urlString);
    __block ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    // 设置 cookie 使用策略：不使用
    [request setUseCookiePersistence:NO];
    
    if(_postParamDic!=nil)
    {
        NSLog(@"-----进入if(_postParamDic!=nil)中------------");
        
        for (NSString *keyString in [_postParamDic allKeys]) {
            NSLog(@"keyString : %@" , keyString);
            NSLog(@"vaule : %@" , [_postParamDic objectForKey:keyString]);
            
            if (  [keyString isEqualToString:@"userpicture"] || [keyString isEqualToString:@"files"]) {
                [request addFile:[_postParamDic objectForKey:keyString] forKey:keyString];
            }
            else
            {
                [request addPostValue:[_postParamDic objectForKey:keyString] forKey:keyString];
            }
            
        }
        
    }
    [request startAsynchronous];
    [request setCompletionBlock:^{
        NSLog(@"completion : ---%@--" , request.responseString);
        
        NSLog(@"-----------进入[request setCompletionBlock:--------------");
        NSString* reStr = request.responseString;
        
        //接口返回的错误数据都是乱码，前段做处理
        
        reStr = [reStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSLog(@"reStr = %@",reStr);
        
        if (reStr.length == 0) {
            [Utils hudFailHidden:@"接口数据错误"];
            return ;
        }
        
        
        NSRange rangeStr = [reStr rangeOfString:@"<html>"];
        
        
        if (rangeStr.length != 0 ) {
            
            NSLog(@"-------进入if (rangeStr.length != 0 )-------");
            [Utils hudFailHidden];
            return ;
        }
        
        
        //        NSUInteger location = [request.responseString rangeOfString:@"{"].location;
        //        NSUInteger length = [request.responseString length] - location;
        //        NSRange range = NSMakeRange(location, length);
        //        NSString *resoponse = [request.responseString substringWithRange:range];
        //        [request clearDelegatesAndCancel];
        
        //        JSONDecoder* jd = [[JSONDecoder alloc] init];
        
        
        NSError *error = nil;
        
          //   NSMutableDictionary *responseDic = [jd objectWithData:request.responseData error:&error];
       id responseDic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"----------error----%@----",error);
        NSLog(@"---responseDic-----%@---",responseDic);
        NSLog(@"--------进入id responseDic = [NSJSONSerialization JSONObjectWithData下-----");
        
        if (error) {
            NSLog(@"----进入if (error) -------");
            if (showHud == 0) {
                NSLog(@"-----进入if (showHud == 0)-------");
                if (!hudDic) {
                    NSLog(@"--------进入if (!hudDic)----if------");
                    [Utils hudFailHidden];
                }
                else
                {
                    NSLog(@"--------进入if (!hudDic)---else-------");
                    NSString *failStr = [hudDic objectForKey:@"fail"];
                    if (failStr) {
                        [Utils hudFailHidden:failStr];
                    }
                    else
                    {
                        [Utils hudFailHidden];
                    }
                }
            }
            NSLog(@"--------进入_failure([error localizedDescription]);-----上");
            
            _failure([error localizedDescription]);
            NSLog(@"------return----上面-----");
            return ;
        }
        if (responseDic == nil) {
            //            NSDictionary *userInfo=[NSDictionary dictionaryWithObjectsAndKeys:@"网络连接出错",NSLocalizedDescriptionKey, nil];
            //            NSError *customError=[NSError errorWithDomain:@"xingka" code:500 userInfo:userInfo];
            if (showHud == 0) {
                if (!hudDic) {
                    [Utils hudFailHidden];
                }
                else
                {
                    NSString *failStr = [hudDic objectForKey:@"fail"];
                    if (failStr) {
                        [Utils hudFailHidden:failStr];
                    }
                    else
                    {
                        [Utils hudFailHidden];
                    }
                }
            }
            //            _failure(customError);
        }else {
            
            
            int status=[[responseDic objectForKey:@"status"] intValue];
            if (status == 0) {
                //请求成功
                if (showHud == 0) {
                    if (!hudDic) {
                        NSLog(@"************if(!hudDic)**********");
                        [Utils hudSuccessHidden];
                    }
                    else
                    {
                        NSLog(@"************if(!hudDic) else**********");
                        NSString *successStr = [hudDic objectForKey:@"success"];
                        if (successStr) {
                            [Utils hudSuccessHidden:successStr];
                        }
                        else
                        {
                            [Utils hudSuccessHidden];
                        }
                    }
                }
                
                _success(responseDic);
                
                
                NSLog(@"----1111111----进入到_success(responseDic);下面完成--------");
                
            }
            else
            {
                //请求失败
                NSString *resultString=[responseDic objectForKey:@"msg"];
               UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:resultString message:@"接口返回的错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好", nil];
//               [myalert show];
                NSLog(@"----------错误原因-------%@",resultString);
                if (!hudDic) {
                    
                    //2014.04.26 chenlihua 解决联系人添加重复时，弹出网络连接的情况，
                    //而不是弹出提示添加联系人重复。注释掉，在客户端处理此种情况。
                    //  [Utils hudFailHidden];
                    [Utils hudFailHidden:resultString];
                    
                }
                else
                {
                    NSString *failStr = [hudDic objectForKey:@"fail"];
                    
                    if (showHud == 0) {
                        if (failStr) {
                            [Utils hudFailHidden:failStr];
                        }
                        else
                        {
                            [Utils hudFailHidden];
                        }
                    }
                }
                _failure(resultString);
            }
        }
        NSLog(@"----1111111----1111111-------");
        [request release];
        NSLog(@"----1111111----1111111---1111111----");
        showHud = 0 ;
        NSLog(@"2222222");
    }];
    [request setFailedBlock:^{
        
        NSLog(@"-------进入request setFailedBlock----------------");
        
        [request clearDelegatesAndCancel];
        
        NSString *errorMsg = @"网络连接失败";
        
        if (showHud == 0) {
            if (!hudDic) {
                
                [Utils hudFailHidden];
            }
            else
            {
                NSString *failStr = [hudDic objectForKey:@"fail"];
                if (failStr) {
                    [Utils hudFailHidden:failStr];
                }
                else
                {
                    [Utils hudFailHidden];
                }
            }
        }
        
        _failure(errorMsg);
        
        [request release];
        showHud = 0;
    }];
    
    
}



#pragma mark - PDF 文件下载

- (NSString*)GetPDFWithUrl:(NSString*)url
{


    NSString* name = [url stringByReplacingOccurrencesOfString:@"/" withString:@""];
 
    NSString* path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];

    
    [Utils hudShow:@"正在获取文档"];
    

    
    // http://fcapp.favalue.com/data/upload/1/201402/27/2718033203432a6d.pdf
    ASIHTTPRequest* request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    // [request setUseCookiePersistence:NO];
    [request setDownloadDestinationPath:path];
    [request setCompletionBlock:^{
        
        [Utils hudSuccessHidden:@"文档获取成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:PDFDOCMENTDIDGOT object:path];
        
    }];
    
    
    [request setFailedBlock:^{
        [Utils hudSuccessHidden:@"文档获取失败"];
        [[NSNotificationCenter defaultCenter] postNotificationName:PDFDOCMENTDIDGOT object:@"error"];
        
    }];
    
    [request startAsynchronous];
    [request release];
    
    return nil;
}


@end
