//
//  DetailViewController.m
//  DianZTC
//
//  Created by 杨力 on 7/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
//左导航按钮和导航栏标题
@property (nonatomic,strong) UIButton * navLeftButton;
@property (nonatomic,strong) UILabel * titlelabel;

//四个图片属性
@property (nonatomic,strong) UIImageView * largeImageView;
@property (nonatomic,strong) UIImageView * imageView1;
@property (nonatomic,strong) UIImageView * imageView2;
@property (nonatomic,strong) UIImageView * imageView3;

//类别
@property (nonatomic,strong) UILabel * leibieLabel;
//编号
@property (nonatomic,strong) UILabel * bianhaoLabel;
//材质
@property (nonatomic,strong) UILabel * caizhiLabel;
//工艺
@property (nonatomic,strong) UILabel * gongyiLabel;
//克重
@property (nonatomic,strong) UILabel * kezhongLabel;
//外观形态
@property (nonatomic,strong) UILabel * waiguanLabel;
//适合人群
@property (nonatomic,strong) UILabel * renqunLabel;
//规格尺寸
@property (nonatomic,strong) UILabel * chicunLabel;

//适配工具
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;

@end

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated{
    
    self.navLeftButton.hidden = NO;
    self.titlelabel.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.navLeftButton.hidden = YES;
    self.titlelabel.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    [self configUI];
}

-(void)configUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航条设置
    self.navLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navLeftButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    if(IS_IPHONE == IS_IPHONE_6){
        
        self.navLeftButton.frame = CGRectMake(31/2.0*ScreenMultipleIn6, 21/2*ScreenMultipleIn6, 35/2.0*ScreenMultipleIn6, 25*ScreenMultipleIn6);
    }else{
        self.navLeftButton.frame = CGRectMake(31/2.0*ScreenMultipleIn6, 22/2*ScreenMultipleIn6, 35/2.0*ScreenMultipleIn6, 25*ScreenMultipleIn6);
    }
    
    [self.navigationController.navigationBar addSubview:self.navLeftButton];
    [self.navLeftButton addTarget:self action:@selector(backToFirstViewController) forControlEvents:UIControlEventTouchUpInside];
    
    //导航条标题
    self.titlelabel = [Tools createLabelWithFrame:CGRectMake(10, 10, 100*ScreenMultipleIn6, 20*ScreenMultipleIn6) textContent:@"产品页面"
                                         withFont:[UIFont systemFontOfSize:17*ScreenMultipleIn6] textColor:RGB_COLOR(255, 255, 255, 1) textAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = self.titlelabel;
    
    //布局整个页面
    [self autoWholePage];
}

