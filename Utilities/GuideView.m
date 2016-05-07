//
//  GuideView.m
//  杨双15131021
//
//  Created by qf1 on 16/1/3.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "GuideView.h"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
@interface GuideView()<UIScrollViewDelegate>
@property(nonatomic,copy)GoBackBlock  goBackBlock;
@property(nonatomic,assign)NSInteger currentPage;
@end
@implementation GuideView
-(GuideView *)initWithArray:(NSArray *)array andFrame:(CGRect)frame andBlock:(GoBackBlock)block{
    if (self = [super init]) {
        self.frame = frame;
        NSMutableArray * picArray = [NSMutableArray arrayWithArray:array];
        NSString * pic0 = array[0];
        NSString * tailPic = array[array.count-1];
        [picArray insertObject:tailPic atIndex:0];
        [picArray addObject:pic0];
        self.imageArray = [NSMutableArray arrayWithArray:picArray];
        [self configUI];
        self.goBackBlock = block;
    }
    return self;
}
-(void)configUI{
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    NSArray * imagArray = self.imageArray;
    for (int i = 0 ; i < imagArray.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HEIGHT)];
        imageView.image = [UIImage imageNamed:imagArray[i]];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        
        if (i == imagArray.count-2) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
            [btn addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor clearColor];
            [imageView addSubview:btn];
        }
    }
    scrollView.contentSize = CGSizeMake(WIDTH*imagArray.count, HEIGHT);
    scrollView.contentOffset = CGPointMake(WIDTH, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    
    UIPageControl * page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
    page.numberOfPages = imagArray.count-2;
    page.currentPageIndicatorTintColor = [UIColor whiteColor];
    page.pageIndicatorTintColor = [UIColor grayColor];
    _currentPage = 1;
    page.currentPage = _currentPage-1;
    page.tag = 20;
    [self addSubview:page];
}
-(void)go{
    self.goBackBlock();
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (point.x == 0) {
        scrollView.contentOffset = CGPointMake(WIDTH*(self.imageArray.count-1), 0);
    }
    if (point.x == WIDTH*(self.imageArray.count-1)) {
        scrollView.contentOffset = CGPointMake(WIDTH, 0);
    }
    UIPageControl * page = (UIPageControl *)[self viewWithTag:20];
    _currentPage = scrollView.contentOffset.x/WIDTH;
    page.currentPage = _currentPage-1;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
