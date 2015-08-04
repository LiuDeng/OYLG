//
//  AppDelegate.m
//  OYLG
//
//  Created by 李志强 on 15/7/27.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import "OYLG-Prefix.pch"
#import <AVOSCloud/AVOSCloud.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.window= [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];

    // 设置状态栏的前景色为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    // tabBar颜色
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setBarTintColor:kBackbroundColorAlpha];
    
    RootTabBarViewController * rootVC = [[RootTabBarViewController alloc] init];
    
    self.window.rootViewController = rootVC;
    // Override point for customization after application launch.
    
    
    
#pragma mark LeanCloud
    // 如果使用美国站点，请加上这行代码 [AVOSCloud useAVCloudUS];
    [AVOSCloud setApplicationId:@"5zsgxjmb43v25q7pf6psagmji7xbi6a559n1b9w0a6neezhm"
                      clientKey:@"1sa15p4y8w2qh07r4s8vh67epfczmm4w03rfwpgoazygnxlh"];
    
    // 跟踪 app 打开情况.
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//===============10.1
- (NSUInteger)application:(UIApplication*)application supportedInterfaceOrientationsForWindow:(UIWindow*)window {
    return UIInterfaceOrientationMaskPortrait;
}

@end
