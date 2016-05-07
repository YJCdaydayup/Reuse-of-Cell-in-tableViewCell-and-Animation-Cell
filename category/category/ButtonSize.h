//
//  ButtonSize.h
//  网易新闻
//
//  Created by RichyLeo on 15/9/15.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ButtonSize : NSObject

//这个方法可以计算文字的高度，但是缺点是：当文字设置了间距的时候，就无法进行设置了
+ (CGSize)sizeOfLabelWithCustomMaxWidth:(CGFloat)width systemFontSize:(CGFloat)fontSize andFilledTextString:(NSString *)str;

@end
