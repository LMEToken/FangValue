//
//  NetManager.h
//  RongYi
//
//  Created by wen yu on 13-5-23.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "RSAEncode.h"
//#import "GTMBase64.h"
extern  NSString* const PDFDOCMENTDIDGOT;

@interface NetManager : NSObject

+ (id)sharedManager;

#pragma -mark ------------新版项目部分---------------------------------------

#pragma -mark -跟进信息接口
- (void)getpipinfoWithUsername:(NSString*)username
                      apptoken:(NSString *)apptoken
                     projectid:(NSString *)projectid
                          piid:(NSString *)piid
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail;

#pragma -mark -选择身份的时候显示土豪
- (void)gethaonumWithUsername:(NSString*)username
                     apptoken:(NSString *)apptoken
                       hudDic:(NSDictionary*)hudDic
                      success:(void (^)(id responseDic))_success
                         fail:(void (^)(id errorString))_fail;

#pragma -mark --上传名片
- (void)uptcardWithUsername:(NSString*)username
                   apptoken:(NSString *)apptoken
                userpicture:(NSString *)userpicture
                     hudDic:(NSDictionary*)hudDic
                    success:(void (^)(id responseDic))_success
                       fail:(void (^)(id errorString))_fail;


#pragma -mark --忘记密码接口
- (void)resetPasswordWithusername:(NSString*)username
                         apptoken:(NSString *)apptoken
                       verifycode:(NSString *)verifycode
                      newpassword:(NSString *)newpassword
                           hudDic:(NSDictionary*)hudDic
                          success:(void (^)(id responseDic))success
                             fail:(void (^)(id errorString))fail;


#pragma -mark -获取验证码接口
- (void)GetverifycodeWithmobile:(NSString*)mobile
                       apptoken:(NSString *)apptoken
                          rflag:(NSString *) rflag
                       deviceid:(NSString *)deviceid
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))success
                           fail:(void (^)(id errorString))fail;


#pragma -mark -项目关注部分接口（十一)
- (void)getProjectLikeWithusername:(NSString*)username
                          apptoken:(NSString *)apptoken
                             rflag:(NSString *) rflag
                         projectid:(NSString *)projectid
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))success
                              fail:(void (^)(id errorString))fail;
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
                           fail:(void (^)(id errorString))fail;
#pragma -mark -项目部分列表,筛选部分显示接口
- (void)getProjectListWithusername:(NSString*)username
                          apptoken:(NSString *)apptoken
                            tabflag:(NSString *) tabflag
                             rflag:(NSString *)rflag
                             rpara:(NSString *)rpara
                           perpage:(NSString *)perpage
                           pagenum:(NSString *)pagenum
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))success
                              fail:(void (^)(id errorString))fail;
#pragma -mark -融资进程部分接口
- (void)getProjectInvestorWithusername:(NSString*)username
                              apptoken:(NSString *)apptoken
                             projectid:(NSString *)projectid
                               tabflag:(NSString *)tabflag
                                hudDic:(NSDictionary*)hudDic
                               success:(void (^)(id responseDic))success
                                  fail:(void (^)(id errorString))fail;
#pragma -mark -筛选部分选项（十九)
- (void)getProFilterOptWithusername:(NSString*)username
                           apptoken:(NSString *)apptoken
                              rflag:(NSString *)rflag
                             hudDic:(NSDictionary*)hudDic
                            success:(void (^)(id responseDic))success
                               fail:(void (^)(id errorString))fail;
#pragma -mark ------------新版项目部分结束------------------------------------



#pragma -mark -发送文件使用HTTP协议
//chenlihua 2014.06.24 发送文件使用HTTP协议。
- (void)sendfileWithusername:(NSString*)username
                    apptoken:(NSString *)apptoken
                     msgtype:(NSString *)msgtype
                       files:(NSString *)files
                      hudDic:(NSDictionary*)hudDic
                     success:(void (^)(id responseDic))_success
                        fail:(void (^)(id errorString))_fail;

#pragma -mark -主页4个tab子页面消息数目
//chenlihua 2014.05.29 主页4个tab子页面消息数目
- (void)getdtypenumWithusername:(NSString*)username
                       apptoken:(NSString *)apptoken
                      pushtoken:(NSString *)pushtoken
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail;

