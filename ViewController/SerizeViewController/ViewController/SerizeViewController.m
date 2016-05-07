
//
//  SerizeViewController.m
//  DianZTC
//
//  Created by 杨力 on 6/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "SerizeViewController.h"
#import "CatagoryViewController.h"
#import "SerizesCell.h"

//系列Cell
#define xilieCell @"xilieCell"

@interface SerizeViewController ()<UITableViewDataSource,UITableViewDelegate>

//导航条返回按钮
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * catagoryButton1;
@property (nonatomic,strong) UIView * addView;


//表格属性
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

//适配工具
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;

@end

@implementation SerizeViewController

-(void)viewWillAppear:(BOOL)animated{
    
    self.catagoryButton1.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.catagoryButton1.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏系统本身的“back”导航按钮
    self.navigationItem.hidesBackButton = YES;
    [self configUI];
}

-(void)configUI{
    
    self.view.backgroundColor = TABLEVIEWCOLOR;
    
    //导航条设置
    self.catagoryButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.catagoryButton1 setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    if(IS_IPHONE == IS_IPHONE_6){
        
        self.catagoryButton1.frame = CGRectMake(31/2.0*ScreenMultipleIn6, 21/2*ScreenMultipleIn6, 35/2.0*ScreenMultipleIn6, 25*ScreenMultipleIn6);
    }else{
        self.catagoryButton1.frame = CGRectMake(31/2.0*ScreenMultipleIn6, 22/2*ScreenMultipleIn6, 35/2.0*ScreenMultipleIn6, 25*ScreenMultipleIn6);
    }
    
    [self.navigationController.navigationBar addSubview:self.catagoryButton1];
    [self.catagoryButton1 addTarget:self action:@selector(backToFirstViewController) forControlEvents:UIControlEventTouchUpInside];
    
    //增加做导航按钮的接触面积
    self.addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100*ScreenMultipleIn6, NAV_BAR_HEIGHT/2.0+15*ScreenMultipleIn6)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backToFirstViewController)];
    [self.addView addGestureRecognizer:tap];
    [self.navigationController.navigationBar addSubview:self.addView];
    
    //导航条标题
    self.titleLabel = [Tools createLabelWithFrame:CGRectMake(10, 10, 100*ScreenMultipleIn6, 20*ScreenMultipleIn6) textContent:@"系列产品" withFont:[UIFont systemFontOfSize:17*ScreenMultipleIn6] textColor:RGB_COLOR(255, 255, 255, 1) textAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = self.titleLabel;
    
    //设置“分类”和“系列”
    [self setCatagoryAndSerize];
    
    //设置表格
    [self configTableView];
}

//设置“分类”和“系列”
-(void)setCatagoryAndSerize{
    
    //分类
    UIView * catagoryBgView = [[UIView alloc]initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, 375/2.0*ScreenMultipleIn6, 40*ScreenMultipleIn6)];
    catagoryBgView.backgroundColor = [UIColor whiteColor];
    //给catagoryBgView添加手势，跳转到分类界面
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backToFirstViewController)];
    [catagoryBgView addGestureRecognizer:tap];
    [self.view addSubview:catagoryBgView];
    UIImageView * catagoryImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fenlei"]];
    catagoryImageView.frame = CGRectMake(66*ScreenMultipleIn6, 13*ScreenMultipleIn6+NAV_BAR_HEIGHT, 35/2.0*ScreenMultipleIn6, 15*ScreenMultipleIn6);
    [self.view addSubview:catagoryImageView];
    
    self.max_X = CGRectGetMaxX(catagoryImageView.frame);
    self.max_Y = CGRectGetMinY(catagoryImageView.frame);
    
    UILabel * fenleiLabel = [Tools createLabelWithFrame:CGRectMake(self.max_X+10*ScreenMultipleIn6, self.max_Y, 80, 15*ScreenMultipleIn6) textContent:@"分类" withFont:[UIFont systemFontOfSize:16*ScreenMultipleIn6] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:fenleiLabel];
    
    //系列
    UIView * serizeBgView = [[UIView alloc]initWithFrame:CGRectMake(375/2.0*ScreenMultipleIn6, NAV_BAR_HEIGHT, 375/2.0*ScreenMultipleIn6, 40*ScreenMultipleIn6)];
    serizeBgView.backgroundColor = TABLEVIEWCOLOR;
    [self.view addSubview:serizeBgView];
    
    UIImageView * serizeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(66*ScreenMultipleIn6, 13*ScreenMultipleIn6, 35/2.0*ScreenMultipleIn6, 16*ScreenMultipleIn6)];
    serizeImageView.image = [UIImage imageNamed:@"xilie2"];
    [serizeBgView addSubview:serizeImageView];
    
    self.max_X = CGRectGetMaxX(serizeImageView.frame);
    self.max_Y = CGRectGetMinY(serizeImageView.frame);
    UILabel * serizeLabel = [Tools createLabelWithFrame:CGRectMake(self.max_X+10*ScreenMultipleIn6, self.max_Y, 80, 15*ScreenMultipleIn6) textContent:@"系列" withFont:[UIFont systemFontOfSize:15*ScreenMultipleIn6] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [serizeBgView addSubview:serizeLabel];
    
    //获取serizeBgView的底部frame
    self.max_Y = CGRectGetMaxY(serizeBgView.frame);
}

