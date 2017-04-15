//
//  Define.h
//  FangChuang
//
//  Created by omni on 14-4-1.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//


//  1代表http  2代表socket
#define  messageFlag  @"2"

#define serverAddress  @"http://fcapp.favalue.com/index.php?m=appif&f="
//#define serverAddress @"http://fcapp.favalue.com/appif-"
#define SOCKETADDRESS @"42.121.132.104"
#define SOCKETPORT   8481


//开发
//#define serverAddress @"http://fcapp.favalue.com/appif-"
/*
//2014.06.11 chenlihua 修改服务器端拉口
//开发
#define serverAddress @"http://fcapp.favalue.com/index.php?m=appif&f="

//2014.07.02 chenlihua socket的地址和端口。
#define SOCKETADDRESS @"42.121.132.104"
#define SOCKETPORT   8480
 */
#define KUIFont  @"FZLanTingHeiS-R-GB"


//dele
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define ORANGE       [UIColor orangeColor]
#define GRAY    [UIColor grayColor]


#define tabbarCount (4)
//#define TABBARHEIGHT (40)
//2014.07.29 chenlihua 修改Tabbar高度
#define TABBARHEIGHT (49)

#define tabbarTag (99)
#define tabbarButtonTag (100)

#define navigationHeight (45)
#define backButtonTag (110)
#define rightButtonTag (111)
#define NSNOTIFATIONCHAT
/*
 0 no stateBar
 1 has stateBar
 */
#define deviceHasStateBar 1

/*
 0 left or right
 1 up or down
 */
#define deviceOrientation 1

#define screenHeight (deviceHasStateBar ? (deviceOrientation ? [[UIScreen mainScreen] bounds].size.height - 20 : [[UIScreen mainScreen] bounds].size.width - 20) : (deviceOrientation ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width))

#define screenWidth (deviceOrientation ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define IOS7 [[[UIDevice currentDevice] systemVersion]floatValue]>=7



#define fullScreenRect CGRectMake(0, 0, screenWidth, screenHeight)

#define screenCenterX(x) ((screenWidth - x) / 2)

#define screenCenterY(y) ((screenHeight - y) / 2)





#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


typedef enum{
    UserType_Financier = 0,
    UserType_Investors,
    UserType_FaEmployee
}UserType;



//2014.07.02 chenlihua TextLight第三方使用
//2014.07.02 chenlihua 去掉TextLight
//#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//2014.08.21 chenlihua 修改字体。