#pragma -mark -头像本地缓存接口
//chenlihua 2014.05.28 头像缓存本地接口。
- (void)getuserinfoHeadImageWithusername:(NSString*)username
                                apptoken:(NSString *)apptoken
                                  hudDic:(NSDictionary*)hudDic
                                 success:(void (^)(id responseDic))_success
                                    fail:(void (^)(id errorString))_fail;

#pragma -mark -内部新消息提醒，增加接口，减消息。
//chenlihua 2014.05.09 内部新消息提醒，从由本地数据库查询，改为了从服务器返回。解决，有新消息时，点击到别的页面，回来后，新消息为0的问题。
- (void)setPushJobNumWithusername:(NSString*)username
                         apptoken:(NSString *)apptoken
                             dgid:(NSString *)dgid
                        pushtoken:(NSString *)pushtoken
                           jobnum:(NSString *)jobnum
                           hudDic:(NSDictionary*)hudDic
                          success:(void (^)(id responseDic))_success
                             fail:(void (^)(id errorString))_fail;

//2014.05.09 chenlihua 解决讨论组置顶的问题。
- (void)getDiscussionGroupSortWithusername:(NSString*)username
                                       did:(NSString *)did
                                     order:(NSString *)order
                                    hudDic:(NSDictionary*)hudDic
                                   success:(void (^)(id responseDic))_success
                                      fail:(void (^)(id errorString))_fail;

#pragma  -mark -点击cell中的头像，获取联系人的详细信息
//2014.04.30 chenlihua 点击联系人的头像，获取联系人的详细信息
- (void)getHeadImageDetailInformationWithusername:(NSString*)username
                                           hudDic:(NSDictionary*)hudDic
                                          success:(void (^)(id responseDic))_success
                                             fail:(void (^)(id errorString))_fail;


#pragma -mark -群组增加新成员
//2014.04.25 chenlihua 群组增加新成员
- (void)createGroupMemberWithusername:(NSString*)username
                                  did:(NSString*)did
                            grpmember:(NSString*)grpmemeber
                               hudDic:(NSDictionary*)hudDic
                              success:(void (^)(id responseDic))_success
                                 fail:(void (^)(id errorString))_fail;

#pragma -mark -获取pushtoken必须调用
//2014.04.24 chenlihua 信鸽推送
- (void)getPushTokenWithpushtoken:(NSString*)pushtoken
                           hudDic:(NSDictionary*)hudDic
                          success:(void (^)(id responseDic))_success
                             fail:(void (^)(id errorString))_fail;

#pragma mark - 获取apptoken 进应用必须调用

- (void)getTokenWithdeviceid:(NSString*)deviceid
                      hudDic:(NSDictionary*)hudDic
                     success:(void (^)(id responseDic))_success
                        fail:(void (^)(id errorString))_fail;


#pragma mark - 登陆获取验证码

- (void)GetLoginVerificationCodeWithusername:(NSString*)username
                                      hudDic:(NSDictionary*)hudDic
                                     success:(void (^)(id responseDic))_success
                                        fail:(void (^)(id errorString))_fail;
#pragma mark - 登陆

- (void)LoginWithusername:(NSString*)username
                 password:(NSString*)password
         verificationcode:(NSString*)verificationcode
                   hudDic:(NSDictionary*)hudDic
                  success:(void (^)(id responseDic))_success
                     fail:(void (^)(id errorString))_fail;



#pragma mark - 注册获取验证码

- (void)GetRegisterVerificationCodeWithuserphonenumber:(NSString*)userphonenumber
                                                hudDic:(NSDictionary*)hudDic
                                               success:(void (^)(id responseDic))_success
                                                  fail:(void (^)(id errorString))_fail;

#pragma mark - 注册

- (void)registerWithuseraccout:(NSString*)useraccout
                      password:(NSString*)password
                   userpicture:(NSString*)userpicture
                  registertype:(NSString*)registertype
              verificationcode:(NSString*)verificationcode
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail;

#pragma mark - 忘记密码
- (void)getPasswordWithUsername:(NSString*)username
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail;


#pragma mark -用群ID 去获取群详细信息
-(void)getdisginfoWithusername:(NSString *)username
                      apptoken:(NSString *)apptoken
                          dgid:(NSString*)dgid
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail;

