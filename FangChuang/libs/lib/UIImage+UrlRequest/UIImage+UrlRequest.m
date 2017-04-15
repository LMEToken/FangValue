//
//  UIImage+UrlRequest.m
//  FangChuang
//
//  Created by 朱天超 on 14-2-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "UIImage+UrlRequest.h"
#import "ASIHTTPRequest.h"
#import <objc/runtime.h>


@implementation UIImage (UrlRequest)




#pragma mark - ASI 请求文件做法
+ (void )imageWithUrlString:(NSString*)urlString imageCallBlock:(UIImageCallBack)block
{
    NSString* pathString = [urlString stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString* path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",pathString]];

    
    //去本地缓存
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage* urlImage = [[[UIImage alloc] initWithContentsOfFile:path] autorelease];
        
        
        if (block) {
            block(urlImage);
        }
        
        return ; 
    }
       
    //本地无缓存 ， 网络请求
    
    
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    
    ASIHTTPRequest* request = [[ASIHTTPRequest alloc] initWithURL:url];
    
    //    [request setDelegate:self];
    [request setDownloadDestinationPath:path];
    [request setCompletionBlock:^{
        
        
        UIImage* urlImage = [[[UIImage alloc] initWithContentsOfFile:path] autorelease];
        
        
        UIImage* image = [UIImage smallImage:urlImage];
        NSData* newData = UIImageJPEGRepresentation(image, .5);
        
        //图片存到沙盒
        
        NSFileManager* fm = [NSFileManager defaultManager];
        BOOL write =  [fm createFileAtPath:path contents:newData attributes:nil];
        
        if (write) {
            NSLog(@"cache success!");
        }
        else
        {
            NSLog(@"cache error");
        }

        
        if (block) {
            block(image);
        }
        
    }];
    
    [request setFailedBlock:^{
        
        if (block) {
            block(@"UIImage+UrlRequest error!");
        }
    }];
    
    [request startAsynchronous];

    [request release];
    
    
}


#pragma mark - 系统原生请求

static char * UIImageDictionary;



+ (void )imageWithConnectionString:(NSString*)urlString imageCallBlock:(UIImageCallBack)block
{
//    self =(id) [[UIImage alloc] init];
//    if (self == nil) {
//        return ; 
//    }
    
    NSString* pathString = [urlString stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString* path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",pathString]];
    
    
    //去本地缓存
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        //原始图片
        UIImage* urlImage = [[[UIImage alloc] initWithContentsOfFile:path] autorelease];
        
        if (block) {
            block(urlImage);
        }
        
        return ;
    }

    
    
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    if (dictionary) {
        objc_setAssociatedObject(self, UIImageDictionary, dictionary, OBJC_ASSOCIATION_RETAIN);
        [dictionary release];
    }
    
    if (block) {
        [dictionary setObject:block forKey:@"block"];
        
    }
    
    if (path) {
        [dictionary setObject:path forKey:@"path"];
    }
    
    NSMutableData* reciveData = [[NSMutableData alloc] init];
    
    if (reciveData) {
        
        [dictionary setObject:reciveData forKey:@"data"];
        [reciveData release];
        
    }

    
    
    
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [connection release];
    
    
}

#pragma mark - connect delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"request start!");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"request fail");
}


#pragma mark - 接收到数据

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //初始化buffer
    
    NSMutableDictionary* reciveDic = (NSMutableDictionary*)objc_getAssociatedObject(self, UIImageDictionary);

    NSMutableData* reciveData = [reciveDic objectForKey:@"data"];
    
    if (reciveData == nil) {
        
        return ;
    }
    
    [reciveData appendData:data];
    

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"requst finish!");
    NSMutableDictionary* reciveDic = (NSMutableDictionary*)objc_getAssociatedObject(self, UIImageDictionary);
    
    NSMutableData* reciveData = [reciveDic objectForKey:@"data"];

    if (reciveData == nil) {
        NSLog(@"没有接收到数据!");
        return ;
    }
    
    //处理图片
    
    UIImage* originalImage = [UIImage imageWithData:reciveData];
    
    //缩放图片 28 * 28
    UIImage* image = [UIImage smallImage:originalImage];
    
    //缩放系数
    NSData* newData = UIImageJPEGRepresentation(image, .5);

    
    //见图片存到沙盒

    NSString* path = [reciveDic objectForKey:@"path"];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    BOOL write =  [fm createFileAtPath:path contents:newData attributes:nil];
    
    if (write) {
        NSLog(@"cache success!");
    }
    else
    {
        NSLog(@"cache error");
    }

    
    //回调函数
    UIImageCallBack block = [reciveDic objectForKey:@"block"];
 
    if (image) {
        block(image);
    }

    
    
    if (self) {
        [self release];
    }
    
}

#pragma mark - 处理图片

+(UIImage*)smallImage:(UIImage*)image
{
    
    //图片重绘 28 * 28
    CGSize size = CGSizeMake(28, 28);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}



@end
