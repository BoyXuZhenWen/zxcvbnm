//
//  AppDelegate.m
//  BuDeJie
//
//  Created by 1 on 16/5/28.
//  Copyright © 2016年 小码哥. All rights reserved.
//

// 封装:谁的事情 谁管理

// UITabBarController有多少个子控制器,就有多少个按钮
// UITabBarController直接切换的导航控制器的view


/*
    产品经理:设计广告界面,一般都是搞个假象,让用户一直以为在启动界面
 程序启动的时候,进入到广告界面 -> 进入主框架界面
 1.在程序启动的时候去做 pass(根本就不能再程序启动的时候做事情)
 2.在程序启动完成的时候去 进入广告界面(展示启动图片) 
    2.1 搞个view去管理广告界面
    2.2 搞个控制器去管理广告界面
 3.直接设置窗口的根控制器为广告控制器
 
 
 */
#import "AppDelegate.h"
#import "XMGTabBarController.h"
#import "XMGADViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



// 程序启动完成的时候去调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 1.创建窗口,强引用
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 2.设置窗口根控制器为广告控制器
    // UITabBarController:会默认把第0个子控制器添加到自己专门存放子控制器view
    // XMGTabBarController *tabBarVc = [[XMGTabBarController alloc] init];
    XMGADViewController *adVc = [[XMGADViewController alloc] init];
    // init -> initWithNibName
    self.window.rootViewController = adVc;
    
    // 3.显示窗口 只要窗口要显示的时候,就会直接把窗口的根控制器view添加上去
    // 1.成为UIApplication主窗口
    // 2.显示窗口 self.window.hidden = NO;
    [self.window makeKeyAndVisible];

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

@end
