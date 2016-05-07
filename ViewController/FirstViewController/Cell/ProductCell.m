
//
//  ProductCell.m
//  DianZTC
//
//  Created by 杨力 on 5/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setImageView];
    }
    return self;
}

-(void)setImageView{
    
    //设置顶部线条
    UIView * toplineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Wscreen, 1*ScreenMultipleIn6)];
    toplineView.backgroundColor = RGB_COLOR(221, 221, 221, 1);
    [self.contentView addSubview:toplineView];
    
    self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenMultipleIn6, 6*ScreenMultipleIn6, 345/2.0*ScreenMultipleIn6, 345/2.0*ScreenMultipleIn6)];
    [self.contentView addSubview:self.imageView1];
    
    self.max_X = CGRectGetMaxX(self.imageView1.frame);
    
    self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.max_X+10*ScreenMultipleIn6, 6*ScreenMultipleIn6, 345/2.0*ScreenMultipleIn6, 345/2.0*ScreenMultipleIn6)];
    [self.contentView addSubview:self.imageView2];
    
    //设置图片下面的灰色条
    self.max_Y = CGRectGetMaxY(self.imageView2.frame);
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.max_Y+6*ScreenMultipleIn6, Wscreen, 10*ScreenMultipleIn6)];
    bottomView.backgroundColor = TABLEVIEWCOLOR;
    [self.contentView addSubview:bottomView];
    
    //给每个图片加标题
    self.title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, (345-50)/2.0*ScreenMultipleIn6, self.imageView2.frame.size.width, 25*ScreenMultipleIn6)];
    self.title1.backgroundColor = IMAGETILIECOLOR;
    self.title1.alpha = 0.9;
    self.title1.textAlignment = NSTextAlignmentCenter;
    self.title1.font = [UIFont systemFontOfSize:15*ScreenMultipleIn6];
    self.title1.textColor = [UIColor whiteColor];
    [self.imageView1 addSubview:self.title1];
    
    self.title2 = [[UILabel alloc]initWithFrame:CGRectMake(0, (345-50)/2.0*ScreenMultipleIn6, self.imageView2.frame.size.width, 25*ScreenMultipleIn6)];
    self.title2.backgroundColor = IMAGETILIECOLOR;
    self.title2.textAlignment = NSTextAlignmentCenter;
    self.title2.font = [UIFont systemFontOfSize:15*ScreenMultipleIn6];
    self.title2.textColor = [UIColor whiteColor];
    self.title2.alpha = 0.9;


    [self.imageView2 addSubview:self.title2];
    
    //加载图片
//    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://pic5.nipic.com/20100120/3486811_172042813540_2.jpg"]];
//    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/13/80/08/64X58PIChRv_1024.jpg"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
