//
//  SerizeCell.m
//  DianZTC
//
//  Created by 杨力 on 5/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "SerizeCell.h"

@implementation SerizeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setImageView];
    }
    return self;
}

-(void)setImageView{
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Wscreen, (20+230+20)/2.0*ScreenMultipleIn6)];
    bgView.backgroundColor = TABLEVIEWCOLOR;
    [self.contentView addSubview:bgView];
    
    self.bSImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenMultipleIn6, 10*ScreenMultipleIn6, 115*ScreenMultipleIn6, 115*ScreenMultipleIn6)];
    self.bSImageView.image = [UIImage imageNamed:@"basha"];
    [self configImageView:self.bSImageView];
    
    self.max_X = CGRectGetMaxX(self.bSImageView.frame);
    self.max_Y = CGRectGetMinY(self.bSImageView.frame);
    
    self.hQImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.max_X+5*ScreenMultipleIn6, self.max_Y, 115*ScreenMultipleIn6, 115*ScreenMultipleIn6)];
    self.hQImageView.image = [UIImage imageNamed:@"hunqing"];
    [self configImageView:self.hQImageView];
    
    self.max_X = CGRectGetMaxX(self.hQImageView.frame);
    
    self.serizeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.max_X+5*ScreenMultipleIn6, self.max_Y, 115*ScreenMultipleIn6, 55*ScreenMultipleIn6)];
    self.serizeImageView.image = [UIImage imageNamed:@"xilie1"];
    [self configImageView:self.serizeImageView];
    
    self.max_Y = CGRectGetMaxY(self.serizeImageView.frame);
    self.hotImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.max_X+5*ScreenMultipleIn6, self.max_Y+5*ScreenMultipleIn6, 115*ScreenMultipleIn6, 55*ScreenMultipleIn6)];
    self.hotImageView.image = [UIImage imageNamed:@"hotso"];
    [self configImageView:self.hotImageView];
}

-(void)configImageView:(UIImageView *)imageView{
    
    imageView.layer.cornerRadius = 5.0*ScreenMultipleIn6;
    imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:imageView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
