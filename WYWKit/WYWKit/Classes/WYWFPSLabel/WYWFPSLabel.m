//
//  WYWFPSLabel.m
//  WYWKit
//
//  Created by 王永旺 on 2022/6/23.
//  Copyright © 2022 WYW. All rights reserved.
//
/**
 * 参考学习网址：
 * YYKit：https://github.com/ibireme/YYKit
 * YYFPSLabel：https://github.com/yehot/YYFPSLabel
 * iOS查看屏幕帧数工具--YYFPSLabel：https://www.jianshu.com/p/878bfd38666d
 * OCMock 源码学习笔记：https://juejin.cn/post/6844903877540577294
 * 普通手机的帧率为 60 FPS
 * https://developer.apple.com/library/archive/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/Displays/Displays.html
 */

#import "WYWFPSLabel.h"
#import "WYWMacro.h"
#import "WYWWeakProxy.h"

//! 默认大小
#define kDefaultSize (CGSizeMake(50.0, 20.0))
@interface WYWFPSLabel ()

//! 用于记录时间戳的displayLink
@property (nonatomic, strong) CADisplayLink *displayLink;
//! 记录的displayLink触发时，count值
@property (nonatomic, assign) NSInteger count;
//! 上一次 timestamp
@property (nonatomic, assign) CFTimeInterval lastTimestamp;

@end

@implementation WYWFPSLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (CGSizeEqualToSize(frame.size, CGSizeZero)) {
        frame.size = kDefaultSize;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self initCADisplayLink];
        [self setupUI];
    }
    return self;
}

//! 初始化CADisplayLink
- (void)initCADisplayLink {
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:[WYWWeakProxy proxyWithTarget:self] selector:@selector(displayLinkInvoke:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

//! displayLink触发时调用的方法
- (void)displayLinkInvoke:(CADisplayLink *)link {
    
    if (_lastTimestamp < 1) {
        _lastTimestamp = link.timestamp;
        return;
    }
    _count += 1;
    
    if (_count < 5) {
        return;
    }
    
    CFTimeInterval delta = link.timestamp - _lastTimestamp;
    if (delta < 1) {
        return;
    }
    _lastTimestamp = link.timestamp;
    CFTimeInterval fps = _count / delta;
    NSInteger fpsValue = round(fps);
    
    _count = 0;
    self.text = [NSString stringWithFormat:@"%zd FPS", fpsValue];
    WYWLog(@"fps数据：%@", @(fpsValue));
}

//! 重置displayLink
- (void)resetDisplayLink {
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}

//! UI配置
- (void)setupUI {
    
    self.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    self.textColor = [UIColor whiteColor];
    self.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor blackColor];
}

/**
 * Asks the control to calculate and return the size that best fits the specified size.
 * 当调用 sizeToFit 时会调用这个方法，并且返回相应size
 */
- (CGSize)sizeThatFits:(CGSize)size {
    
    return kDefaultSize;
}

- (void)dealloc {
    
    [_displayLink invalidate];
    _displayLink = nil;
    WYWLog(@"%s", __FUNCTION__);
}

@end
