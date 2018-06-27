//
//  main.m
//  BuDeJie
//
//  Created by 1 on 16/5/28.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// main -> UIApplicationMain
// UIApplicationMain
// 1.创建UIApplication对象(1.打电话,发短信,打开网页 2.控制状态栏 3.控制提醒数字 4.设置联网状态)
// 2.创建UIApplication代理对象(1.监听应用程序生命周期 2.处理内存警告)
// 3.开启主运行循环,保证程序一直运行,监听事件
// 4.判断info.plist有没有指定main.storyboard,如果指定,就会去加载,没有指定,就不会去加载

// 加载main.storyboard
// 1.创建窗口
// 2.设置窗口根控制器
// 3.显示窗口

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


// runloop:每一个线程都有runloop,主线程runloop会自动开启,子线程runloop需要手动开启
// runloop:必须要有source或者timer,observer可以有
// runloop使用场景: 常驻线程