//
//  WYWWeakProxy.h
//  WYWKit
//
//  Created by 王永旺 on 2022/6/23.
//  Copyright © 2022 WYW. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYWWeakProxy : NSProxy

//! proxy target
@property (nonatomic, weak, readonly) id target;

/**
 创建weak proxy给target
 */
- (instancetype)initWithTarget:(id)target;

/**
 创建weak proxy给target
 */
+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