//设置“分类”和“系列”
-(void)configTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(10*ScreenMultipleIn6, self.max_Y+10*ScreenMultipleIn6, 710/2.0*ScreenMultipleIn6, (Hscreen - self.max_Y - 10*ScreenMultipleIn6))];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[SerizesCell class] forCellReuseIdentifier:xilieCell];
}

//表格的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SerizesCell * cell = [tableView dequeueReusableCellWithIdentifier:xilieCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell == nil){
        cell = [[SerizesCell alloc]init];
    }
    
    //    if(indexPath.section == 0){
    //
    //        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/12/56/27/30658PICDSX.jpg"]];
    //        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://www.zhidao12.com/admin/ueditor_change/asp/upload/image/20150817/14397848634686292.jpg"]];
    //        [cell.imageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://pic17.nipic.com/20111012/8582339_171357658115_2.jpg"]];
    //    }else if (indexPath.section == 1){
    //
    //        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://www.igocctv.com/igo/upload/image/201408/1407491786287.jpeg"]];
    //        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/13/78/69/44G58PICrZS_1024.jpg"]];
    //        [cell.imageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://pic1.nipic.com/2009-03-10/2009310185640423_2.jpg"]];
    //    }else if (indexPath.section == 2){
    //
    //        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://down1.sucaitianxia.com/psd02/psd173/psds33802.jpg"]];
    //        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://www.zhidao12.com/admin/ueditor_change/asp/upload/image/20150817/14397848634686292.jpg"]];
    //        [cell.imageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://img6.faloo.com/Picture/680x580/1/1483/1483060.jpg"]];
    //    }else if (indexPath.section == 3){
    //
    //        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://img3.3lian.com/2006/002/07/029.jpg"]];
    //        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic20.nipic.com/20120428/2457387_160543488000_2.jpg"]];
    //        [cell.imageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://img05.tooopen.com/images/20140930/sy_72339846163.jpg"]];
    //    }else{
    //
    //        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/13/78/54/49t58PICUqk_1024.jpg"]];
    //        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/13/78/00/35M58PIChex_1024.jpg"]];
    //        [cell.imageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://img.taopic.com/uploads/allimg/140516/234771-14051622223483.jpg"]];
    //    }
    
http://pic.58pic.com/58pic/13/77/84/16E58PICGph_1024.jpg
#define imageUrl @"http://pic.58pic.com/58pic/13/80/10/94f58PICvp8_1024.jpg"
    [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    [cell.imageView3 sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return (20+165)/2.0*ScreenMultipleIn6;
}

//建立组头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44*ScreenMultipleIn6)];
    headerView.backgroundColor = [UIColor whiteColor];
    NSArray * titleArray = @[@"芭莎系列",@"婚庆系列",@"欧美流金系列",@"怦然心动系列",@"丝丝心动系列"];
    
    //设置标题Label
    UILabel * titleLabel = [Tools createLabelWithFrame:CGRectMake(10,10, 100, 10) textContent:titleArray[section] withFont:[UIFont systemFontOfSize:16*ScreenMultipleIn6] textColor:RGB_COLOR(165, 129, 68, 1) textAlignment:NSTextAlignmentCenter];
    [titleLabel sizeToFit];
    titleLabel.center = headerView.center;
    titleLabel.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:titleLabel];
    
    //设置两边的圈圈
    self.max_X = CGRectGetMinX(titleLabel.frame);
    self.max_Y = CGRectGetMinY(titleLabel.frame);
    UIImageView * leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.max_X-15*ScreenMultipleIn6,self.max_Y+6.5*ScreenMultipleIn6 , 5*ScreenMultipleIn6, 5*ScreenMultipleIn6)];
    leftImageView.image = [UIImage imageNamed:@"quan"];
    [headerView addSubview:leftImageView];
    
    self.max_X = CGRectGetMaxX(titleLabel.frame);
    [Tools createImageViewWithFrame:CGRectMake(self.max_X+10*ScreenMultipleIn6, self.max_Y+6.5*ScreenMultipleIn6, 5*ScreenMultipleIn6, 5*ScreenMultipleIn6) imageName:@"quan" View:headerView];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44*ScreenMultipleIn6;
}

//返回上一个界面
-(void)backToFirstViewController{
    
    CatagoryViewController * catagoryViewController = [[CatagoryViewController alloc]init];
    
    CATransition * animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:animation forKey:@"123"];
    [self.navigationController pushViewController:catagoryViewController animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
