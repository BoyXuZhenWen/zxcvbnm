//
//  XMGNewViewController.m
//  BuDeJie
//
//  Created by 1 on 16/5/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGNewViewController.h"
#import "UIColor+Hex.h"
#import "XMGSubTagViewController.h"
@interface XMGNewViewController ()

@end

@implementation XMGNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = XMGRandomColor;
    
    // 设置导航条
    [self setupNavgationBar];
}

#pragma mark - 设置导航条内容
- (void)setupNavgationBar
{
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // left
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(subTag)];
    
  
}

#pragma mark - 点击标题就会调用
- (void)subTag
{
    NSLog(@"点击了标签");
    XMGSubTagViewController *tagVc = [[XMGSubTagViewController alloc] init];

    // 跳转到推荐标签界面
    [self.navigationController pushViewController:tagVc animated:YES];
}


@end
