//
//  XMGNavigationController.m
//  BuDeJie
//
//  Created by 1 on 16/5/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGNavigationController.h"

@interface XMGNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation XMGNavigationController

// 1.解决bug 2.找出原因(就看下做了哪些操作,或者添加了哪些代码)

/*
 // iOS7之后,导航控制器自带滑动返回功能
 // 只要把系统返回按钮 覆盖 , 就没有滑动返回功能
 // 需求:既要覆盖返回按钮 又要 有滑动返回功能 1.直接去写一个滑动返回功能 2.分析为什么滑动返回功能木有
 // 1.滑动返回功能 用 手势去实现
 // 2.手势失效了,滑动返回功能就木有
 // 2.1 手势失效 enable
 // 2.2 通过代理去控制

 
 // bug:假死状态:界面死了,程序还在运行
 // 在根控制器滑动返回,就导致出现了假死bug.
 // 在根控制器的时候,设置手势失效,1.self.interactivePopGestureRecognizer.enabled = NO
 // 判断下什么时候进入根控制器
 // 2.通过代理设置手势失效
 
 */


/*
    全屏滑动功能:
    1.系统滑动返回功能,只能在最左边才能滑动
    2.为什么系统滑动返回功能,只能在最左边才能滑动
    3.UIScreenEdgePanGestureRecognizer:只能用于屏幕边缘
    4.只能用Pan
 */
/*
 <UIScreenEdgePanGestureRecognizer: 0x7fd27bd70230; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fd27bf50ff0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fd27bd6fc80>)>>
    UIScreenEdgePanGestureRecognizer的target的action 就是滑动返回功能
 */
// <_UINavigationInteractiveTransition: 0x7fd033427ad0>:滑动手势代理

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 全屏滑动返回功能
    // pan:滑动返回功能
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    // 干掉边缘滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // 验证这个手势是滑动手势
    // 清空滑动手势代理,就恢复了滑动手势功能
    // 目的:控制手势什么时候有用
    pan.delegate = self;
    
}

+ (void)load
{
    // appearance:在开发中,尽量不要使用appearance
    
    // 需求:设置导航条标题字体 -> 导航条决定
    // 获取整个应用程序下所有导航条外观
    // appearanceWhenContainedIn:获取哪个类下面的导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    navBar.titleTextAttributes = attr;
    
    // 设置导航条背景图片:一定要添加UIBarMetricsDefault
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    // 遇见最恶心bug,iOS7 , 发短信功能,联系人黑屏
}

#pragma mark - UIGestureRecognizerDelegate
// 控制手势是否有效
// 每次触发手势就会判断,是否允许接收这个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 判断下当前是不是在根控制器
    return self.childViewControllers.count > 1;
}


// viewController:下一个栈顶控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 只有非根控制器的时候 才需要设置返回按钮
    // 判断下当前控制器是不是根控制器
    if (self.childViewControllers.count > 0) { // 非根控制器
        // 设置导航条左边按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条上按钮位置
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0 );
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        // 覆盖掉系统滑动返回按钮 -> 滑动手势就实现 -> 手势可以用
        viewController.navigationItem.leftBarButtonItem = item;
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 真正跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
