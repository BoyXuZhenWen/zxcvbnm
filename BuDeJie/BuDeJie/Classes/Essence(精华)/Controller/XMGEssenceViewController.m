//
//  XMGEssenceViewController.m
//  BuDeJie
//
//  Created by 1 on 16/5/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGEssenceViewController.h"


@interface XMGEssenceViewController ()

@end

@implementation XMGEssenceViewController

/*
 都是模型
 UITabBarItem:决定UITabBar上按钮内容
 UIBarButtonItem:决定UINavgationBar按钮具体内容
 UINavigationItem:决定UINavgationBar内容,左边,右边,中间
 */
// 导航控制器永远显示在最外面的,是栈顶控制器view
// 导航条内容是由栈顶控制器的UINavgationItem决定, -> 谁显示在最外面,谁就能决定导航条内容
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = XMGRandomColor;
    
    // 设置导航条内容
    [self setupNavgationBar];
}

#pragma mark - 设置导航条内容
- (void)setupNavgationBar
{
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // left
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    // right
   self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
}

- (void)game
{
    NSLog(@"点击游戏");
}

@end