//布局整个页面
-(void)autoWholePage{
    
    self.largeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Wscreen, 563/2.0*ScreenMultipleIn6)];
    [self.view addSubview:self.largeImageView];
    
    //设置三个图片下面的背景
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 563/2.0*ScreenMultipleIn6, Wscreen, (15+165+15)/2.0*ScreenMultipleIn6)];
    bgView.backgroundColor = TABLEVIEWCOLOR;
    [self.view addSubview:bgView];
    
    for(int i=0;i<3;i++){
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(33/2.0*ScreenMultipleIn6+i%3*110*ScreenMultipleIn6+i%3*5*ScreenMultipleIn6, 7.5*ScreenMultipleIn6, 110*ScreenMultipleIn6, 165/2.0*ScreenMultipleIn6)];
        [bgView addSubview:imageView];
        
        if(i == 0){
            self.imageView1 = imageView;
        }else if (i == 1){
            self.imageView2 = imageView;
        }else{
            self.imageView3 = imageView;
        }
    }
    
    //暂时给每个图片添加示例图片
    [self.largeImageView  sd_setImageWithURL:[NSURL URLWithString:@"http://img.moko.cc/users/0/39/11937/images/post/src/43b0d90c-ed66-405c-b5ed-f6aee5c397cb.jpg"]];
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://www.muyouguoji.com/static/kindeditor/attached/image/20140309/20140309114010_77385.jpg"]];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://www.muyouguoji.com/static/kindeditor/attached/image/20140309/20140309114010_77385.jpg"]];
    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://www.muyouguoji.com/static/kindeditor/attached/image/20140309/20140309113959_56227.jpg"]];
    
    self.max_Y = CGRectGetMaxY(bgView.frame);
    
    //类别
    UILabel * leibieLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.max_Y, Wscreen, 30*ScreenMultipleIn6)];
    leibieLabel.text = @"   类       别:";
    [self configTitleLabel:leibieLabel];
    [self.view addSubview:leibieLabel];
    
    self.leibieLabel = [[UILabel alloc]initWithFrame:CGRectMake(80*ScreenMultipleIn6, self.max_Y, Wscreen, 30*ScreenMultipleIn6)];
    self.leibieLabel.text = @"戒指";
    [self configContentLabel:self.leibieLabel];
    [self.view addSubview:self.leibieLabel];
    
    self.max_Y = CGRectGetMaxY(leibieLabel.frame);
    //编号
    UIView * bianhaoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.max_Y, Wscreen, 30*ScreenMultipleIn6)];
    bianhaoView.backgroundColor = TABLEVIEWCOLOR;
    [self.view addSubview:bianhaoView];
    
    UILabel * bianhaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Wscreen, 30*ScreenMultipleIn6)];
    bianhaoLabel.text = @"   编       号:";
    [self configTitleLabel:bianhaoLabel];
    [bianhaoView addSubview:bianhaoLabel];
    
    //材质
    self.max_Y = CGRectGetMaxY(bianhaoView.frame);
    UILabel * caizhiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.max_Y, Wscreen, 30*ScreenMultipleIn6)];
    caizhiLabel.text = @"   材       质:";
    [self configTitleLabel:caizhiLabel];
    [self.view addSubview:caizhiLabel];
    
    //工艺
    self.max_Y = CGRectGetMaxY(caizhiLabel.frame);
    UIView * gongyiView = [[UIView alloc]initWithFrame:CGRectMake(0, self.max_Y, Wscreen, 30*ScreenMultipleIn6)];
    gongyiView.backgroundColor = TABLEVIEWCOLOR;
    [self.view addSubview:gongyiView];
    
    UILabel * gongyiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Wscreen, 30*ScreenMultipleIn6)];
    gongyiLabel.text = @"   工       艺:";
    [self configTitleLabel:gongyiLabel];
    [gongyiView addSubview:gongyiLabel];
    
    //克重
    self.max_Y = CGRectGetMaxY(gongyiView.frame);
    UILabel * kezhongLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.max_Y, Wscreen, 30*ScreenMultipleIn6)];
    kezhongLabel.text = @"   克       重:";
    [self configTitleLabel:kezhongLabel];
    [self.view addSubview:kezhongLabel];
    
    //外观形态
    self.max_Y = CGRectGetMaxY(kezhongLabel.frame);
    UIView * waiguanView = [[UIView alloc]initWithFrame:CGRectMake(0, self.max_Y, Wscreen, 30*ScreenMultipleIn6)];
    waiguanView.backgroundColor = TABLEVIEWCOLOR;
    [self.view addSubview:waiguanView];
    
    UILabel * waiguanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Wscreen, 30*ScreenMultipleIn6)];
    waiguanLabel.text = @"   外观形态:";
    [self configTitleLabel:waiguanLabel];
    [waiguanView addSubview:waiguanLabel];
    
    //适合人群
    self.max_Y = CGRectGetMaxY(waiguanView.frame);
    UILabel * renqunLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.max_Y, Wscreen, 30*ScreenMultipleIn6)];
    renqunLabel.text = @"   适合人群:";
    [self configTitleLabel:renqunLabel];
    [self.view addSubview:renqunLabel];
    
    //规格尺寸
    self.max_Y = CGRectGetMaxY(renqunLabel.frame);
    UIView * chicunView = [[UIView alloc]initWithFrame:CGRectMake(0, self.max_Y, Wscreen, 30*ScreenMultipleIn6)];
    chicunView.backgroundColor = TABLEVIEWCOLOR;
    [self.view addSubview:chicunView];
    
    UILabel * chicunLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Wscreen, 30*ScreenMultipleIn6)];
    chicunLabel.text = @"   规格尺寸:";
    [self configTitleLabel:chicunLabel];
    [chicunView addSubview:chicunLabel];

}

//设置标题Label
-(void)configTitleLabel:(UILabel *)label{
    
    label.font = [UIFont systemFontOfSize:14*ScreenMultipleIn6];
    label.textColor = TEXTCOLOR;
}

//设置title旁边的内容Label
-(void)configContentLabel:(UILabel *)label{
    self.leibieLabel.font = [UIFont systemFontOfSize:14*ScreenMultipleIn6];
    self.leibieLabel.textColor = RGB_COLOR(51, 51, 51, 1);
}

//返回到上一个界面
-(void)backToFirstViewController{
    
    CATransition * animation = [CATransition animation];
    animation.type = @"pageUp";
    animation.duration = 1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.subtype = @"180cw";
    [self.navigationController.view.layer addAnimation:animation forKey:@"123"];
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
