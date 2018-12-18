//
//  UITableView+Statistics.m
//  GCash
//
//  Created by huweitao on 2018/12/18.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import "UITableView+Statistics.h"
#import "SimpleSwiz.h"
#import <objc/runtime.h>
#import "UnSeedManager.h"
#import "UIView+Statistics.h"

@implementation UITableView (Statistics)

+ (void)load
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        BOOL swzFlag = [SimpleSwiz simpleSwizzleOriginalClass:self originalSel:@selector(setDelegate:) replaceSel:@selector(swz_setDelegate:)];
        if (!swzFlag) {
            NSLog(@"Fail to swizzle setDelegate:!");
        }
        
    });
}

- (void)swz_setDelegate:(id<UITableViewDelegate>)delegate
{
    [self swz_setDelegate:delegate];
    
    SEL origSEL = @selector(tableView:didSelectRowAtIndexPath:);
    
    SEL repSELID =  NSSelectorFromString([self swzIdentifierClass:[delegate class] tableview:self]);
    SEL swzSEL = @selector(swz_tableView:didSelectRowAtIndexPath:);
    // optional
    if (![self isContainSel:origSEL inClass:[delegate class]]) {
        return;
    }
    
    BOOL addsuccess = class_addMethod([delegate class],
                                      repSELID,
                                      method_getImplementation(class_getInstanceMethod([self class],swzSEL)),
                                    nil);
    
    //如果添加成功了就直接交换实现， 如果没有添加成功，说明之前已经添加过并交换过实现了
    if (addsuccess) {
        Method selMethod = class_getInstanceMethod([delegate class], origSEL);
        Method sel_Method = class_getInstanceMethod([delegate class], repSELID);
        method_exchangeImplementations(selMethod, sel_Method);
    }
}

// class implemented sel
- (BOOL)isContainSel:(SEL)sel inClass:(Class)class {
    unsigned int count;
    
    Method *methodList = class_copyMethodList(class,&count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *tempMethodString = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        if ([tempMethodString isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - TableView Delegate swizzle

- (void)swz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSString *identifier = [tableView swzIdentifierClass:[self class] tableview:tableView];
    NSLog(@"TableView Select %@ at %ld",identifier,indexPath.row);
    SEL sel = NSSelectorFromString(identifier);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id,id) = (void *)imp;
        func(self, sel,tableView,indexPath);
    }
    [UnSeedManager.sharedManager tableViewSelectByID:identifier tableview:tableView indexPath:indexPath];
}

- (NSString *)swzIdentifierClass:(Class)clazz tableview:(UITableView *)tableView
{
    NSString *sTag = self.statisticsTag;
    if (!sTag) {
        sTag = @"IMP";
    }
    return [NSString stringWithFormat:@"%@_%@_%@", [SimpleSwiz filterSwiftClass:clazz],sTag,NSStringFromClass([tableView class])];
}

@end
