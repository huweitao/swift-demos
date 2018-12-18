//
//  SimpleSwiz.m
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import "SimpleSwiz.h"
#import <objc/runtime.h>

static bool In_SwizzleMethod(Class origClass, SEL origSel, Class newClass, SEL newSel)
{
    Method origMethod = class_getInstanceMethod(origClass, origSel);
    if (!origMethod) {
        NSLog(@"Original method %@ not found for class %@", NSStringFromSelector(origSel), [origClass class]);
        return false;
    }
    
    Method newMethod = class_getInstanceMethod(newClass, newSel);
    if (!newMethod) {
        NSLog( @"New method %@ not found for class %@", NSStringFromSelector(newSel), [newClass class]);
        return false;
    }
    
    if (!class_addMethod(origClass,origSel,class_getMethodImplementation(origClass, origSel),method_getTypeEncoding(origMethod))) {
        NSLog(@"Original method %@ is is not owned by class %@",NSStringFromSelector(origSel), [origClass class]);
        return false;
    }
    
    // 如果不是同一个类，需要添加method
    if (![NSStringFromClass(origClass) isEqualToString:NSStringFromClass(newClass)]) {
        if (!class_addMethod(origClass,newSel,class_getMethodImplementation(newClass, newSel),method_getTypeEncoding(newMethod))) {
            NSLog(@"New method %@ can not be added in class %@",NSStringFromSelector(newSel), [newClass class]);
        }
    }
    
    method_exchangeImplementations(class_getInstanceMethod(origClass, origSel), class_getInstanceMethod(origClass, newSel));
    return true;
}

@implementation SimpleSwiz

+ (BOOL)simpleSwizzleOriginalClass:(Class)aClass originalSel:(SEL)originalSel replaceSel:(SEL)swizzleSel {
    
    return [self simpleSwizzleOriginalClass:aClass originalSel:originalSel replaceClass:aClass replaceSel:swizzleSel];
}

+ (BOOL)simpleSwizzleOriginalClass:(Class)origClass originalSel:(SEL)origSel replaceClass:(Class)newClass replaceSel:(SEL)newSel {
    
    Method origMethod = class_getInstanceMethod(origClass, origSel);
    if (!origMethod) {
        NSLog(@"Original method %@ not found for class %@", NSStringFromSelector(origSel), [origClass class]);
        return NO;
    }
    
    Method newMethod = class_getInstanceMethod(newClass, newSel);
    if (!newMethod) {
        NSLog( @"New method %@ not found for class %@", NSStringFromSelector(newSel), [newClass class]);
        return NO;
    }
    
    if (!class_addMethod(origClass,origSel,class_getMethodImplementation(origClass, origSel),method_getTypeEncoding(origMethod))) {
        NSLog(@"Original method %@ is is not owned by class %@",NSStringFromSelector(origSel), [origClass class]);
        return NO;
    }
    
    // 如果不是同一个类，需要添加method
    if (![NSStringFromClass(origClass) isEqualToString:NSStringFromClass(newClass)]) {
        if (!class_addMethod(origClass,newSel,class_getMethodImplementation(newClass, newSel),method_getTypeEncoding(newMethod))) {
            NSLog(@"New method %@ can not be added in class %@",NSStringFromSelector(newSel), [newClass class]);
        }
    }
    
    method_exchangeImplementations(class_getInstanceMethod(origClass, origSel), class_getInstanceMethod(origClass, newSel));
    
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
