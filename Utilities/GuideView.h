//
//  GuideView.h
//  杨双15131021
//
//  Created by qf1 on 16/1/3.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GoBackBlock)();
@interface GuideView : UIView
@property(nonatomic,strong)NSMutableArray * imageArray;
-(GuideView *)initWithArray:(NSArray *)array andFrame:(CGRect)frame andBlock:(GoBackBlock)block;
@end
