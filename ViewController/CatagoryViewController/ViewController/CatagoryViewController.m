//
//  CatagoryViewController.m
//  DianZTC
//
//  Created by 杨力 on 5/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "CatagoryViewController.h"
#import "SerizeViewController.h"
#import "FirstViewController.h"
#import "SearchCatagoryViewController.h"
#import "SingleSearchCatagoryViewController.h"
#import "PingleiCell.h"
#import "GongYiCell.h"
#import "CaizhiCell.h"
#import "WaixingCell.h"
#import "KezhongCell.h"

//品类cell
#define pinleiCell @"pinleiCell"
//工艺cell
#define gongyiCell @"gongyiCell"
//材质cell
#define caizhiCell @"caizhiCell"
//外形cell
#define waixingCell @"waixingCell"
//克重cell
#define kezhongCell @"kezhongCell"

@interface CatagoryViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

//导航条返回按钮
@property (nonatomic,strong) UITextField * searchTextField1;
@property (nonatomic,strong) UIButton * catagoryButton1;
@property (nonatomic,strong) UIView * addView;

//表格属性
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

//品类选中后将title放入数组中
/*品类按钮的名称*/@property (nonatomic,strong) NSMutableArray * pinleiButtonNameArray;
/*将各个按钮放在这个数组中*/@property (nonatomic,strong) NSMutableArray * pinleiButtonArray;
/*品类标签放在这个数组中*/@property (nonatomic,strong) NSMutableArray * pinleiFlagArray;
/*最后选中的品类，放在这个数组中*/@property (nonatomic,strong) NSMutableArray * pinleiSelectedArray;


/**判断cell伸缩的BOOl值**/
//“品类”更多button
@property (nonatomic,strong) UIButton * moreButton1;
@property (nonatomic,strong) NSIndexPath * indexPath1;
@property (nonatomic,strong) UIImageView * xuanzhanImageView1;
@property (nonatomic,assign) BOOL flag1;
//“外形”更多button
@property (nonatomic,strong) UIButton * moreButton2;
@property (nonatomic,strong) NSIndexPath * indexPath2;
@property (nonatomic,strong) UIImageView * xuanzhanImageView2;
@property (nonatomic,assign) BOOL flag2;


//适配工具
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;

@end

@implementation CatagoryViewController

-(void)viewWillDisappear:(BOOL)animated{
    
    self.catagoryButton1.hidden = YES;
    self.searchTextField1.hidden = YES;
    self.addView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.catagoryButton1.hidden = NO;
    self.searchTextField1.hidden = NO;
    self.addView.hidden = NO;
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
    
    //设置输入框
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = NAVICOLOR;
    
    if(IS_IPHONE == IS_IPHONE_5||IS_IPHONE == IS_IPHONE_4_OR_LESS){
        
        self.searchTextField1 = [[UITextField alloc]initWithFrame:CGRectMake((28+57+28)/2.0*ScreenMultipleIn6, 16/2.0*ScreenMultipleIn6, 290*ScreenMultipleIn6, 62/2.0*ScreenMultipleIn6)];
    }else{
        self.searchTextField1 = [[UITextField alloc]initWithFrame:CGRectMake((28+57+28)/2.0*ScreenMultipleIn6, 16/2.0*ScreenMultipleIn6, 290*ScreenMultipleIn6, 55/2.0*ScreenMultipleIn6)];
    }
    self.searchTextField1.backgroundColor = [UIColor whiteColor];
    self.searchTextField1.layer.cornerRadius = 55/4.0*ScreenMultipleIn6;
    self.searchTextField1.clipsToBounds = YES;
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,(25+7.5)*ScreenMultipleIn6 , 55/2.0*ScreenMultipleIn6)];
    UIImageView * leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenMultipleIn6, 15/2.0*ScreenMultipleIn6, 29/2.0*ScreenMultipleIn6, 29/2.0*ScreenMultipleIn6)];
    leftImageView.image = [UIImage imageNamed:@"search"];
    [leftView addSubview:leftImageView];
    self.searchTextField1.leftView = leftView;
    self.searchTextField1.delegate = self;
    self.searchTextField1.leftViewMode =UITextFieldViewModeAlways;
    self.searchTextField1.placeholder = @"输入您想要的宝贝";
    self.searchTextField1.textAlignment = NSTextAlignmentJustified;
    [self.navigationController.navigationBar addSubview:self.searchTextField1];
    //改变输入框placeholder的字体大小和颜色
    [self.searchTextField1 setValue:RGB_COLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
    self.searchTextField1.font = [UIFont systemFontOfSize:14*ScreenMultipleIn6];
    //改变输入框输入时字体的颜色
    self.searchTextField1.textColor = RGB_COLOR(153, 153, 153, 1);
    self.searchTextField1.font = [UIFont systemFontOfSize:14*ScreenMultipleIn6];
    
    //设置“分类”和“系列“
    [self setCatagoryView];
    
    //表格设置
    [self setCataTableView];
}

