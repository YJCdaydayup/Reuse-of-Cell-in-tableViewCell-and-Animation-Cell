//
//  UIColor+RandomColor.m
//  2_UITabBarControllerMore
//
//  Created by RichyLeo on 15/9/1.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+(UIColor *)randomColor
{
    CGFloat red = arc4random() % 256 / 255.0;
    CGFloat green = arc4random() % 256 / 255.0;
    CGFloat blue = arc4random() % 256 / 255.0;

    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    
    return color;
}

@end
