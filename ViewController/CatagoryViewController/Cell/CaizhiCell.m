//
//  CaizhiCell.m
//  DianZTC
//
//  Created by 杨力 on 6/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "CaizhiCell.h"

@implementation CaizhiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setImageView];
    }
    return self;
}

-(void)setImageView{
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(10*ScreenMultipleIn6, 0, Wscreen-20*ScreenMultipleIn6, 80*ScreenMultipleIn6)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    NSArray * titleArray = @[@"足金9999",@"足金999",@"足金99",@"硬金",@"珍珠",@"砖石"];
    
    //这里的按钮需要tag值从”tag ＝ 40“开始
    for(int i=0;i<6;i++){
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(6.5*ScreenMultipleIn6+i%4*85*ScreenMultipleIn6-i%4*0.5*ScreenMultipleIn6, i/4*40*ScreenMultipleIn6-i/4*0.5*ScreenMultipleIn6
                                  , 85*ScreenMultipleIn6, 40*ScreenMultipleIn6);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
        button.layer.borderColor = [RGB_COLOR(221, 221, 221, 1)CGColor];
        button.layer.borderWidth = 0.5*ScreenMultipleIn6;
        button.titleLabel.font = [UIFont systemFontOfSize:15*ScreenMultipleIn6];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = 40+i;
        [bgView addSubview:button];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
