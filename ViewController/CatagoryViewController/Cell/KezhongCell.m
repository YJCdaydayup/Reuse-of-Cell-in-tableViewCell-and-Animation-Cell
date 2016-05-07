
//
//  KezhongCell.m
//  DianZTC
//
//  Created by 杨力 on 6/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "KezhongCell.h"

@implementation KezhongCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setImageView];
    }
    return self;
}

-(void)setImageView{
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(10*ScreenMultipleIn6, 0, Wscreen-20*ScreenMultipleIn6, 140*ScreenMultipleIn6)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    NSArray * titleArray = @[@"1-5g",@"6-10g",@"11-15g",@"16-20g",@"21-30g",@"31-50g",@"51-100g",@"101-150g",@"150-200g",@"大于200g",@""];
    
    //这里的按钮需要tag值从”tag ＝ 70“开始
    for(int i=0;i<11;i++){
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(6.5*ScreenMultipleIn6+i%4*85*ScreenMultipleIn6-i%4*0.6*ScreenMultipleIn6, i/4*40*ScreenMultipleIn6-i/4*0.6*ScreenMultipleIn6
                                  , 85*ScreenMultipleIn6, 40*ScreenMultipleIn6);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
        button.layer.borderColor = [RGB_COLOR(221, 221, 221, 1)CGColor];
        button.layer.borderWidth = 0.6*ScreenMultipleIn6;
        button.titleLabel.font = [UIFont systemFontOfSize:15*ScreenMultipleIn6];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = i+70;
        if(i == 10){
            
            self.lastButton = button;
            button.frame = CGRectMake(6.5*ScreenMultipleIn6+i%4*85*ScreenMultipleIn6-i%4*0.6*ScreenMultipleIn6, i/4*40*ScreenMultipleIn6-i/4*0.6*ScreenMultipleIn6, 170*ScreenMultipleIn6-0.6*ScreenMultipleIn6, 40*ScreenMultipleIn6);
        }
        [bgView addSubview:button];
    }
    
    //在最后一个按钮上面添加textField
    [self cofigLastButton];
}

-(void)cofigLastButton{
    
    //左边输入框
    self.leftTextField = [Tools createTextFieldFrame:CGRectMake(9*ScreenMultipleIn6, 7.5*ScreenMultipleIn6, 61*ScreenMultipleIn6, 25*ScreenMultipleIn6) placeholder:nil bgImageName:@"box" leftView:nil rightView:nil isPassWord:NO];
    self.leftTextField.font = [UIFont systemFontOfSize:15*ScreenMultipleIn6];
    self.leftTextField.textColor = [UIColor blackColor];
    self.leftTextField.textAlignment = NSTextAlignmentCenter;
    [self.lastButton addSubview:self.leftTextField];
    
   //中间线条
    self.max_X = CGRectGetMaxX(self.leftTextField.frame);
    self.max_Y = CGRectGetMinY(self.leftTextField.frame);
    
    UIView * midLineView = [[UIView alloc]initWithFrame:CGRectMake(self.max_X+5*ScreenMultipleIn6,self.max_Y + 11*ScreenMultipleIn6, 8*ScreenMultipleIn6, 1.5*ScreenMultipleIn6)];
    midLineView.backgroundColor = RGB_COLOR(221, 221, 221, 1);
    [self.lastButton addSubview:midLineView];
    
//    右边输入框
    self.max_X = CGRectGetMaxX(midLineView.frame);
    self.rightTextField = [Tools createTextFieldFrame:CGRectMake(self.max_X+5*ScreenMultipleIn6, 7.5*ScreenMultipleIn6, 61*ScreenMultipleIn6, 25*ScreenMultipleIn6) placeholder:nil bgImageName:@"box" leftView:nil rightView:nil isPassWord:NO];
    self.rightTextField.font = [UIFont systemFontOfSize:15*ScreenMultipleIn6];
    self.rightTextField.textColor = [UIColor blackColor];
    self.rightTextField.textAlignment = NSTextAlignmentCenter;
    [self.lastButton addSubview:self.rightTextField];
    
    //最右边的“g”
    self.max_X = CGRectGetMaxX(self.rightTextField.frame);
    UILabel * daniwei = [Tools createLabelWithFrame:CGRectMake(self.max_X+5*ScreenMultipleIn6, self.max_Y+3*ScreenMultipleIn6, 10*ScreenMultipleIn6, 18*ScreenMultipleIn6) textContent:@"g" withFont:[UIFont systemFontOfSize:16*ScreenMultipleIn6] textColor:TEXTCOLOR textAlignment:NSTextAlignmentLeft];
    [self.lastButton addSubview:daniwei];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