//设置“分类”和“系列“
-(void)setCatagoryView{
    
    //分类
    UIImageView * catagoryImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fenlei"]];
    catagoryImageView.frame = CGRectMake(66*ScreenMultipleIn6, 13*ScreenMultipleIn6+NAV_BAR_HEIGHT, 35/2.0*ScreenMultipleIn6, 15*ScreenMultipleIn6);
    [self.view addSubview:catagoryImageView];
    
    self.max_X = CGRectGetMaxX(catagoryImageView.frame);
    self.max_Y = CGRectGetMinY(catagoryImageView.frame);
    
    UILabel * fenleiLabel = [Tools createLabelWithFrame:CGRectMake(self.max_X+10*ScreenMultipleIn6, self.max_Y, 80, 15*ScreenMultipleIn6) textContent:@"分类" withFont:[UIFont systemFontOfSize:16*ScreenMultipleIn6] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:fenleiLabel];
    
    //系列
    UIView * serizeBgView = [[UIView alloc]initWithFrame:CGRectMake(375/2.0*ScreenMultipleIn6, NAV_BAR_HEIGHT, 375/2.0*ScreenMultipleIn6, 40*ScreenMultipleIn6)];
    serizeBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:serizeBgView];
    
    UIImageView * serizeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(66*ScreenMultipleIn6, 13*ScreenMultipleIn6, 35/2.0*ScreenMultipleIn6, 16*ScreenMultipleIn6)];
    serizeImageView.image = [UIImage imageNamed:@"xilie2"];
    [serizeBgView addSubview:serizeImageView];
    
    self.max_X = CGRectGetMaxX(serizeImageView.frame);
    self.max_Y = CGRectGetMinY(serizeImageView.frame);
    UILabel * serizeLabel = [Tools createLabelWithFrame:CGRectMake(self.max_X+10*ScreenMultipleIn6, self.max_Y, 80, 15*ScreenMultipleIn6) textContent:@"系列" withFont:[UIFont systemFontOfSize:15*ScreenMultipleIn6] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [serizeBgView addSubview:serizeLabel];
    
    //给serizeBgView添加手势，跳转到系列界面
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushForwardSerizeController)];
    [serizeBgView addGestureRecognizer:tap];
    
    //获取serizeBgView的底部frame
    self.max_Y = CGRectGetMaxY(serizeBgView.frame);
}

//表格设置
-(void)setCataTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.max_Y+10*ScreenMultipleIn6, Wscreen, Hscreen-10*ScreenMultipleIn6-self.max_Y) style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = TABLEVIEWCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    //表尾设置
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Wscreen, 50*ScreenMultipleIn6)];
    footerView.backgroundColor = NAVICOLOR;
    //添加手势，点击搜索分类信息
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchCatagory)];
    [footerView addGestureRecognizer:tap];
    UIImageView * searchImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_01"]];
    searchImageView.frame = CGRectMake(245/2.0*ScreenMultipleIn6, 33/2.0*ScreenMultipleIn6, 35/2.0*ScreenMultipleIn6, 17*ScreenMultipleIn6);
    [footerView addSubview:searchImageView];
    
    self.max_X = CGRectGetMaxX(searchImageView.frame);
    
    UILabel * searchLabel = [Tools createLabelWithFrame:CGRectMake(self.max_X+10*ScreenMultipleIn6, 33/2.0*ScreenMultipleIn6, 200, 17*ScreenMultipleIn6) textContent:@"分类多选搜索" withFont:[UIFont systemFontOfSize:17*ScreenMultipleIn6] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [footerView addSubview:searchLabel];
    self.tableView.tableFooterView = footerView;
    
    [self.tableView registerClass:[PingleiCell class] forCellReuseIdentifier:pinleiCell];
    [self.tableView registerClass:[GongYiCell class] forCellReuseIdentifier:gongyiCell];
    [self.tableView registerClass:[CaizhiCell class] forCellReuseIdentifier:caizhiCell];
    [self.tableView registerClass:[WaixingCell class] forCellReuseIdentifier:waixingCell];
    [self.tableView registerClass:[KezhongCell class] forCellReuseIdentifier:kezhongCell];
}

