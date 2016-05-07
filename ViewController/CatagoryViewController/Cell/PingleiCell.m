//
//  PingleiCell.m
//  DianZTC
//
//  Created by 杨力 on 6/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "PingleiCell.h"

@implementation PingleiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setImageView];
    }
    return self;
}

-(void)setImageView{
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(10*ScreenMultipleIn6, 0, Wscreen-20*ScreenMultipleIn6, 280*ScreenMultipleIn6)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    NSArray * titleArray = @[@"项链",@"手镯",@"挂坠",@"戒指",@"手链",@"金条",@"耳环",@"更多",@"耳坠",@"耳钉",@"摆件",@"套链",@"发簪",@"发钗",@"项圈",@"脚镯",@"脚链",@"皮带",@"金币",@"金章",@"金钞",@"金票",@"金算盘",@"手编",@"金包银",@"金包铜"];
    
    //这里的按钮需要tag值从”tag ＝ 100“开始
    for(int i=0;i<PINLEICOUNT;i++){
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(6.5*ScreenMultipleIn6+i%4*85*ScreenMultipleIn6-i%4*0.6*ScreenMultipleIn6, i/4*40*ScreenMultipleIn6-i/4*0.6*ScreenMultipleIn6
                                  , 85*ScreenMultipleIn6, 40*ScreenMultipleIn6);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
        button.layer.borderColor = [RGB_COLOR(221, 221, 221, 1)CGColor];
        button.layer.borderWidth = 0.6*ScreenMultipleIn6;
        button.titleLabel.font = [UIFont systemFontOfSize:15*ScreenMultipleIn6];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.tag = 100 + i;
        if(i == 7){
            
            self.moreButton = button;
        }
        [bgView addSubview:button];
        
        //分配Button
        switch (i) {
            case 0:
                self.button1 = button;
                break;
            case 1:
                self.button2 = button;
                break;
            case 2:
                self.button3 = button;
                break;
            case 3:
                self.button4 = button;
                break;
            case 4:
                self.button5 = button;
                break;
            case 5:
                self.button6 = button;
                break;
            case 6:
                self.button7 = button;
                break;
            case 8:
                self.button8 = button;
                break;
            case 9:
                self.button9 = button;
                break;
            case 10:
                self.button10 = button;
                break;
            case 11:
                self.button11 = button;
                break;
                
            case 12:
                self.button12 = button;
                break;
            case 13:
                self.button13 = button;
                break;
            case 14:
                self.button14 = button;
                break;
            case 15:
                self.button15 = button;
                break;
            case 16:
                self.button16 = button;
                break;
            case 17:
                self.button17 = button;
                break;
            case 18:
                self.button18 = button;
                break;
            case 19:
                self.button19 = button;
                break;
            case 20:
                self.button20 = button;
                break;
            case 21:
                self.button21 = button;
                break;
            case 22:
                self.button22 = button;
                break;
            case 23:
                self.button23 = button;
                break;
            case 24:
                self.button24 = button;
                break;
            case 25:
                self.button25 = button;
                break;
            default:
                break;
        }
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
