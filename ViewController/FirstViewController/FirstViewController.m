//
//  FirstViewController.m
//  DianZTC
//
//  Created by 杨力 on 4/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "FirstViewController.h"
#import "CatagoryViewController.h"
#import "DetailViewController.h"
#import "SerizeCell.h"
#import "ProductCell.h"

#define serizeCell @"serizeCell"
#define productCell @"productCell"

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SDCycleScrollViewDelegate>

//导航栏搜索输入框
@property (nonatomic,strong) UITextField * searchTextField;
@property (nonatomic,strong) UIButton * catagoryButton;
@property (nonatomic,strong) UIView * addView;

//表格属性
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
//轮播图
@property (nonatomic,strong) SDCycleScrollView * cycleScrollView;
//Logo的View
@property (nonatomic,strong) UIView * logoView;

//适配工具
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;

@end

@implementation FirstViewController

//界面即将消失时
-(void)viewWillDisappear:(BOOL)animated{
    
    self.catagoryButton.hidden = YES;
    self.searchTextField.hidden = YES;
    self.addView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.catagoryButton.hidden = NO;
    self.searchTextField.hidden = NO;
    self.addView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏系统的“返回导航按钮”
    self.navigationItem.hidesBackButton = YES;
    
    //导航条设置
    [self setNavigation];
}

//导航条设置
-(void)setNavigation{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = NAVICOLOR;
    
    self.catagoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.catagoryButton.frame = CGRectMake(14*ScreenMultipleIn6, 23/2.0*ScreenMultipleIn6, 57/2.0*ScreenMultipleIn6, 22*ScreenMultipleIn6);
    [self.catagoryButton setBackgroundImage:[UIImage imageNamed:@"class"] forState:UIControlStateNormal];
    [self.catagoryButton addTarget:self action:@selector(pushForwardCatagoryController) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.catagoryButton];
    
    //增加做导航按钮的接触面积
    self.addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100*ScreenMultipleIn6, NAV_BAR_HEIGHT/2.0+15*ScreenMultipleIn6)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushForwardCatagoryController)];
    [self.addView addGestureRecognizer:tap];
    [self.navigationController.navigationBar addSubview:self.addView];
    
    if(IS_IPHONE == IS_IPHONE_5||IS_IPHONE == IS_IPHONE_4_OR_LESS){
        
        self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake((28+57+28)/2.0*ScreenMultipleIn6, 16/2.0*ScreenMultipleIn6, 290*ScreenMultipleIn6, 62/2.0*ScreenMultipleIn6)];
    }else{
        self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake((28+57+28)/2.0*ScreenMultipleIn6, 16/2.0*ScreenMultipleIn6, 290*ScreenMultipleIn6, 55/2.0*ScreenMultipleIn6)];
    }
    
    self.searchTextField.backgroundColor = [UIColor whiteColor];
    self.searchTextField.layer.cornerRadius = 55/4.0*ScreenMultipleIn6;
    self.searchTextField.clipsToBounds = YES;
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,(25+7.5)*ScreenMultipleIn6 , 55/2.0*ScreenMultipleIn6)];
    UIImageView * leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenMultipleIn6, 15/2.0*ScreenMultipleIn6, 29/2.0*ScreenMultipleIn6, 29/2.0*ScreenMultipleIn6)];
    leftImageView.image = [UIImage imageNamed:@"search"];
    [leftView addSubview:leftImageView];
    self.searchTextField.leftView = leftView;
    self.searchTextField.delegate = self;
    self.searchTextField.leftViewMode =UITextFieldViewModeAlways;
    self.searchTextField.placeholder = @"输入您想要的宝贝";
    self.searchTextField.textAlignment = NSTextAlignmentJustified;
    [self.navigationController.navigationBar addSubview:self.searchTextField];
    
    //改变输入框placeholder的字体大小和颜色
    [self.searchTextField setValue:RGB_COLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    self.searchTextField.font = [UIFont systemFontOfSize:14*ScreenMultipleIn6];
    //改变输入框输入时字体的颜色
    self.searchTextField.textColor = RGB_COLOR(153, 153, 153, 1);
    self.searchTextField.font = [UIFont systemFontOfSize:14*ScreenMultipleIn6];
    
    //设置表格frame
    [self setTableView];
    
    //设置下面的集团LOGO
    [self setLogo];
}

//设置表格frame
-(void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, Wscreen, Hscreen-NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = TABLEVIEWCOLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置表头
    self.tableView.tableHeaderView = self.cycleScrollView;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView reloadData];
    
    [self.tableView registerClass:[SerizeCell class] forCellReuseIdentifier:serizeCell];
    [self.tableView registerClass:[ProductCell class] forCellReuseIdentifier:productCell];
}

