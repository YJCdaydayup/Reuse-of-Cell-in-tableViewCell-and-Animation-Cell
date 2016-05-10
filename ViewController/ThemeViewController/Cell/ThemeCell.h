//
//  ThemeCell.h
//  DianZTC
//
//  Created by 杨力 on 9/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeCell : UITableViewCell{
    
    CGFloat max_X;
    CGFloat max_Y;
}

@property (nonatomic,strong) UIImageView * productImageView;
@property (nonatomic,strong) UILabel * titleLabel;


@end
