//
//  SimpleSwiz.m
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import "SimpleSwiz.h"
#import <objc/runtime.h>

@implementation SimpleSwiz

+ (BOOL)simpleSwizzleOriginalClass:(Class)aClass originalSel:(SEL)originalSel replaceSel:(SEL)swizzleSel {
    
    Method originalMethod = class_getInstanceMethod(aClass, originalSel);
    Method swizzleMethod = class_getInstanceMethod(aClass, swizzleSel);
    if (!originalSel || !swizzleSel) {
        NSLog(@"Fail to SimpleSwizzle!");
        return NO;
    }
    BOOL didAddMethod = class_addMethod(aClass, originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(aClass, swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
    
    return YES;
}

+ (NSString *)filterSwiftClass:(Class)clazz
{
    NSString *classString = NSStringFromClass(clazz);
    NSArray *elements = [classString componentsSeparatedByString:@"."];
    if (elements.count > 0) {
        classString = elements.lastObject;
    }
    return classString;
}

@end
