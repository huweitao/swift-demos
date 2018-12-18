//
//  SimpleSwiz.h
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SimpleSwiz : NSObject

// swizzle same class
+ (BOOL)simpleSwizzleOriginalClass:(Class)aClass originalSel:(SEL)originalSel replaceSel:(SEL)swizzleSel;

// swizzle different classes
+ (BOOL)simpleSwizzleOriginalClass:(Class)origClass originalSel:(SEL)origSel replaceClass:(Class)newClass replaceSel:(SEL)newSel;

// filter swift class string contains '.'
+ (NSString *)filterSwiftClass:(Class)clazz;

@end

NS_ASSUME_NONNULL_END
