//
//  NetManagerNew.m
//  FangChuang
//
//  Created by chenlihua on 14-8-13.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "NetManagerNew.h"
#import "Utils.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"

#define serverAddressNew @"http://fcapp.favalue.com/index.php?m=appif"

static int  showHud ; 
static NetManagerNew *manager;
@implementation NetManagerNew

#pragma mark - 获取单例

+ (id)sharedManagerNew{
    if (!manager) {
        manager = [[NetManagerNew alloc]init];
    }
    return manager;
}

#pragma mark -聊天信息提交

- (void)senddiscussionWithusername:(NSString*)username
                               did:(NSString*)did
                           msgtype:(NSString*)msgtype
                           msgtext:(NSString*)msgtext
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
    [self formRequestWithUrlString :[NSString stringWithFormat:@"%@senddiscussion",serverAddressNew]
                      postParamDic : dic
                         hudString : hudDic
                            success:_success
                            failure:_fail];
    NSLog(@"-------服务器接口函数完成，content--%@---",msgtext);
}

#pragma mark - form请求入口
- (void) formRequestWithUrlString : (NSString*) _urlString
                     postParamDic : (NSDictionary*) _postParamDic
                        hudString : (NSDictionary*) hudDic
                           success:(void (^)(id responseDic)) _success
                           failure:(void(^)(id errorString)) _failure
{
    
    if (showHud == 0) {
        if (!hudDic) {
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
        
        //        NSMutableDictionary *responseDic = [jd objectWithData:request.responseData error:&error];
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
                
                return;
                NSLog(@"--------进入到_success(responseDic);下面完成--------");
                
            }
            else
            {
                //请求失败
                NSString *resultString=[responseDic objectForKey:@"msg"];
                UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:resultString message:@"接口返回的错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好", nil];
//                [myalert show];
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
        [request release];
        
        showHud = 0 ;
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



@end
