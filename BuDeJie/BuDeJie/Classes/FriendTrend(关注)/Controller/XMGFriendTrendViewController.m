//
//  XMGFriendTrendViewController.m
//  BuDeJie
//
//  Created by 1 on 16/5/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGFriendTrendViewController.h"
#import "UIColor+Hex.h"
@interface XMGFriendTrendViewController ()


@property (nonatomic,weak) UISwitch *s;

@end

@implementation XMGFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = XMGRandomColor;
    
    [self setupNavgationBar];
}

#pragma mark - 设置导航条内容
- (void)setupNavgationBar
{
    // titleView
    self.navigationItem.title = @"我的关注";
    
    // left
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    

}

// 推荐关注
- (void)friendsRecomment
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
