//
//  XMGSubTagViewController.m
//  BuDeJie
//
//  Created by 1 on 16/6/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSubTagViewController.h"
#import "XMGSubTagCell.h"
static NSString * const ID = @"a";
@interface XMGSubTagViewController ()

@end

@implementation XMGSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条标题,只在非根控制器下使用title
    self.title = @"推荐标签";
    // 注册的cell,xib可以不绑定标识
    [self.tableView registerNib:[UINib nibWithNibName:@"XMGSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    // 以后cell尽量使用注册方式去创建
    XMGLog(@"qwertyuidfghjkcvbnm");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

// 返回cell样式
//  failed to obtain a cell : 返回一个空的cell
// 注意:返回cell的方法不能为空
// 如果cell从xib加载,必须要在xib中描述cell的ID,不描述,不会去做循环利用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    XMGSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
//    if (cell == nil) {
//        cell = [XMGSubTagCell viewForXib];
//    }
    
    NSLog(@"%p",cell);
    cell.backgroundColor = XMGRandomColor;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
