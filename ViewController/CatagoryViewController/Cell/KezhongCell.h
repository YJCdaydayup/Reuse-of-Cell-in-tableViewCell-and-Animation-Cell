//
//  KezhongCell.h
//  DianZTC
//
//  Created by 杨力 on 6/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KezhongCell : UITableViewCell

@property (nonatomic,strong) UIButton * lastButton;
@property (nonatomic,strong) UITextField * leftTextField;
@property (nonatomic,strong) UITextField * rightTextField;


//适配工具
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;

@end
