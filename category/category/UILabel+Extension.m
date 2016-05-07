//
//  UILabel+Extension.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "UILabel+Extension.h"
#define XCFThemeColor RGB(249, 103, 80)        // TabBar选中颜色
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
@implementation UILabel (Extension)

+ (UILabel *)labelWithFont:(UIFont *)font
                 textColor:(UIColor *)textColor
             numberOfLines:(NSInteger)lines
             textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.numberOfLines = lines;
    label.textAlignment = textAlignment;
    return label;
}


+ (void)showStats:(NSString *)stats atView:(UIView *)view {
    
    UILabel *message = [[UILabel alloc] init];
    message.layer.cornerRadius = 10;
    message.clipsToBounds = YES;
//    message.backgroundColor = RGBA(0, 0, 0, 0.8);
    message.numberOfLines = 0;
    message.font = [UIFont systemFontOfSize:15];
//    message.textColor = XCFLabelColorWhite;
    message.textAlignment = NSTextAlignmentCenter;
    message.alpha = 0;
    
    message.text = stats;
    CGSize size = [stats boundingRectWithSize:CGSizeMake(MAXFLOAT, 50)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                     context:nil].size;
    message.frame = CGRectMake(0, 0, size.width + 20, size.height + 10);
    message.center = view.center;
    [view addSubview:message];
    
    [UIView animateWithDuration:1.5 animations:^{
        message.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            message.alpha = 0;
        } completion:^(BOOL finished) {
            [message removeFromSuperview];
        }];
    }];
}


- (void)setAttributeTextWithString:(NSString *)string range:(NSRange)range {
    NSMutableAttributedString *attrsString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrsString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    [attrsString addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                 NSForegroundColorAttributeName:[UIColor blackColor]} range:range];
    self.attributedText = attrsString;
}

@end
