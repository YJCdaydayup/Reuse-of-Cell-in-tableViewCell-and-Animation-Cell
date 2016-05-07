
//
//  SerizesCell.m
//  DianZTC
//
//  Created by 杨力 on 6/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "SerizesCell.h"

@implementation SerizesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setImageView];
    }
    return self;
}

-(void)setImageView{
    
    UIView * topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Wscreen, 1*ScreenMultipleIn6)];
    topLineView.backgroundColor = RGB_COLOR(245, 245, 245, 1);
    [self.contentView addSubview:topLineView];
    
    for(int i=0;i<3;i++){
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(7.5*ScreenMultipleIn6+i%3*110*ScreenMultipleIn6+i%3*5*ScreenMultipleIn6, 10*ScreenMultipleIn6, 110*ScreenMultipleIn6, 165/2.0*ScreenMultipleIn6)];
        [self.contentView addSubview:imageView];
        
        if(i == 0){
            
            self.imageView1 = imageView;
        }else if (i == 1){
            
            self.imageView2 = imageView;
        }else{
            self.imageView3 = imageView;
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
