//
//  WYWWeakProxy.m
//  WYWKit
//
//  Created by 王永旺 on 2022/6/23.
//  Copyright © 2022 WYW. All rights reserved.
//

#import "WYWWeakProxy.h"

/**
 * 使用NSProxy持有NSTimer的target
 * 不用NSTimer直接持有target，从而避免timer对target引用
 * weak target 解决不了循环引用是因为CADisplayLink内部实现（可参看GNU源码）会再次retain target
 */
@implementation WYWWeakProxy

/**
 创建weak proxy给target
 */
- (instancetype)initWithTarget:(id)target {
    
    _target = target;
    return self;
}

/**
 创建weak proxy给target
 */
+ (instancetype)proxyWithTarget:(id)target {
    
    return [[WYWWeakProxy alloc] initWithTarget:target];
}

#pragma mark - overwrite

// 注意方法拼写不要出现拼写错误，否则第二步的这个寻找备援接受对象无法正常执行，会直接执行到消息转发的第三步，可以查看方法提示或者从NSProxy中复制过来再实现。
// - (id)forwardTargetForSelector:(SEL)selector { // 相当于是一个普通的自定义实例方法
- (id)forwardingTargetForSelector:(SEL)aSelector {

    return _target;
}

/**
 * 如果_target释放了，那么forwardingTargetForSelector的返回值会为nil
 * 比如简单地在 forwardingTargetForSelector中延时把target设置为nil
 * 此时会执行消息转发的methodSignatureForSelector，如果没实现methodSignatureForSelector，则会报错Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[NSProxy methodSignatureForSelector:] called!'
 */
- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel {

    // 返回的NSObject的init方法签名
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    void *null = NULL;
    // Sets the receiver’s return value.
    [invocation setReturnValue:&null];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    
    return [_target respondsToSelector:aSelector];
}

- (NSString *)debugDescription {
    
    return [_target debugDescription];
}

- (NSString *)description {
    
    return [_target description];
}

#pragma mark - NSObject

- (Class)superclass {
    
    return [_target superclass];
}

- (Class)class {
    
    return [_target class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    
    return [_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    
    return [_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    
    return [_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    
    return YES;
}

- (BOOL)isEqual:(id)object {
    
    return [_target isEqual:object];
}

- (NSUInteger)hash {
    
    return [_target hash];
}

@end
