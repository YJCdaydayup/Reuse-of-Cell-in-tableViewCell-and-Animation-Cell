//
//  UIBarButtonItem+Extesion.h
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-5.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extesion)
/**
 *  创建一个带有普通和高亮图片的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
/**
 *  创建一个带有普通图片的item
 */
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action;
/**
 *  创建一个带有普通大图的item
 */
+ (UIBarButtonItem *)initWithNormalImageBig:(NSString *)image target:(id)target action:(SEL)action;
/**
 *  自定义宽高并且带有普通图片的item
 */
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height;
/**
 *  创建一个自定义标题和标题颜色的item
 */
+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;
@end