//表格的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        SerizeCell * cell = [tableView dequeueReusableCellWithIdentifier:serizeCell];
        if(cell == nil){
            
            cell = [[SerizeCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        
        ProductCell * cell = [tableView dequeueReusableCellWithIdentifier:productCell];
        if(cell == nil){
            
            cell = [[ProductCell alloc]init];
        }
        
        cell.imageView1.userInteractionEnabled = YES;
        cell.imageView2.userInteractionEnabled = YES;
        
        if(indexPath.section == 1){
            
            //加载图片
                [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://pic5.nipic.com/20100120/3486811_172042813540_2.jpg"]];
                [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/13/80/08/64X58PIChRv_1024.jpg"]];
            
            cell.title1.text = @"珍珠项链";
            cell.title2.text = @"心型戒指";
            
        }else if(indexPath.section ==2){
            
            [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://img0.pclady.com.cn/pclady/1410/24/1219929_zhu4.jpg"]];
            [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/13/80/10/94f58PICvp8_1024.jpg"]];
            
            cell.title1.text = @"人气手镯";
            cell.title2.text = @"人气吊坠";
        }
        
        //给首页的图片添加手势
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewAction:)];
        [cell.imageView1 addGestureRecognizer:tap1];
        UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewAction:)];
        [cell.imageView2 addGestureRecognizer:tap2];
        
        return cell;
    }
}

//给首页的图片添加手势
-(void)imageViewAction:(UITapGestureRecognizer *)tap{
    
    DetailViewController * detailVc = [[DetailViewController alloc]init];
    CATransition * animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.duration = 1.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.subtype = @"180cw";
    [self.navigationController.view.layer addAnimation:animation forKey:@"123"];
    [self.navigationController pushViewController:detailVc animated:NO];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0)
    {
        return (10+10+115)*ScreenMultipleIn6;
    }else{
        
        return (24+345+20)/2.0*ScreenMultipleIn6;
    }
}

//-(vo)

//组头设置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray * sectionImageNameArray = @[@"new",@"hot"];
    NSArray *sectionTitleArray = @[@"新款产品",@"人气产品"];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Wscreen, 40*ScreenMultipleIn6)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * sectionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(306/2.0*ScreenMultipleIn6, 13*ScreenMultipleIn6, 15*ScreenMultipleIn6, 15*ScreenMultipleIn6)];
    [view addSubview:sectionImageView];
    
    self.max_X = CGRectGetMaxX(sectionImageView.frame);
    self.max_Y = CGRectGetMinY(sectionImageView.frame);
    
    UILabel * sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.max_X+6.5*ScreenMultipleIn6, self.max_Y,60*ScreenMultipleIn6, 15*ScreenMultipleIn6)];
    sectionLabel.font = [UIFont systemFontOfSize:15*ScreenMultipleIn6];
    sectionLabel.textColor = RGB_COLOR(76, 76, 76, 1);
    [view addSubview:sectionLabel];
    
    if(section == 1){
        
        sectionImageView.image = [UIImage imageNamed:sectionImageNameArray[0]];
        sectionLabel.text = sectionTitleArray[0];
        
    }else if(section == 2){
        
        sectionImageView.image = [UIImage imageNamed:sectionImageNameArray[1]];
        sectionLabel.text = sectionTitleArray[1];
    }
    
    self.max_X = CGRectGetMaxX(sectionLabel.frame);
    self.max_Y = CGRectGetMinY(sectionLabel.frame);
    
    UILabel * moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.max_X+200/2.0*ScreenMultipleIn6, 12*ScreenMultipleIn6, 100, 15*ScreenMultipleIn6)];
    moreLabel.text = @"更多";
    moreLabel.textAlignment = NSTextAlignmentLeft;
    moreLabel.textColor = RGB_COLOR(136, 136, 136, 1);
    moreLabel.font = [UIFont systemFontOfSize:13*ScreenMultipleIn6];
    [view addSubview:moreLabel];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section != 0){
        
        return 40*ScreenMultipleIn6;
    }else{
        
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//设置下面的集团LOGO
-(void)setLogo{
    
     CGFloat bottomHeight = (28+68+16)/2*ScreenMultipleIn6;
    self.logoView = [[UIView alloc]initWithFrame:CGRectMake(0, Hscreen - bottomHeight, Wscreen, bottomHeight)];
    self.logoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.logoView];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0,0,Wscreen, 1*ScreenMultipleIn6)];
    lineView.backgroundColor = NAVICOLOR;
    [self.logoView addSubview:lineView];
    
    self.max_Y = CGRectGetMaxY(lineView.frame);
    UIImageView * logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(115/2.0*ScreenMultipleIn6, self.max_Y+10*ScreenMultipleIn6, 200/2.0*ScreenMultipleIn6, 70/2.0*ScreenMultipleIn6)];
    logoImageView.image = [UIImage imageNamed:@"logo"];
    [self.logoView addSubview:logoImageView];
    
    self.max_X = CGRectGetMaxX(logoImageView.frame);
    self.max_Y = CGRectGetMinY(logoImageView.frame);
    
    UIImageView * positionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.max_X+22*ScreenMultipleIn6, self.max_Y,8*ScreenMultipleIn6,10*ScreenMultipleIn6)];
    positionImageView.image = [UIImage imageNamed:@"Add"];
    [self.logoView addSubview:positionImageView];
    
    self.max_X = CGRectGetMaxX(positionImageView.frame);
    
    UILabel * positionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.max_X+5*ScreenMultipleIn6, self.max_Y, 300*ScreenMultipleIn6, 10*ScreenMultipleIn6)];
    positionLabel.text = @"深圳市罗湖区水贝二路特力大厦3楼";
    positionLabel.textColor = LOGOTEXTCOLOR;
    positionLabel.font = [UIFont systemFontOfSize:9*ScreenMultipleIn6];
    [self.logoView addSubview:positionLabel];
    
    self.max_Y = CGRectGetMaxY(positionImageView.frame);
    self.max_X = CGRectGetMinX(positionImageView.frame);
    
    
    UIImageView * telImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.max_X, self.max_Y+5*ScreenMultipleIn6, 8*ScreenMultipleIn6, 8.5*ScreenMultipleIn6)];
    telImageView.image = [UIImage imageNamed:@"Tel"];
    [self.logoView addSubview:telImageView];
    
    self.max_X = CGRectGetMaxX(telImageView.frame);
    UILabel * telLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.max_X+5*ScreenMultipleIn6, self.max_Y+5*ScreenMultipleIn6, 300*ScreenMultipleIn6, 8.5*ScreenMultipleIn6)];
    telLabel.text = @"0755-22929812";
    telLabel.textColor = LOGOTEXTCOLOR;
    telLabel.font = [UIFont systemFontOfSize:9*ScreenMultipleIn6];
    [self.logoView addSubview:telLabel];
    
    self.max_Y = CGRectGetMaxY(telImageView.frame);
    self.max_X = CGRectGetMinX(telImageView.frame);
    
    UIImageView * netImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.max_X, self.max_Y+5*ScreenMultipleIn6, 8*ScreenMultipleIn6, 8.5*ScreenMultipleIn6)];
    netImageView.image = [UIImage imageNamed:@"web"];
    [self.logoView addSubview:netImageView];
    
    self.max_X = CGRectGetMaxX(netImageView.frame);
    UILabel * netLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.max_X+5*ScreenMultipleIn6, self.max_Y+5*ScreenMultipleIn6, 300*ScreenMultipleIn6, 8.5*ScreenMultipleIn6)];
    netLabel.text = @"www.batar.cn";
    netLabel.font = [UIFont systemFontOfSize:9*ScreenMultipleIn6];
    netLabel.textColor = LOGOTEXTCOLOR;
    [self.logoView addSubview:netLabel];
}