#pragma  -mark  - 进入方创讨论组的首页
//2014.05.09 chenlihua 接口暂时整体改动。重写函数
- (void)indexWithusername:(NSString*)username
                    dtype:(NSString*)dtype
                  perpage:(NSString *)perpage
                  pagenum:(NSString *)pagenum
                   hudDic:(NSDictionary*)hudDic
                  success:(void (^)(id responseDic))_success
                     fail:(void (^)(id errorString))_fail;

#pragma mark - 主页
//2014.05.09 chenlihua 接口暂时整体改动,暂时无用。
/*
 - (void)indexWithuserid:(NSString*)userid
 dtype:(NSString*)dtype
 hudDic:(NSDictionary*)hudDic
 success:(void (^)(id responseDic))_success
 fail:(void (^)(id errorString))_fail;
 
 */

#pragma mark - 方创任务列表

- (void)getrecenttaskWithuserid:(NSString*)userid
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail;


#pragma mark - 方创任务列表2
- (void)getAllTaskWithUsername:(NSString*)username
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail;

#pragma mark - 方创任务详情
- (void)getTaskInfoWithTaskid:(NSString*)taskid
                     username:(NSString*)username
                       hudDic:(NSDictionary*)hudDic
                      success:(void (^)(id responseDic))_success
                         fail:(void (^)(id errorString))_fail;
#pragma mark -项目进度
- (void)getprojectscheduleWithProjectid:(NSString*)projectid
                               username:(NSString*)username
                                 hudDic:(NSDictionary*)hudDic
                                success:(void (^)(id responseDic))_success
                                   fail:(void (^)(id errorString))_fail;
#pragma mark - 项目进展列表2

- (void)getallproboardWithuserid:(NSString*)userid
                         perpage:(NSString*)perpage
                          pageid:(NSString*)pageid
                          hudDic:(NSDictionary*)hudDic
                         success:(void (^)(id responseDic))_success
                            fail:(void (^)(id errorString))_fail;


#pragma mark - 项目进展详情
- (void)getBoradInfoWithBoardid:(NSString*)boardid
                       username:(NSString*)username
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail;


#pragma mark - 留言列表
- (void)getMessageListWithProjectid:(NSString*)proid
                           username:(NSString*)username
                             hudDic:(NSDictionary*)hudDic
                            success:(void (^)(id responseDic))_success
                               fail:(void (^)(id errorString))_fail;


#pragma mark - 发表留言
- (void)sendMessageWithProjectid:(NSString*)proid
                           title:(NSString*)title
                         content:(NSString*)content
                        username:(NSString*)username
                          hudDic:(NSDictionary*)hudDic
                         success:(void (^)(id responseDic))_success
                            fail:(void (^)(id errorString))_fail;

//#pragma mark - 联系人列表
//
//- (void)getContactListWithuserid:(NSString*)userid
//                          hudDic:(NSDictionary*)hudDic
//                         success:(void (^)(id responseDic))_success
//                            fail:(void (^)(id errorString))_fail;

#pragma mark - 项目列表
- (void)getProjectListWithusername:(NSString*)username
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail;

#pragma mark - 项目点击
- (void)sendeProjectClickWithProjectid:(NSString*)proid
                                 cflag:(NSString*)flag
                              username:(NSString*)username
                                hudDic:(NSDictionary*)hudDic
                               success:(void (^)(id responseDic))_success
                                  fail:(void (^)(id errorString))_fail;

#pragma mark - 项目文档
- (void)getDocumentListWithProjectid:(NSString*)proid
                        documenttype:(NSString*)docuType
                            username:(NSString*)username
                              hudDic:(NSDictionary*)hudDic
                             success:(void (^)(id responseDic))_success
                                fail:(void (^)(id errorString))_fail;

#pragma mark - 商业计划
- (void)getBusinessPlanWithProjectid:(NSString*)proid
                            username:(NSString*)username
                              hudDic:(NSDictionary*)hudDic
                             success:(void (^)(id responseDic))_success
                                fail:(void (^)(id errorString))_fail;

#pragma mark - 融资方案
- (void)getFinancingPlanWithProjectid:(NSString*)proid
                             username:(NSString*)username
                               hudDic:(NSDictionary*)hudDic
                              success:(void (^)(id responseDic))_success
                                 fail:(void (^)(id errorString))_fail;