//添加手势，点击搜索分类信息
-(void)searchCatagory{
    
    //遍历数组，找出哪些“品类”被选中
    for(int i = 0;i<PINLEICOUNT-1;i++){
        
        if([self.pinleiFlagArray[i] intValue] == YES){
            
            [self.pinleiSelectedArray addObject:self.pinleiButtonNameArray[i]];
        }
    }
    
    CATransition * animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:animation forKey:@"123"];
    
    if(self.pinleiSelectedArray.count >1){
        SearchCatagoryViewController * searchCatagoryViewController = [[SearchCatagoryViewController alloc]init];
        searchCatagoryViewController.pinleiArray = self.pinleiSelectedArray;
        [self.navigationController pushViewController:searchCatagoryViewController animated:NO];
    }else{
        
        SingleSearchCatagoryViewController * singleVc = [[SingleSearchCatagoryViewController alloc]init];
        singleVc.pinleiArray = self.pinleiSelectedArray;
        [self.navigationController pushViewController:singleVc animated:NO];
    }
}

//表格的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        PingleiCell * cell = [tableView dequeueReusableCellWithIdentifier:pinleiCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.indexPath1 = indexPath;
        cell.backgroundColor = TABLEVIEWCOLOR;
        cell.clipsToBounds = YES;
        if(cell == nil){
            
            cell = [[PingleiCell alloc]init];
        }
        
        //匹配“品类”button
        [self combineButtonWithCell:cell];
        
        self.moreButton1 = cell.moreButton;
        //往按钮上添加旋转图片
        [self.moreButton1 addSubview:self.xuanzhanImageView1];
        //设置“更多”按钮
        [self configMoreButton:self.moreButton1];
        
        return cell;
    }else if(indexPath.section == 1){
        
        GongYiCell * cell = [tableView dequeueReusableCellWithIdentifier:gongyiCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = TABLEVIEWCOLOR;
        if(cell == nil){
            
            cell = [[GongYiCell alloc]init];
        }
        
        return cell;
    }else if(indexPath.section == 2){
        
        CaizhiCell * cell = [tableView dequeueReusableCellWithIdentifier:caizhiCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = TABLEVIEWCOLOR;
        if(cell == nil){
            
            cell = [[CaizhiCell alloc]init];
        }
        
        return cell;
    }else if(indexPath.section == 3){
        
        WaixingCell * cell = [tableView dequeueReusableCellWithIdentifier:waixingCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.indexPath2 = indexPath;
        cell.clipsToBounds = YES;
        cell.backgroundColor = TABLEVIEWCOLOR;
        if(cell == nil){
            
            cell = [[WaixingCell alloc]init];
        }
        
        self.moreButton2 = cell.moreButton;
        //往“更多”按钮上添加旋转图片
        [cell.moreButton addSubview:self.xuanzhanImageView2];
        //设置“更多”按钮
        [self configMoreButton:cell.moreButton];
        
        return cell;
        
    }else{
        
        KezhongCell * cell = [tableView dequeueReusableCellWithIdentifier:kezhongCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = TABLEVIEWCOLOR;
        if(cell == nil){
            cell = [[KezhongCell alloc]init];
        }
        
        return cell;
    }
}

//匹配“品类”button
-(void)combineButtonWithCell:(PingleiCell *)cell{
    
    self.button1 = cell.button1;
    self.button1.userInteractionEnabled = YES;
    self.button2 = cell.button2;
    self.button3 = cell.button3;
    self.button4 = cell.button4;
    self.button5 = cell.button5;
    self.button6 = cell.button6;
    self.button7 = cell.button7;
    self.button8 = cell.button8;
    self.button9 = cell.button9;
    self.button10 = cell.button10;
    self.button11 = cell.button11;
    self.button12 = cell.button12;
    self.button13 = cell.button13;
    self.button14 = cell.button14;
    self.button15 = cell.button15;
    self.button16 = cell.button16;
    self.button17 = cell.button17;
    self.button18 = cell.button18;
    self.button19 = cell.button19;
    self.button20 = cell.button20;
    self.button21 = cell.button21;
    self.button22 = cell.button22;
    self.button23 = cell.button23;
    self.button24 = cell.button24;
    self.button25 = cell.button25;
    
    //所有的品类按钮执行同一个事件
    [self sendtargetWithButton:cell.button1];
    [self sendtargetWithButton:self.button2];
    [self sendtargetWithButton:self.button3];
    [self sendtargetWithButton:self.button4];
    [self sendtargetWithButton:self.button5];
    [self sendtargetWithButton:self.button6];
    [self sendtargetWithButton:self.button7];
    [self sendtargetWithButton:self.button8];
    [self sendtargetWithButton:self.button9];
    [self sendtargetWithButton:self.button10];
    [self sendtargetWithButton:self.button11];
    [self sendtargetWithButton:self.button12];
    [self sendtargetWithButton:self.button13];
    [self sendtargetWithButton:self.button14];
    [self sendtargetWithButton:self.button15];
    [self sendtargetWithButton:self.button16];
    [self sendtargetWithButton:self.button17];
    [self sendtargetWithButton:self.button18];
    [self sendtargetWithButton:self.button19];
    [self sendtargetWithButton:self.button20];
    [self sendtargetWithButton:self.button21];
    [self sendtargetWithButton:self.button22];
    [self sendtargetWithButton:self.button23];
    [self sendtargetWithButton:self.button24];
    [self sendtargetWithButton:self.button25];
    
    //记录每个button的状态，必须用flag值来记录
    self.pinleiButtonArray = [[NSMutableArray alloc]initWithObjects:self.button1,self.button2,self.button3,self.button4,self.button5,self.button6,self.button7,self.button8,self.button9,self.button10,self.button11,self.button12,self.button13,self.button14,self.button15,self.button16,self.button17,self.button18,self.button19,self.button20,self.button21,self.button22,self.button23,self.button24,self.button25, nil];
    self.pinleiFlagArray = [[NSMutableArray alloc]initWithObjects:@(self.pFlag1),@(self.pFlag2),@(self.pFlag3),@(self.pFlag4),@(self.pFlag5),@(self.pFlag6),@(self.pFlag7),@(self.pFlag8),@(self.pFlag9),@(self.pFlag10),@(self.pFlag11),@(self.pFlag12),@(self.pFlag13),@(self.pFlag14),@(self.pFlag15),@(self.pFlag16),@(self.pFlag17),@(self.pFlag18),@(self.pFlag19),@(self.pFlag20),@(self.pFlag21),@(self.pFlag22),@(self.pFlag23),@(self.pFlag24),@(self.pFlag25), nil];
    //对应匹配数组中的button和其flag值，刷新改组表格后，通过button的flag值，来将选中的button展示完全
    for(int i=0;i<25;i++){
        UIButton * button = self.pinleiButtonArray[i];
        if([self.pinleiFlagArray[i] intValue] == YES){
            
            button.backgroundColor = RGB_COLOR(138, 85, 49, 1);
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
        }
    }
}

//所有的品类按钮执行同一个事件
-(void)sendtargetWithButton:(UIButton *)button{
    
    [button addTarget:self action:@selector(pinleiAction:) forControlEvents:UIControlEventTouchUpInside];
}
//所有的品类按钮执行同一个事件
-(void)pinleiAction:(UIButton *)button{
    
    //分配Button
    switch (button.tag-100) {
        case 0:
            self.pFlag1 = !self.pFlag1;
            [self configButton:button withFlag:self.pFlag1];
            break;
        case 1:
            self.pFlag2 = !self.pFlag2;
            [self configButton:button withFlag:self.pFlag2];
            break;
        case 2:
            self.pFlag3 = !self.pFlag3;
            [self configButton:button withFlag:self.pFlag3];
            break;
        case 3:
            self.pFlag4 = !self.pFlag4;
            [self configButton:button withFlag:self.pFlag4];
            break;
        case 4:
            self.pFlag5 = !self.pFlag5;
            [self configButton:button withFlag:self.pFlag5];
            break;
        case 5:
            self.pFlag6 = !self.pFlag6;
            [self configButton:button withFlag:self.pFlag6];
            break;
        case 6:
            self.pFlag7 = !self.pFlag7;
            [self configButton:button withFlag:self.pFlag7];
            break;
        case 8:
            self.pFlag8 = !self.pFlag8;
            [self configButton:button withFlag:self.pFlag8];
            break;
        case 9:
            self.pFlag9 = !self.pFlag9;
            [self configButton:button withFlag:self.pFlag9];
            break;
        case 10:
            self.pFlag10 = !self.pFlag10;
            [self configButton:button withFlag:self.pFlag10];
            break;
        case 11:
            self.pFlag11 = !self.pFlag11;
            [self configButton:button withFlag:self.pFlag11];
            break;
            
        case 12:
            self.pFlag12 = !self.pFlag12;
            [self configButton:button withFlag:self.pFlag12];
            break;
        case 13:
            self.pFlag13 = !self.pFlag13;
            [self configButton:button withFlag:self.pFlag13];
            break;
        case 14:
            self.pFlag14 = !self.pFlag14;
            [self configButton:button withFlag:self.pFlag14];
            break;
        case 15:
            self.pFlag15 = !self.pFlag15;
            [self configButton:button withFlag:self.pFlag15];
            break;
        case 16:
            self.pFlag16 = !self.pFlag16;
            [self configButton:button withFlag:self.pFlag16];
            break;
        case 17:
            self.pFlag17 = !self.pFlag17;
            [self configButton:button withFlag:self.pFlag17];
            break;
        case 18:
            self.pFlag18 = !self.pFlag18;
            [self configButton:button withFlag:self.pFlag18];
            break;
        case 19:
            self.pFlag19 = !self.pFlag19;
            [self configButton:button withFlag:self.pFlag19];
            break;
        case 20:
            self.pFlag20 = !self.pFlag20;
            [self configButton:button withFlag:self.pFlag20];
            break;
        case 21:
            self.pFlag21 = !self.pFlag21;
            [self configButton:button withFlag:self.pFlag21];
            break;
        case 22:
            self.pFlag22 = !self.pFlag22;
            [self configButton:button withFlag:self.pFlag22];
            break;
        case 23:
            self.pFlag23 = !self.pFlag23;
            [self configButton:button withFlag:self.pFlag23];
            break;
        case 24:
            self.pFlag24 = !self.pFlag24;
            [self configButton:button withFlag:self.pFlag24];
            break;
        case 25:
            self.pFlag25 = !self.pFlag25;
            [self configButton:button withFlag:self.pFlag25];
            break;
        default:
            break;
    }
    
    //点击按钮后，flag的数据要再次进行添加进来，不然就没有当前点击后的状态
        self.pinleiFlagArray = [[NSMutableArray alloc]initWithObjects:@(self.pFlag1),@(self.pFlag2),@(self.pFlag3),@(self.pFlag4),@(self.pFlag5),@(self.pFlag6),@(self.pFlag7),@(self.pFlag8),@(self.pFlag9),@(self.pFlag10),@(self.pFlag11),@(self.pFlag12),@(self.pFlag13),@(self.pFlag14),@(self.pFlag15),@(self.pFlag16),@(self.pFlag17),@(self.pFlag18),@(self.pFlag19),@(self.pFlag20),@(self.pFlag21),@(self.pFlag22),@(self.pFlag23),@(self.pFlag24),@(self.pFlag25), nil];
}

//控制按钮是否是selected状态
-(void)configButton:(UIButton *)button withFlag:(BOOL)flag{
    
    if(flag == YES){
        button.backgroundColor = RGB_COLOR(138, 85, 49, 1);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
    }
}

//设置“更多”按钮
-(void)configMoreButton:(UIButton *)button{
    
    [button addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        if(self.flag1 == NO){
            
            return 80*ScreenMultipleIn6;
        }else{
            return 278*ScreenMultipleIn6;
        }
    }else if(indexPath.section == 1 || indexPath.section ==2){
        
        return 80*ScreenMultipleIn6;
        
    }else if(indexPath.section == 3){
        if(self.flag2 == NO){
            
            return 80*ScreenMultipleIn6;
        }else{
            
            return 160*ScreenMultipleIn6;
            
        }
    }else{
        return 150*ScreenMultipleIn6;
    }
}

//点击更多按钮，进行cell的伸缩
-(void)showMore:(UIButton *)button{
    
    //防止不停添加数据，将上一次的数据要清空
    [self.pinleiSelectedArray removeAllObjects];
    
    if(button == self.moreButton1){
        
        self.flag1 = !self.flag1;
        [self.tableView reloadRowsAtIndexPaths:@[self.indexPath1] withRowAnimation:UITableViewRowAnimationAutomatic];
        if(self.flag1 == NO){
            
            [UIView animateWithDuration:0.5f animations:^{
                self.xuanzhanImageView1.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            }];
            
        }else{
            
            [UIView animateWithDuration:0.5f animations:^{
                self.xuanzhanImageView1.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:^(BOOL finished) {
                
            }];
        }
    }else if (button == self.moreButton2){
        
        self.flag2 = !self.flag2;
        [self.tableView reloadRowsAtIndexPaths:@[self.indexPath2] withRowAnimation:UITableViewRowAnimationAutomatic];
        if(self.flag2 == NO){
            
            [UIView animateWithDuration:0.5f animations:^{
                self.xuanzhanImageView2.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            }];
            
        }else{
            
            [UIView animateWithDuration:0.5f animations:^{
                self.xuanzhanImageView2.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

//组头设置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray * titleArray = @[@"品类",@"工艺",@"材质",@"外形",@"克重"];
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Wscreen, 44*ScreenMultipleIn6)];
    
    UIView * secondBgView = [[UIView alloc]initWithFrame:CGRectMake(10*ScreenMultipleIn6, 0, Wscreen-20*ScreenMultipleIn6, 44*ScreenMultipleIn6)];
    secondBgView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:secondBgView];
    
    //添加两个圈圈
    UIImageView * roundImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(150*ScreenMultipleIn6, 19*ScreenMultipleIn6, 5*ScreenMultipleIn6, 5*ScreenMultipleIn6)];
    roundImageView1.image = [UIImage imageNamed:@"quan"];
    [bgView addSubview:roundImageView1];
    
    self.max_X = CGRectGetMaxX(roundImageView1.frame);
    
    UILabel * titleLabel = [Tools createLabelWithFrame:CGRectMake(self.max_X+10*ScreenMultipleIn6, 15*ScreenMultipleIn6, 30*ScreenMultipleIn6, 14*ScreenMultipleIn6) textContent:titleArray[section] withFont:[UIFont systemFontOfSize:15*ScreenMultipleIn6] textColor:NAVICOLOR textAlignment:NSTextAlignmentCenter];
    [bgView addSubview:titleLabel];
    
    self.max_X = CGRectGetMaxX(titleLabel.frame);
    
    UIImageView * roundImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.max_X+10*ScreenMultipleIn6, 19*ScreenMultipleIn6, 5*ScreenMultipleIn6, 5*ScreenMultipleIn6)];
    roundImageView2.image = [UIImage imageNamed:@"quan"];
    [bgView addSubview:roundImageView2];
    
    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44*ScreenMultipleIn6;
}

//跳转到系列界面，将选中的“品类”中的选项通过数组带过去
-(void)pushForwardSerizeController{
    
    SerizeViewController * serizeViewController = [[SerizeViewController alloc]init];
    
    CATransition * animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:animation forKey:@"123"];
    [self.navigationController pushViewController:serizeViewController animated:NO];
}

//返回首页
-(void)backToFirstViewController{
    
    FirstViewController * firstViewController = [[FirstViewController alloc]init];
    
    CATransition * animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:animation forKey:@"123"];
    [self.navigationController pushViewController:firstViewController animated:NO];
}