//滑动表格显示／隐藏下面的Logo
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if(velocity.y>0){
        
        [UIView animateWithDuration:0.3 animations:^{
           
            self.logoView.transform = CGAffineTransformMakeTranslation(0, self.logoView.frame.size.height);
            
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            
            self.logoView.transform = CGAffineTransformIdentity;
            
        }];
        
    }
    
    [self.searchTextField resignFirstResponder];
}
//跳回详细分类界面
-(void)pushForwardCatagoryController{
    
    CatagoryViewController * cataViewController = [[CatagoryViewController alloc]init];
    [self.navigationController pushViewController:cataViewController animated:YES];
}

//轮播图的代理方法
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}

//懒加载
-(SDCycleScrollView *)cycleScrollView{
    
    if(_cycleScrollView == nil){
        
        NSArray *imagesURLStrings = @[@"http://pic5.nipic.com/20100120/3486811_172042813540_2.jpg",
                                      @"http://pic.58pic.com/58pic/13/80/14/21f58PICiJW_1024.jpg",
                                      @"http://pic.58pic.com/58pic/13/80/10/94f58PICvp8_1024.jpg",
                                      @"http://upload.dahangzhou.com/merchant/2009/9/16/20099161519204983.jpg"
                                      ];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,Wscreen,150*ScreenMultipleIn6) delegate:self placeholderImage:[UIImage imageWithCaputureView:self.view]];
        _cycleScrollView.imageURLStringsGroup = imagesURLStrings;
        _cycleScrollView.delegate = self;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleScrollView.currentPageDotColor = RGB_COLOR(215, 185, 29, 1); // 自定义分页控件小圆标颜色
        _cycleScrollView.pageControlAliment = NSTextAlignmentCenter;
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"lb1"];
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"lb2"];
        _cycleScrollView.pageDotColor = RGB_COLOR(221, 193, 191, 1);
        _cycleScrollView.pageControlDotSize = CGSizeMake(8*ScreenMultipleIn6,8*ScreenMultipleIn6);
    }
    
    return _cycleScrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end