#pragma mark - 法务
- (void)getLawworksListWithProjectid:(NSString*)proid
                            username:(NSString*)username
                              hudDic:(NSDictionary*)hudDic
                             success:(void (^)(id responseDic))_success
                                fail:(void (^)(id errorString))_fail;

#pragma mark - 方创观点
- (void)getFangchuangStandpointWithProjectid:(NSString*)proid
                                    username:(NSString*)username
                                      hudDic:(NSDictionary*)hudDic
                                     success:(void (^)(id responseDic))_success
                                        fail:(void (^)(id errorString))_fail;

#pragma mark - 财务模型
- (void)getFinancialPlanWithProjectid:(NSString*)proid
                                cyear:(NSString*)year
                             username:(NSString*)username
                               hudDic:(NSDictionary*)hudDic
                              success:(void (^)(id responseDic))_success
                                 fail:(void (^)(id errorString))_fail;

#pragma mark - 项目投资人
- (void)getProjectInvestorWithProjectid:(NSString*)proid
                               username:(NSString*)username
                                 hudDic:(NSDictionary*)hudDic
                                success:(void (^)(id responseDic))_success
                                   fail:(void (^)(id errorString))_fail;

#pragma mark - 轮次
- (void)getRoundsWithProjectid:(NSString*)proid
                       roundid:(NSString*)roundid
                      username:(NSString*)username
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail;


#pragma mark - 见面记录详情
- (void)getMeetingDetailWithMeetid:(NSString*)meetid
                          username:(NSString*)username
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail;

#pragma mark - 发送消息

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
                              fail:(void (^)(id errorString))_fail;

- (void)senddiscussionWithusername:(NSString*)username
                               did:(NSString*)did
                           msgtype:(NSString*)msgtype
                          msgterxt:(NSString*)msgtext
                      opendatetime:(NSString*)opendatetime
                            openby:(NSString*)openby
                            locaid:(NSString *)locaid
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail;




#pragma mark - 接收消息

- (void)getdiscussionWithusername:(NSString*)username
                              did:(NSString*)did
                        rdatetime:(NSString*)rdatetime
                            dflag:(NSString*)dflag
                          perpage:(NSString*)perpage
                           hudDic:(NSDictionary*)hudDic msgid:(NSString *)msgid
                          success:(void (^)(id responseDic))_success
                             fail:(void (^)(id errorString))_fail;



#pragma mark - 联系人列表

- (void)getcontactlistWithusername:(NSString*)username
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail;
#pragma mark-企业团队
- (void)getproteamWithUsername:(NSString*)username
                     projectid:(NSString *)projectid
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail;
#pragma mark - 联系人简介

- (void)contactlistdetail:(NSString*)contactid
                 username:(NSString *)username
                   hudDic:(NSDictionary*)hudDic
                  success:(void (^)(id responseDic))_success
                     fail:(void (^)(id errorString))_fail;


#pragma mark - 修改头像
- (void)SetUserPhotoWithUsername:(NSString*)username
                     userpicture:(NSString*)userpicture
                          hudDic:(NSDictionary*)hudDic
                         success:(void (^)(id responseDic))_success
                            fail:(void (^)(id errorString))_fail;
#pragma mark - 我的资料
-(void)getuserinfoWithUsername:(NSString *)username
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail;

#pragma mark - 编辑我的资料
- (void)setUserInfoWithUsername:(NSString*)username
                      user_name:(NSString*)realnamename
                     usergender:(NSString*)gender
                           post:(NSString*)post
                           base:(NSString *)base
                         comname:(NSString *)comname
                          email:(NSString*)email
                          fmoney:(NSString *)fmoney
                          statge:(NSString *)statge
                          frounds2:(NSString *)frounds2
                          pdesc:(NSString *)pdesc
                          teamsize:(NSString *)teamsize
                         industry:(NSString *)industry
                         currency:(NSString *)currency
                       apptoken:(NSString *)apptoken
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail;

#pragma mark - 修改密码
- (void)changePasswordWithUsername:(NSString*)username
                       oldpassword:(NSString*)oldpassword
                       newpassword:(NSString*)newpassword
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail;

