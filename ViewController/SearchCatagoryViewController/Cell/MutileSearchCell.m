//
//  MutileSearchCell.m
//  DianZTC
//
//  Created by 杨力 on 6/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "MutileSearchCell.h"

@implementation MutileSearchCell

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
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(17.5*ScreenMultipleIn6+i%3*110*ScreenMultipleIn6+i%3*5*ScreenMultipleIn6, 10*ScreenMultipleIn6, 110*ScreenMultipleIn6, 165/2.0*ScreenMultipleIn6)];
        
        //给图片圆角
        imageView.layer.cornerRadius = 5.0*ScreenMultipleIn6;
        imageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:imageView];
        
        if(i == 0){
            
            self.imageView1 = imageView;
        }else if (i == 1){
            
            self.imageView2 = imageView;
        }else{
            self.imageView3 = imageView;
        }
    }
    
    //在每个cell的下面添加一个灰色底
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, (20+165+18)/2.0*ScreenMultipleIn6, Wscreen, 10*ScreenMultipleIn6)];
    bottomView.backgroundColor = TABLEVIEWCOLOR;
    [self.contentView addSubview:bottomView];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
