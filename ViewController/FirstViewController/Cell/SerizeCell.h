//
//  SerizeCell.h
//  DianZTC
//
//  Created by 杨力 on 5/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SerizeCell : UITableViewCell

@property (nonatomic,strong) UIImageView * bSImageView;
@property (nonatomic,strong) UIImageView * hQImageView;
@property (nonatomic,strong) UIImageView * serizeImageView;
@property (nonatomic,strong) UIImageView * hotImageView;


//适配工具
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;

@end
