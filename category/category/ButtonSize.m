//
//  ButtonSize.m
//  网易新闻
//
//  Created by RichyLeo on 15/9/15.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import "ButtonSize.h"

@implementation ButtonSize

+ (CGSize)sizeOfLabelWithCustomMaxWidth:(CGFloat)width systemFontSize:(CGFloat)fontSize andFilledTextString:(NSString *)str {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = str;
    [label sizeToFit];
    CGSize size = label.bounds.size;
    
    return size;
}

@end
