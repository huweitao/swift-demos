//
//  Utils.m
//  SwiftOCTest
//
//  Created by huweitao on 2018/9/5.
//  Copyright © 2018年 huweitao. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (instancetype)shared
{
    static dispatch_once_t onceToken ;
    static id instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[Utils alloc] init];
    }) ;
    
    return instance ;
}

+ (void)testLog
{
#if DEBUG
    NSLog(@"Test OC log");
#endif
}


- (void)loopLog
{
    for (NSInteger i = 0; i< 10; i++) {
        NSLog(@"第%ld次log",i);
    }
}


@end
