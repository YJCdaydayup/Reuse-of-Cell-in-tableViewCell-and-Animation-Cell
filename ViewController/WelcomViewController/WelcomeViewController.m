//
//  WelcomeViewController.m
//  DianZTC
//
//  Created by 杨力 on 4/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "WelcomeViewController.h"
#import "XXYNavigationController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //判断是否是第一次登陆，是就展示用户的引导图，不是就进入主界面
    if ([self isFisrtStarApp] == YES) {
        //第一次启动
        [self showGuide];
    }else{
        [self goFoward];
    }
}
#pragma mark  展示引导图
-(void)showGuide{
    
    NSArray *imageArray = @[@"ms_ui_lanuch1",@"ms_ui_lanuch2",@"ms_ui_lanuch3",@"ms_ui_lanuch4"];
    
    //参数一：图片名字的数组
    //参数二：frame
    //参数三：回调的block
    GuideView *adView = [[GuideView alloc]initWithArray:imageArray andFrame:CGRectMake(0, 0, self.view.frame.size.width, Hscreen) andBlock:^{
        [self goFoward];
    }];
    [self.view addSubview:adView];
}
//判断是否第一次启动程序
-(BOOL)isFisrtStarApp{
    //获得单例
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //读取次数（用户上一次启动app的次数）
    NSString *number = [userDefaults objectForKey:@"AppFirstLoadKey"];
    //判断是否有值
    if (number!=nil) {
        //能够取到值，则不是第一次启动
        NSInteger starNumer = [number integerValue];
        //用上一次的次数+1次
        NSString *str = [NSString stringWithFormat:@"%zi",++starNumer];
        //存的是用户这一次启动的次数
        [userDefaults setObject:str forKey:@"AppFirstLoadKey"];
        [userDefaults synchronize];
        return NO;
    }else{
        //不能取到值，则是第一次启动
        NSLog(@"用户是第一次启动");
        [userDefaults setObject:@"1" forKey:@"AppFirstLoadKey"];
        [userDefaults synchronize];
        return YES;
    }
}
#pragma mark  进入主界面
-(void)goFoward{
    
    FirstViewController * firstVc = [[FirstViewController alloc]init];
    XXYNavigationController * nFirstVc = [[XXYNavigationController alloc]initWithRootViewController:firstVc];
    
    //更改window的根视图控制器
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = nFirstVc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
