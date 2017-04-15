//
//  CacheImageView.h
//  cacheView
//
//  Created by 潘鸿吉 on 13-3-12.
//  Copyright (c) 2013年 潘鸿吉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CacheImageView;

@protocol CacheImageViewDelegate <NSObject>

@optional
- (void) cacheImageViewDidFinishLoading : (CacheImageView*) cacheImageView image : (UIImage*) _image urlStr : (NSString*) url isCache : (BOOL) isCache;
@end

@interface CacheImageView : UIImageView
{
    UIActivityIndicatorView     *aiView;
    NSURLConnection             *connection;
    NSMutableData               *data;
    NSURL                       *url;
    id <CacheImageViewDelegate> delegate;
    
    
}

@property (nonatomic , retain) id <CacheImageViewDelegate> delegate;
@property (nonatomic , assign) BOOL isHead;

- (id) initWithImage : (UIImage*) _image Frame : (CGRect) _frame;
- (void) getImageFromURL : (NSURL*) _url;
- (void) saveImage;
- (NSDictionary*) getSaveDictionary;
- (void) saveDictionary : (NSMutableDictionary*) _dic;
- (NSString*) generatImageName;
- (BOOL) isHaveImage;


@end


