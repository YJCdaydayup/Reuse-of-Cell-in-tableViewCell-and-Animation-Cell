


//
//  ThemeViewController.m
//  DianZTC
//
//  Created by 杨力 on 9/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "ThemeViewController.h"
#import "FirstViewController.h"
#import "ThemeCell.h"


#define themeCell @"themeCell"

@interface ThemeViewController ()<UITableViewDataSource,UITableViewDelegate>

//左导航按钮和导航栏标题
@property (nonatomic,strong) UIButton * navLeftButton;
@property (nonatomic,strong) UILabel * titlelabel;

//主题属性
@property (nonatomic,strong) NSMutableArray * themeArray;
@property (nonatomic,strong) UITableView * productTableView;
@property (nonatomic,strong) NSMutableArray * productArray;

//适配工具
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;

@end

@implementation ThemeViewController

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
    
    //界面设置
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
    self.titlelabel = [Tools createLabelWithFrame:CGRectMake(10, 10, 100*ScreenMultipleIn6, 20*ScreenMultipleIn6) textContent:self.themeTitle
                                         withFont:[UIFont systemFontOfSize:18*ScreenMultipleIn6] textColor:RGB_COLOR(255, 255, 255, 1) textAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = self.titlelabel;
    
    //设置主题
    [self setThemeTableView1];
    //设置主题表格
    [self setProductTableView1];
}

//设置主题表格
-(void)setThemeTableView1{
    
    for(int i = 0;i<self.themeArray.count;i++){
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, NAV_BAR_HEIGHT+i*41*ScreenMultipleIn6+0.3*ScreenMultipleIn6, 96*ScreenMultipleIn6, 41*ScreenMultipleIn6);
        [button setTitle:self.themeArray[i] forState:UIControlStateNormal];
        [button setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.layer.borderColor = [RGB_COLOR(227, 227, 227, 1)CGColor];
        button.layer.borderWidth = 0.3f*ScreenMultipleIn6;
        button.titleLabel.font = [UIFont systemFontOfSize:15*ScreenMultipleIn6];
        [self.view addSubview:button];
        
        if(i == 0){
            
            button.selected = YES;
            button.backgroundColor = RGB_COLOR(138, 85, 49, 1);
        }
        
        //给予button的tag从100开始
        button.tag = i+100;
        [button addTarget:self action:@selector(changeTheme:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//改变主题
-(void)changeTheme:(UIButton *)button{
    
    for(int i = 0;i<self.themeArray.count;i++){
        
        UIButton * button = (UIButton *)[self.view viewWithTag:100+i];
        button.selected = NO;
        button.backgroundColor = [UIColor whiteColor];
    }
    
    button.selected = YES;
    button.backgroundColor = RGB_COLOR(135, 85, 49, 1);
    
    //改变表格ProductTableView的偏移位置
    [self.productTableView reloadData];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:1 inSection:button.tag-100];
    [self.productTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

-(void)setProductTableView1{
    
    self.productTableView = [[UITableView alloc]initWithFrame:CGRectMake(96*ScreenMultipleIn6-0.5*ScreenMultipleIn6, NAV_BAR_HEIGHT, (220+340)/2.0*ScreenMultipleIn6,Hscreen-NAV_BAR_HEIGHT)];
    self.productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.productTableView.tableFooterView = [[UIView alloc]init];
    self.productTableView.delegate = self;
    self.productTableView.dataSource = self;
    [self.view addSubview:self.productTableView];
    [self.productTableView reloadData];
    
    self.productTableView.layer.borderColor = [RGB_COLOR(227, 227, 227, 1)CGColor];
    self.productTableView.layer.borderWidth = 0.5f*ScreenMultipleIn6;
    [self.productTableView registerClass:[ThemeCell class] forCellReuseIdentifier:themeCell];
}

//表格的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.themeArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //每个主题下的种类数量
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ThemeCell * cell = [tableView dequeueReusableCellWithIdentifier:themeCell];
    if(cell == nil){
        cell = [[ThemeCell alloc]init];
    }
    
    cell.titleLabel.text = self.productArray[indexPath.row];
    if(indexPath.row == 0){
        [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/13/82/13/87U58PICKNt_1024.jpg"]];
    }else if (indexPath.row == 1){
        
        [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic5.nipic.com/20100116/2413527_235821041844_2.jpg"]];
    }else if (indexPath.row == 2){
        
        [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.taopic.com/uploads/allimg/130809/318761-130P921351546.jpg"]];
    }else if (indexPath.row == 3){
        
        [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.taopic.com/uploads/allimg/120119/2257-12011912140092.jpg"]];
    }else{
        [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic47.nipic.com/20140909/1369025_095728151890_2.jpg"]];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 165/2.0*ScreenMultipleIn6;
}

//组头设置

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.productTableView.frame.size.width, 30*ScreenMultipleIn6)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 30*ScreenMultipleIn6, headerView.frame.size.width, 1*ScreenMultipleIn6)];
    lineView.backgroundColor = RGB_COLOR(187, 164, 143, 1);
    [headerView addSubview:lineView];
    
    //设置标题Label
    UILabel * titleLabel = [Tools createLabelWithFrame:CGRectMake(10,10, 100, 10) textContent:self.themeArray[section] withFont:[UIFont systemFontOfSize:15*ScreenMultipleIn6] textColor:RGB_COLOR(165, 129, 68, 1) textAlignment:NSTextAlignmentCenter];
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
    
    return 30*ScreenMultipleIn6;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //根据偏移量找到是属于表格的哪一个indexPath对象
    NSIndexPath *path =  [self.productTableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    
    for(int i = 0;i<self.themeArray.count;i++){
        
        UIButton * button = (UIButton *)[self.view viewWithTag:100+i];
        button.selected = NO;
        button.backgroundColor = [UIColor whiteColor];
    }
    
    UIButton * button = (UIButton *)[self.view viewWithTag:100+path.section];
    
    button.selected = YES;
    button.backgroundColor = RGB_COLOR(135, 85, 49, 1);
}

//返回首页
-(void)backToFirstViewController{
    
    FirstViewController * firstViewController = [[FirstViewController alloc]init];
    
    CATransition * animation = [CATransition animation];
    animation.type = @"cube";
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:animation forKey:@"123"];
    [self.navigationController pushViewController:firstViewController animated:NO];
}

//懒加载
-(NSMutableArray *)themeArray{
    
    if(_themeArray == nil){
        
        _themeArray = [[NSMutableArray alloc]initWithObjects:@"戚薇主题",@"刘萌萌主题",@"佟丽娅主题",@"李易峰主题",@"戒指",@"项链",@"手镯",@"挂坠",@"耳环", nil];
    }
 
    return _themeArray;
}

-(NSMutableArray *)productArray{
    
    if(_productArray == nil){
        
        _productArray = [[NSMutableArray alloc]initWithObjects:@"戒指",@"项链",@"手镯",@"挂坠",@"耳环",nil];
    }
    return _productArray;
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
