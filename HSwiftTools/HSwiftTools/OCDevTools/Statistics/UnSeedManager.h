//
//  UnSeedManager.h
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PageMonitorHandler)(NSString *,BOOL);
typedef void(^ClickHandler)(NSString *);

@interface UnSeedManager : NSObject

+ (instancetype)sharedManager;

// excute
- (void)startPageMonitorBy:(NSString *)pageKey;
- (void)endPageMonitorBy:(NSString *)pageKey;

- (void)clickTraceBy:(NSString *)clickKey;

// register
- (void)registerPageMonitor:(PageMonitorHandler)handler;
- (void)registerClickTrace:(ClickHandler)handler;

@end

NS_ASSUME_NONNULL_END
