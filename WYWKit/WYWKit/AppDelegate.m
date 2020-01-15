//
//  AppDelegate.m
//  WYWKit
//
//  Created by wangyongwang on 2019/12/28.
//  Copyright © 2019 WYW. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (@available(iOS 13.0, *)) {
        
    } else {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}

@end
