
//
//  ThemeCell.m
//  DianZTC
//
//  Created by 杨力 on 9/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "ThemeCell.h"

@implementation ThemeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configImageView];
    }
    return self;
}

-(void)configImageView{
    
    self.productImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110*ScreenMultipleIn6, 165/2.0*ScreenMultipleIn6)];
    [self.contentView addSubview:self.productImageView];
    
    max_X = CGRectGetMaxX(self.productImageView.frame);
    //中间线条
    UIView * midLineView = [[UIView alloc]initWithFrame:CGRectMake(max_X, 0, 0.5*ScreenMultipleIn6, 165/2.0*ScreenMultipleIn6)];
    midLineView.backgroundColor = RGB_COLOR(227, 227, 227, 1);
    [self.contentView addSubview:midLineView];
    
    max_X = CGRectGetMaxX(midLineView.frame);
    
    //名称Label
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(max_X+75/2.0*ScreenMultipleIn6, 69/2.0*ScreenMultipleIn6, 100*ScreenMultipleIn6, 14*ScreenMultipleIn6)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:15*ScreenMultipleIn6];
    self.titleLabel.textColor = TEXTCOLOR;
    [self.contentView addSubview:self.titleLabel];
    
    //底部加线条
    max_Y = CGRectGetMaxY(self.productImageView.frame);
    UIView * bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, max_Y-0.5*ScreenMultipleIn6,self.frame.size.width, 0.5*ScreenMultipleIn6)];
    bottomLineView.backgroundColor = RGB_COLOR(227, 227, 227, 1);
    [self.contentView addSubview:bottomLineView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