#pragma mark - 修改群聊名称
- (void)changeDiscussNameWithUsername:(NSString*)username
                                  did:(NSString*)did
                              newname:(NSString*)newname
                               hudDic:(NSDictionary*)hudDic
                              success:(void (^)(id responseDic))_success
                                 fail:(void (^)(id errorString))_fail;

#pragma mark - 删除群组
- (void)deleteDisCussWithUsername:(NSString*)username
                              did:(NSString*)did
                           hudDic:(NSDictionary*)hudDic
                          success:(void (^)(id responseDic))_success
                             fail:(void (^)(id errorString))_fail;

#pragma mark - 日程主界面
- (void)getScheduleListWithUsername:(NSString*)username
                          startdate:(NSString*)startdate
                            enddate:(NSString*)enddate
                             hudDic:(NSDictionary*)hudDic
                            success:(void (^)(id responseDic))_success
                               fail:(void (^)(id errorString))_fail;

#pragma mark - 日程删除
-(void)scheduledelWithUsername:(NSString *)username
             andWithScheduleid:(NSString *)scheduleid
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail;
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
                           hudDic:(NSDictionary*)hudDic
                          success:(void (^)(id responseDic))_success
                             fail:(void (^)(id errorString))_fail;
#pragma mark-日程参与人用户列表
-(void)scheduleacclistWithUsername:(NSString *)username
                         projectid:(NSString *)projectid
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail;
#pragma mark-项目关键字搜索项目列表
-(void)prosearchWithUsername:(NSString *)username
                      search:(NSString *)search
                      hudDic:(NSDictionary*)hudDic
                     success:(void (^)(id responseDic))_success
                        fail:(void (^)(id errorString))_fail;
#pragma mark-项目编辑
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
                           fail:(void (^)(id errorString))_fail;
#pragma mark - 获取tallkid

-(void)getcallidWithUsername:(NSString *)username
               withprojectid:(NSString *)projectid
             andWithCallflag:(NSString *)callflag
                      hudDic:(NSDictionary*)hudDic
                     success:(void (^)(id responseDic))_success
                        fail:(void (^)(id errorString))_fail;

#pragma mark - PDF 文件下载

- (NSString*)GetPDFWithUrl:(NSString*)url;

#pragma mark - 讨论组—获得会话Id
- (void)getdid_by121Withusername:(NSString*)username
                          sendto:(NSString*)sendto
                          hudDic:(NSDictionary*)hudDic
                         success:(void (^)(id responseDic))_success
                            fail:(void (^)(id errorString))_fail;


#pragma mark - 测试接口


//- (void) reloadPicWithpath:(NSString*)path;


#pragma mark - 方创内部联系人列表

- (void) getdiscussion_ulistWithuserName:(NSString*)username
                                  hudDic:(NSDictionary*)hudDic
                                 success:(void (^)(id responseDic))_success
                                    fail:(void (^)(id errorString))_fail;



#pragma mark - 创建讨论组
- (void)createdisWithusername:(NSString*)username
                      members:(NSString*)members
                       hudDic:(NSDictionary*)hudDic
                      success:(void (^)(id responseDic))_success
                         fail:(void (^)(id errorString))_fail;



#pragma mark - 讨论组成员

- (void)getgrpmembersWithusername:(NSString*)username
                             dgid:(NSString*)dgid
                           hudDic:(NSDictionary*)hudDic
                          success:(void (^)(id responseDic))_success
                             fail:(void (^)(id errorString))_fail;


#pragma mark - 删除群组

- (void)deletedisgWithusername:(NSString*)username
                           did:(NSString*)did
                        hudDic:(NSDictionary*)hudDic
                       success:(void (^)(id responseDic))_success
                          fail:(void (^)(id errorString))_fail;


#pragma mark - 退出群组

- (void)retreatdisgWithusername:(NSString*)username
                            did:(NSString*)did
                      grpmember:(NSString*)grpmember
                         hudDic:(NSDictionary*)hudDic
                        success:(void (^)(id responseDic))_success
                           fail:(void (^)(id errorString))_fail;

#pragma http 判断 Locaid 发送是否成功-
-(void)getlocaidinServerWithusername:(NSString *)username
                            apptoken:(NSString *)apptoken
                             localid:(NSString *)localid
                              hudDic:(NSDictionary*)hudDic
                             success:(void (^)(id responseDic))_success
                                fail:(void (^)(id errorString))_fail;

@end
