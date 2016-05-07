//
//  YLAutoLayOut.h
//  适配方案
//
//  Created by 杨力 on 23/4/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import <UIKit/UIKit.h>
//屏幕宽高
#define APPWIDTH  [[UIScreen mainScreen] bounds].size.width
#define APPHEIGHT [[UIScreen mainScreen] bounds].size.height

//不同iPhone下的屏幕比例  iphone4为基准
#define ScreenMultiple [[YLAutoLayOut shareInstance] screenMultiple]

//不同iPhone下的屏幕比例  iphone6plus为基准
#define ScreenMultipleIn6Plus [[YLAutoLayOut shareInstance] screenMultipleIn6Plus]

//不同iPhone下的屏幕比例  iphone6为基准
#define ScreenMultipleIn6 [[YLAutoLayOut shareInstance] screenMultipleIn6]

//不同iPhone下的屏幕比例  登录界面为基准
#define ScreenMultipleLogin [[YLAutoLayOut shareInstance] screenMultipleLogin]

@interface YLAutoLayOut : UIViewController

//单例创建
+(instancetype)shareInstance;

//适配iPhone5，6，6plus
-(CGFloat)screenMultiple;
-(CGFloat)screenMultipleIn6Plus;
-(CGFloat)screenMultipleIn6;
-(CGFloat)screenMultipleLogin;

@end
