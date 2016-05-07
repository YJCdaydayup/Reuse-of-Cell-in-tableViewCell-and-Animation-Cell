//
//  SingleSearchCatagoryViewController.m
//  DianZTC
//
//  Created by 杨力 on 6/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "SingleSearchCatagoryViewController.h"
#import "CatagoryViewController.h"
#import "SingleCollectionViewCell.h"

//单个分类搜索Cell
#define singleCell @"singleCell"

@interface SingleSearchCatagoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//左导航按钮和导航栏标题
@property (nonatomic,strong) UIButton * navLeftButton;
@property (nonatomic,strong) UILabel * titlelabel;

//表格属性
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * dataArray;

//适配工具
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;
@end

@implementation SingleSearchCatagoryViewController

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
    NSString * titleStr;
    if(self.pinleiArray.count == 0){
        
        titleStr = @"分类搜索列表";
    }else{
        
        titleStr = self.pinleiArray[0];
    }
    
    self.titlelabel = [Tools createLabelWithFrame:CGRectMake(10, 10, 100*ScreenMultipleIn6, 20*ScreenMultipleIn6) textContent:titleStr
                                         withFont:[UIFont systemFontOfSize:17*ScreenMultipleIn6] textColor:RGB_COLOR(255, 255, 255, 1) textAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = self.titlelabel;
    
    //设置表格
    [self configCollectionView];
}

//设置表格
-(void)configCollectionView{
    
    UICollectionViewFlowLayout * flowLayOut = [[UICollectionViewFlowLayout alloc]init];
    [flowLayOut setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Wscreen, Hscreen) collectionViewLayout:flowLayOut];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = RGB_COLOR(237, 237, 237, 1);
    [self.view addSubview:self.collectionView];
    
    //注册Cell
    [self.collectionView registerClass:[SingleCollectionViewCell class] forCellWithReuseIdentifier:singleCell];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

//返回Cell的代理方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:singleCell forIndexPath:indexPath];
    if(cell == nil){
        
        cell = [[SingleCollectionViewCell alloc]init];
    }
    if(self.pinleiArray.count == 0){
        cell.titleLabel.text = @"项链";
    }else{
        cell.titleLabel.text = self.pinleiArray[0];
    }
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://cdn.yyupload.com/down/673731/tpsc/mktmtp_PNG/207.hh-zb-zs/05.png"]];
    
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0,0, 10*ScreenMultipleIn6,0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(IS_IPHONE == IS_IPHONE_5||IS_IPHONE == IS_IPHONE_4_OR_LESS){
     
        return CGSizeMake((20+345+10.5)/2.0*ScreenMultipleIn6, 385/2.0*ScreenMultipleIn6);
    }else{
        
        return CGSizeMake((20+345+10)/2.0*ScreenMultipleIn6, 385/2.0*ScreenMultipleIn6);
    }
    
    
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
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
