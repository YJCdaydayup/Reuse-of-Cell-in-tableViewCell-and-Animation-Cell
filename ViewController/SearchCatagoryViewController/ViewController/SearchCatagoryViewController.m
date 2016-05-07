//
//  SearchCatagoryViewController.m
//  DianZTC
//
//  Created by 杨力 on 6/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "SearchCatagoryViewController.h"
#import "CatagoryViewController.h"
#import "MutileSearchCell.h"


//多类搜索Cell
#define mutileCell @"mutileCell"

@interface SearchCatagoryViewController ()<UITableViewDataSource,UITableViewDelegate>

//左导航按钮
@property (nonatomic,strong) UIButton * navLeftButton;
//导航栏标题
@property (nonatomic,strong) UILabel * titlelabel;

//表格属性
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

//连接cell中的三个图片
@property (nonatomic,strong) UIImageView * imageView1;
@property (nonatomic,strong) UIImageView * imageView2;
@property (nonatomic,strong) UIImageView * imageView3;

//适配工具
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;

@end

@implementation SearchCatagoryViewController

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
   
//    隐藏系统“back”左导航按钮
    self.navigationItem.hidesBackButton = YES;
    
    [self configUI];
}

-(void)configUI{
    
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
    self.titlelabel = [Tools createLabelWithFrame:CGRectMake(10, 10, 100*ScreenMultipleIn6, 20*ScreenMultipleIn6) textContent:@"分类多选搜索"
                                         withFont:[UIFont systemFontOfSize:17*ScreenMultipleIn6] textColor:RGB_COLOR(255, 255, 255, 1) textAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = self.titlelabel;
    
    //设置表格
    [self configTableView];
}

-(void)configTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Wscreen, Hscreen)];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = TABLEVIEWCOLOR;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[MutileSearchCell class] forCellReuseIdentifier:mutileCell];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.pinleiArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MutileSearchCell * cell = [tableView dequeueReusableCellWithIdentifier:mutileCell];
    if(cell == nil){
        
        cell = [[MutileSearchCell alloc]init];
    }
    
    self.imageView1 = cell.imageView1;
    self.imageView2 = cell.imageView2;
    self.imageView3 = cell.imageView3;
    
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/13/77/93/30758PICIJ5_1024.jpg"]];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic1.ooopic.com/uploadfilepic/yuanwenjian/2009-05-27/OOOPIC_meilifangcheng_2009052764d5804d283aed90.jpg"]];
    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/13/77/84/63858PICarh_1024.jpg"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return (20+165+18+20)/2.0*ScreenMultipleIn6;
}

//组头设置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Wscreen, 77/2.0*ScreenMultipleIn6)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLabel = [Tools createLabelWithFrame:CGRectMake(35/2.0*ScreenMultipleIn6, 15*ScreenMultipleIn6, 100, 27/2.0*ScreenMultipleIn6) textContent:self.pinleiArray[section] withFont:[UIFont systemFontOfSize:14*ScreenMultipleIn6] textColor:NAVICOLOR textAlignment:NSTextAlignmentLeft];
    [bgView addSubview:titleLabel];
    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 77/2.0*ScreenMultipleIn6;
}
//返回到上一个界面
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
