//
//  ProductCell.h
//  DianZTC
//
//  Created by 杨力 on 5/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell

@property (nonatomic,strong) UIImageView * imageView1;
@property (nonatomic,strong) UIImageView * imageView2;

@property (nonatomic,strong) UILabel * title1;
@property (nonatomic,strong) UILabel * title2;

//适配工具
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;

@end
