//
//  GongYiCell.h
//  DianZTC
//
//  Created by 杨力 on 6/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GongYiCell : UITableViewCell

//各种按钮
@property (nonatomic,strong) UIButton * youyaButton;
@property (nonatomic,strong) UIButton * daomoButton;
@property (nonatomic,strong) UIButton * dianzhuButton;
@property (nonatomic,strong) UIButton * shougongButton;
@property (nonatomic,strong) UIButton * jizhiButton;
@property (nonatomic,strong) UIButton * qianzhuButton;

//适配工具
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;

@end
