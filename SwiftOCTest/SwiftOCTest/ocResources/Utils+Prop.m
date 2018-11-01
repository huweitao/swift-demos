//
//  Utils+Prop.m
//  SwiftOCTest
//
//  Created by huweitao on 2018/9/6.
//  Copyright © 2018年 huweitao. All rights reserved.
//

#import "Utils+Prop.h"
#import <objc/runtime.h>

@implementation Utils (Prop)

- (void)extensionLog
{
    NSLog(@"This is Utils log");
}

// assosiation

- (void)setDesOwner:(NSString *)desOwner
{
    objc_setAssociatedObject(self, @selector(desOwner), desOwner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)desOwner
{
    return objc_getAssociatedObject(self, @selector(desOwner));
}

@end