//懒加载
-(UIImageView *)xuanzhanImageView1{
    
    if(_xuanzhanImageView1 == nil){
        
        _xuanzhanImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(60*ScreenMultipleIn6, 17.5*ScreenMultipleIn6, 7.5*ScreenMultipleIn6, 5*ScreenMultipleIn6)];
        _xuanzhanImageView1.image = [UIImage imageNamed:@"open"];
    }
    
    return _xuanzhanImageView1;
}

-(UIImageView *)xuanzhanImageView2{
    
    if(_xuanzhanImageView2 == nil){
        
        _xuanzhanImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(60*ScreenMultipleIn6, 17.5*ScreenMultipleIn6, 7.5*ScreenMultipleIn6, 5*ScreenMultipleIn6)];
        _xuanzhanImageView2.image = [UIImage imageNamed:@"open"];
    }
    
    return _xuanzhanImageView2;
}

-(NSMutableArray *)pinleiButtonNameArray{
    
    if(_pinleiButtonNameArray == nil){
        
        _pinleiButtonNameArray = [[NSMutableArray alloc]initWithArray:@[@"项链",@"手镯",@"挂坠",@"戒指",@"手链",@"金条",@"耳环",@"耳坠",@"耳钉",@"摆件",@"套链",@"发簪",@"发钗",@"项圈",@"脚镯",@"脚链",@"皮带",@"金币",@"金章",@"金钞",@"金票",@"金算盘",@"手编",@"金包银",@"金包铜"]];
    }
    
    return _pinleiButtonNameArray;
}

-(NSMutableArray *)pinleiSelectedArray{
    
    if(_pinleiSelectedArray == nil){
        
        _pinleiSelectedArray = [[NSMutableArray alloc]init];
    }
    
    return _pinleiSelectedArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
