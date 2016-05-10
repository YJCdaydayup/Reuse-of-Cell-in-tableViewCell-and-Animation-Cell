
//
//  test.m
//  DianZTC
//
//  Created by 杨力 on 10/5/2016.
//  Copyright © 2016 杨力. All rights reserved.
//

#import "test.h"

@implementation test

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"kid",@"description":@"kDescription"}];
    
}


@end
