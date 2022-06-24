//
//  WYWMacro.h
//  WYWKit
//
//  Created by 王永旺 on 2022/6/24.
//  Copyright © 2022 WYW. All rights reserved.
//

#ifndef WYWMacro_h
#define WYWMacro_h


#ifdef DEBUG
#define WYWLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define WYWLog(...)
#endif

#define WYWISIpad [[UIDevice currentDevice].model isEqualToString:@"iPad"]
#define WYWISIPhone [[UIDevice currentDevice].model isEqualToString:@"iPhone"]
#define WYWScreenWidth [[UIScreen mainScreen] bounds].size.width
#define WYWScreenHeight [[UIScreen mainScreen] bounds].size.height
#define WYWScreenScale [UIScreen mainScreen].scale
#define WYWScaleWidth(w) (WYWISIpad ? w : floor(w / 375.0 * WYWScreenWidth))
#define WYWScaleFontSize(fontSize) (WYWISIpad ? fontSize : (floor(fontSize * [UIScreen mainScreen].bounds.size.width / 375.0 * 10) / 10))

#define WYWSystemVersion [UIDevice currentDevice].systemVersion.doubleValue
#define WYWSystemVersionLowerThan(x) (WYWSystemVersion < (x))

#define WYWStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height < 1.0 ? 20.0 : [UIApplication sharedApplication].statusBarFrame.size.height
#define WYWNavigationBarHeightFull (WYWStatusBarHeight + 44.0)
#define WYWHasHeadCurtain (WYWStatusBarHeight > 20.0)
#define WYWScreenSafeAreaBottom (WYWHasHeadCurtain ? 35.0 : .0)


#endif /* WYWMacro_h */
