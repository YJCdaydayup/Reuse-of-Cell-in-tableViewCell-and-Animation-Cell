//
//  SingleCollectionViewCell.m
//  DianZTC
//
//  Created by 杨力 on 6/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "SingleCollectionViewCell.h"

@implementation SingleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self configImageView];
    }
    return self;
}

-(void)configImageView{
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenMultipleIn6, 10*ScreenMultipleIn6, 345/2.0*ScreenMultipleIn6, 345/2.0*ScreenMultipleIn6)];
    self.imageView.backgroundColor = RGB_COLOR(237, 162, 21, 1);
    [self.contentView addSubview:self.imageView];
    
    //添加半透明的View
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (345-50)/2.0*ScreenMultipleIn6, 345/2.0*ScreenMultipleIn6, 25*ScreenMultipleIn6)];
    self.titleLabel.backgroundColor = IMAGETILIECOLOR;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:15*ScreenMultipleIn6];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.alpha = 0.9;
    [self.imageView addSubview:self.titleLabel];
    self.backgroundColor = [UIColor whiteColor];
}


@end
