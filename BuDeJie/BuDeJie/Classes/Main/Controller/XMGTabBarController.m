//
//  XMGTabBarController.m
//  BuDeJie
//
//  Created by 1 on 16/5/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGEssenceViewController.h"
#import "XMGNewViewController.h"
#import "XMGPublishViewController.h"
#import "XMGFriendTrendViewController.h"
#import "XMGMeViewController.h"
#import "XMGNavigationController.h"

/*
 为什么经常抽分类: 1.复用
 
 */

/*
 问题
 
 1.选中按钮的图片被渲染 1.修改图片 2.通过代码
 2.选中按钮文字被渲染
 3.中间的view显示不出来
    为什么显示不出来,因为发布按钮图片尺寸太大
    1.不能直接修改美工提供图片
    2.有可能把正常状态下图片渲染成灰色
    2.1 不要渲染
    2.2 修改中间view位置
    2.3 系统tabBar上按钮,只有选中状态,没有长按状态
 
 */

/*
    按钮状态:
    正常
    长按:只要手指离开,就恢复正常,就是长按状态
    选中:手指离开按钮,状态还在,就是选中
 
 */

@interface XMGTabBarController ()

@end

@implementation XMGTabBarController
// 加载类进内存就会调用 只会调用一次
+ (void)load
{

    // 1. 只要遵守UIAppearance,就能调用
    // 2.只要带有UI_APPEARANCE_SELECTOR宏属性,都可以通过UIAppearance设置
    // 3.注意点:通过UIAppearance设置属性,必须要在显示之前去设置
    
    // 获取全局UITabBarItem外观
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];

    // 设置文字颜色 选中状态
    // 通过设置富文本属性(文字颜色,阴影,下划线,字体,图文混排)
    // 创建字典描述文本属性
    // 设置选中状态下颜色
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    
    // 设置正常状态下字体
    NSMutableDictionary *attrNor = [NSMutableDictionary dictionary];
    attrNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrNor forState:UIControlStateNormal];
    
    // item.title = @"123";
    
    // bug:设置字体无效 -> 选中状态设置字体导致无效
    // 总结: 设置tabBar上按钮字体 只能通过正常状态 才能设置
}

// 需求:设置tabBar上按钮的文字颜色 -> 找到对应子控制器的tabBarItem有没有属性设置文字颜色

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.添加所有的子控制器
    [self setupAllViewController];
    
    // 2.设置tabBar上按钮的内容
    [self setupAllTabBarButton];
    
    // 3.添加中间发布按钮
    [self setupPlusButton];
    
}

// 技巧:研究一个方法在干什么事情,把方法注释掉,如果某个功能,木有,就是这个方法干的

// UITabBar在viewWillAppear时候 把 按钮 添加到UITabBar
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}

#pragma mark - 添加中间发布按钮
- (void)setupPlusButton
{
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    // 自适应,自动根据按钮图片和文字计算按钮尺寸
    [plusButton sizeToFit];

    plusButton.center = CGPointMake(self.tabBar.xmg_width * 0.5, self.tabBar.xmg_height * 0.5);
    [plusButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:plusButton];
}

#pragma mark - 点击了发布按钮
- (void)clickButton
{
    NSLog(@"点击了发布按钮");
}
// 需求: 修改插件,让自己方法有图片提示功能
//  获取插件路径 -> 插件代码 -> 点击放大镜 -> 搜索 install

// 插件 按照到 MAC上
#pragma mark - 设置tabBar上按钮的内容
- (void)setupAllTabBarButton
{
    // 理论:TabBar上按钮内容 由 对应的子控制器的tabBarItem决定
    UIViewController *childVc0 = self.childViewControllers[0];
    childVc0.tabBarItem.title = @"精华";
    childVc0.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    childVc0.tabBarItem.selectedImage = [UIImage imageWithOriginalRenderingMode:@"tabBar_essence_click_icon"];

    
    UIViewController *childVc1 = self.childViewControllers[1];
    childVc1.tabBarItem.title = @"新帖";
    childVc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    childVc1.tabBarItem.selectedImage = [UIImage imageWithOriginalRenderingMode:@"tabBar_new_click_icon"];
    
    UIViewController *childVc2 = self.childViewControllers[2];
    childVc2.tabBarItem.enabled = NO;
//    childVc2.tabBarItem.image = [UIImage imageWithOriginalRenderingMode:@"tabBar_publish_icon"];
//    childVc2.tabBarItem.selectedImage = [UIImage imageWithOriginalRenderingMode:@"tabBar_publish_click_icon"];
//    // 设置发布按钮图片位置
//    childVc2.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    UIViewController *childVc3 = self.childViewControllers[3];
    childVc3.tabBarItem.title = @"关注";
    childVc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    childVc3.tabBarItem.selectedImage = [UIImage imageWithOriginalRenderingMode:@"tabBar_friendTrends_click_icon"];
    
    UIViewController *childVc4 = self.childViewControllers[4];
    childVc4.tabBarItem.title = @"我";
    childVc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    childVc4.tabBarItem.selectedImage = [UIImage imageWithOriginalRenderingMode:@"tabBar_me_click_icon"];
    
}

#pragma mark - 添加所有的子控制
- (void)setupAllViewController
{
    // 添加子控制器
    // 精华
    XMGEssenceViewController *vc = [[XMGEssenceViewController alloc] init];
    // initWithRootViewController:把VC调用push,vc压入栈,导航控制器默认会添加栈顶控制器view
    XMGNavigationController *nav = [[XMGNavigationController alloc] initWithRootViewController:vc];

    [self addChildViewController:nav];
    
    // 新帖
    XMGNewViewController *vc1 = [[XMGNewViewController alloc] init];
    // initWithRootViewController:把VC调用push,vc压入栈,导航控制器默认会添加栈顶控制器view
    XMGNavigationController *nav1 = [[XMGNavigationController alloc] initWithRootViewController:vc1];
    [self addChildViewController:nav1];
    
    // 发布
    XMGPublishViewController *vc2 = [[XMGPublishViewController alloc] init];
    // initWithRootViewController:把VC调用push,vc压入栈,导航控制器默认会添加栈顶控制器view
    [self addChildViewController:vc2];
    
    // 关注
    XMGFriendTrendViewController *vc3 = [[XMGFriendTrendViewController alloc] init];
    // initWithRootViewController:把VC调用push,vc压入栈,导航控制器默认会添加栈顶控制器view
    XMGNavigationController *nav3 = [[XMGNavigationController alloc] initWithRootViewController:vc3];
    [self addChildViewController:nav3];
    
    // 我
    XMGMeViewController *me = [[XMGMeViewController alloc] init];
    // initWithRootViewController:把VC调用push,vc压入栈,导航控制器默认会添加栈顶控制器view
    XMGNavigationController *nav4 = [[XMGNavigationController alloc] initWithRootViewController:me];
    [self addChildViewController:nav4];
}

@end
