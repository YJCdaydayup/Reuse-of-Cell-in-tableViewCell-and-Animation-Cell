//
//  UILabel+LXAdd.h
//  LXLabelDemo
//
//  Created by 刘鑫 on 16/4/13.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LXAdd)
/**
 *  字间距
 */
@property (nonatomic,assign)CGFloat characterSpace;

/**
 *  行间距
 */
@property (nonatomic,assign)CGFloat lineSpace;

/**
 *  关键字
 */
@property (nonatomic,copy)NSString *keywords;
@property (nonatomic,strong)UIFont *keywordsFont;
@property (nonatomic,strong)UIColor *keywordsColor;

/**
 *  下划线
 */
@property (nonatomic,copy)NSString *underlineStr;
@property (nonatomic,strong)UIColor *underlineColor;

/**
 *  计算label宽高，必须调用
 *
 *  @param maxWidth 最大宽度
 *
 *  @return label的rect
 */

//这个方法已定要写出来，不然，上面的效果无法体现，如果不写，就将这个方法里面对应的效果的实现代码单独拿出来写
- (CGSize)getLableRectWithMaxWidth:(CGFloat)maxWidth;
@end
