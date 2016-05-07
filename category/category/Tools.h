//
//  Tools.h
//  RenRenApp
//
//  Created by RichyLeo on 15/8/31.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject

/**
 *  通过文件路径加载图片
 *  该方法加载图片优势：不会将图片加到内存缓存中（适用类型：较大图片的处理）
 *
 *  @param imgName 图片名称（带扩展名）eg：btn_login.png
 *
 *  @return 返回图片对象
 */
+(UIImage *)imageWithName:(NSString *)imgName;

// 创建一个按钮 （以图片展现）
+(UIButton *)createButtonNormalImage:(NSString *)normalImageName selectedImage:(NSString *)selectImageName tag:(NSUInteger)tag addTarget:(id)target action:(SEL)action;

// 创建UILabel
+(UILabel *)createLabelWithFrame:(CGRect)frame textContent:(NSString *)text withFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)align;

//创建一个普通的按钮
+(UIButton *)createNormalButtonWithFrame:(CGRect)frame textContent:(NSString *)text withFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)align;

//将带＃号的16进制返回UIColor
+(UIColor *)getColor:(NSString *)hexColor;

//通过颜色的到UIImage
+(UIImage*)createImageWithColor:(UIColor*) color;

//创建textField
+(UITextField*)createTextFieldFrame:(CGRect)frame placeholder:(NSString*)placeholder bgImageName:(NSString*)imageName leftView:(UIView*)leftView rightView:(UIView*)rightView isPassWord:(BOOL)isPassWord;

//创建一个ImageView
+(void)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName View:(UIView *)motherView;

@end
