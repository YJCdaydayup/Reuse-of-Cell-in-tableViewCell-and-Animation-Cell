
//
//  YLAutoLayOut.m
//  适配方案
//
//  Created by 杨力 on 23/4/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "YLAutoLayOut.h"

@implementation YLAutoLayOut

//创建单例
+(instancetype)shareInstance{
    
    static YLAutoLayOut * ylAutoLayOut = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        ylAutoLayOut = [[YLAutoLayOut alloc]init];
    });
    
    return ylAutoLayOut;
}


//适配iPhone5，6，6plus
-(CGFloat)screenMultiple{
    if (APPHEIGHT<=568)//小于iPhone5高度
    {
        return 1.0;
    }
    
    return APPHEIGHT/568;
}
-(CGFloat)screenMultipleIn6Plus{
    if (APPHEIGHT==736.0)//小于iPhone5高度
    {
        return  1.0;
    }
    else if (APPHEIGHT<=568)
    {
        return 568/736.0;
    }
    
    return APPHEIGHT/736.0;
}
-(CGFloat)screenMultipleIn6{
    
    if (APPHEIGHT == 667.0) {
        return 1.0;
    }
    else if (APPHEIGHT <= 568.0)
    {
        
//        NSLog(@"%zi",(float)568/667.0);
        return 568/667.0;
    }
    return APPHEIGHT/667.0;
}
-(CGFloat)screenMultipleLogin{
    
    if (APPHEIGHT == 667.0) {
        return 1.0;
    }
    else if (APPHEIGHT == 568.0)
    {
        return 568/667.0;
    }else if (APPHEIGHT==480){
        return 480/667.0;
    }
    return APPHEIGHT/667.0;
}


@end
