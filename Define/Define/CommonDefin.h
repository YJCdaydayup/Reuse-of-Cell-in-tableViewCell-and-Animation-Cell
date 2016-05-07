//
//  CommonDefin.h
//  LoveLimitFree
//
//  Created by 郝海圣 on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef LoveLimitFree_CommonDefin_h
#define LoveLimitFree_CommonDefin_h

/**
 *  当前的App版本
 */
#define kAppVersion (1.0)

/**
 *  当前系统版本
 */
#define kSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

/**
 *  当前屏幕大小
 */
#define kScreenBounds ([[UIScreen mainScreen] bounds])
// 获取屏幕的宽高
#define Wscreen   [UIScreen mainScreen].bounds.size.width
#define Hscreen   [UIScreen mainScreen].bounds.size.height

//App代理类
#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]

//获取导航条和tabbar的高度
#define statusHeights   [[UIApplication sharedApplication] statusBarFrame].size.height
#define navigationHeight  self.navigationController.navigationBar.frame.size.height


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


/**
 *  第一次启动App的Key
 */
#define kAppFirstLoadKey @"kAppFirstLoadKey"

/**
 *  调试模式的标签
 */
#define DEBUG_FLAG


/**
 *  如果是调试模式，QFLog就和NSLog一样，如果不是调试模式，QFLog就什么都不做
 *  __VA_ARGS__ 表示见面...的参数列表
 */
#ifdef DEBUG_FLAG
#define QFLog(fmt, ...) NSLog(fmt, __VA_ARGS__)
#else
#define QFLog(fmt, ...) 
#endif


#endif


