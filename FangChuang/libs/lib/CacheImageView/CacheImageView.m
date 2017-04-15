//
//  CacheImageView.m
//  cacheView
//
//  Created by 潘鸿吉 on 13-3-12.
//  Copyright (c) 2013年 潘鸿吉. All rights reserved.
//

#import "CacheImageView.h"

@implementation CacheImageView

@synthesize delegate , isHead;


#pragma - init
- (id) initWithImage : (UIImage*) _image Frame : (CGRect) _frame
{
    self = [super initWithFrame:_frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setImage:_image];
        
        aiView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [aiView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [aiView setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
        [self addSubview:aiView];
    }
    return self;
}

#pragma mark - getImageFromURL
- (void) getImageFromURL:(NSURL *) _url{
    
    NSLog(@"getimage===cancelPicture===%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"cancelPicture"]);
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"cancelPicture"]) {
        if (!isHead) {
            return;
        }
     }
    
    if (!aiView) {
        aiView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [aiView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [aiView setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
        [self addSubview:aiView];
    }
    
    [aiView startAnimating];
    
    
   
    
    if (url) {
        url = nil;
    }    
    
    
    url = _url;
     NSLog(@"---图片缓存中------_url---%@----",url);
    if ([self isHaveImage]) {
        
        NSLog(@"----------图片缓存中---isHaveImage----");
        if (delegate) {
            NSLog(@"----图片缓存中------读取plist文件");
            //读取plist文件
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *cachesDirectory = [paths objectAtIndex:0];
            NSString *path = [cachesDirectory stringByAppendingPathComponent:@"CacheImageDic.plist"];
            
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            NSString *imagePath = [dict objectForKey:[url absoluteString]];
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
            [delegate cacheImageViewDidFinishLoading:self image:image urlStr:url.absoluteString isCache:YES];
        }
        return;
    }
    //    NSLog(@"%@",[_url absoluteString]);
    //所构建的NSURLRequest具有一个依赖于缓存响应的特定策略，cachePolicy取得策略，timeoutInterval取得超时值
    
    
    
    NSURLRequest* request = [NSURLRequest requestWithURL:_url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:45.0];
    if (data) {
        data = nil;
    }
    
    if (connection != nil) {
        connection = nil;
    }
    
    connection = [[NSURLConnection alloc]
                  initWithRequest:request delegate:self];
    
}

#pragma mark - NSURLConnectionDelagete
//异步加载的几个方法。
////接受返回数据，这个方法可能会被调用多次，因此将多次返回数据加起来
- (void)connection:(NSURLConnection *)theConnection
    didReceiveData:(NSData *)incrementalData {
    
    NSLog(@"----图片缓存中---接受返回数据-----");
    if (!data) {
        data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    if (incrementalData) {
        //        NSLog(@"%i %i",[data length],[incrementalData length]);
        [data appendData:incrementalData];
    }
}

//连接错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"-----图片缓存中--连接错误-----------");
    NSLog(@"cache_error : %@" , error);
    [aiView stopAnimating];
    [aiView removeFromSuperview];

    aiView = nil;
}
//连接结束
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {

    NSLog(@"-----图片缓存中---连接结束--------");
    connection = nil;
    
	UIImage* dataImage = [UIImage imageWithData:data];
    if (dataImage) {
        [self setImage:dataImage];

//        dispatch_async(dispatch_get_main_queue(), ^{
//                   [self setImage:[UIImage imageNamed:@"icon.png"]];
//           [self setImage:dataImage];
//        });
    }
    
   // [self reloadInputViews];
    //    if (dataImage) {
    //
    //    }
    
    //    [self setNeedsLayout];
    
    [self saveImage];
    
    if (data) {

        data = nil;
    }
    
    [aiView stopAnimating];
    [aiView removeFromSuperview];

    aiView = nil;
}

#pragma mark - saveImage
- (void)saveImage{
    
    NSLog(@"-------图片缓存中----saveImage--------");
    
    if (!url) {
        return;
    }
    
    NSDictionary *saveDic = [self getSaveDictionary];
    
    if (saveDic) {
        
        //写入缓存
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *cachesDirectory = [paths objectAtIndex:0];
        NSString *imagePath = [cachesDirectory stringByAppendingPathComponent:[self generatImageName]];
        
        [data writeToFile:imagePath atomically:YES];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:saveDic];
        
        [dict setObject:imagePath forKey:[url absoluteString]];
        
        //        [dict setObject:imagePath forKey:[NSString stringWithFormat:@"%@",url]];
        [self saveDictionary:dict];
        
    }else{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *cachesDirectory = [paths objectAtIndex:0];
        NSString *imagePath = [cachesDirectory stringByAppendingPathComponent:[self generatImageName]];
        
        [data writeToFile:imagePath atomically:YES];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:imagePath forKey:[url absoluteString]];
        [self saveDictionary:dict];
    }
    
    if (delegate) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *cachesDirectory = [paths objectAtIndex:0];
        NSString *path = [cachesDirectory stringByAppendingPathComponent:@"CacheImageDic.plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        NSString *imagePath = [dict objectForKey:[url absoluteString]];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        [delegate cacheImageViewDidFinishLoading:self image:image urlStr:url.absoluteString isCache:NO];
    }
    
    
    
}

- (NSDictionary*) getSaveDictionary{
    
    NSLog(@"-----图片缓存中---getSaveDictionary-----");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *path = [cachesDirectory stringByAppendingPathComponent:@"CacheImageDic.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        return [NSDictionary dictionaryWithContentsOfFile:path];
    }
    NSLog(@"创建plist");
    return nil;
}

- (void) saveDictionary : (NSMutableDictionary *)_dic{
    
    NSLog(@"-------图片缓存中-----saveDictionary--");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *path = [cachesDirectory stringByAppendingPathComponent:@"CacheImageDic.plist"];
    [_dic writeToFile:path atomically:YES];
    NSLog(@"保存到plist");
}

#pragma mark 生成图片名
- (NSString*)generatImageName{
    
    NSLog(@"--------图片缓存中----generatImageName-----");
    
    NSDate *date = [[NSDate alloc]init];
    NSDateFormatter *fat = [[NSDateFormatter alloc]init];
    [fat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString =  [fat stringFromDate:date];
    
    int number = arc4random() % 899 +100;
    NSString *string = [[NSString alloc] initWithFormat:@"_%d",number];
    
    NSMutableString *randomName = [NSMutableString stringWithString:dateString];
    [randomName appendString:string];
    
    return randomName;
}

#pragma mark 判断图片是否存在
- (BOOL)isHaveImage{
    
    NSLog(@"----图片缓存中---判断图片是否存在---");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *path = [cachesDirectory stringByAppendingPathComponent:@"CacheImageDic.plist"];
    if (![[NSFileManager defaultManager]fileExistsAtPath:path]) {
        return NO;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *imagePath = [dict objectForKey:[url absoluteString]];
    
    //     NSString *imagePath = [dict objectForKey:[NSString stringWithFormat:@"%@",url]];
    if (imagePath != nil) {
        if (data) {
            data = nil;
        }
        data = [[NSMutableData alloc] initWithContentsOfFile:imagePath];
		UIImage* dataImage = [UIImage imageWithData:data];
        if (dataImage) {
            [self setImage:dataImage];
            
            //            [self setNeedsLayout];
            
            data=nil;
            
            [aiView stopAnimating];
            [aiView removeFromSuperview];
            aiView = nil;
            return YES;
        }
        
        
    }
    
    return NO;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
