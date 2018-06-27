//
//  XMGADViewController.m
//  BuDeJie
//
//  Created by 1 on 16/5/31.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGADViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "XMGADItem.h"
#import <UIImageView+WebCache.h>
#import "XMGTabBarController.h"

// cocoapods:命令行
// 1.创建podfile文件:描述导入哪些第三方框架
// 1.1 pod init:初始化podfile,里面信息都填好
// 1.2 pod search AFN
// 2.pod install: 查看podfile文件

// cocoapods好处:导入某个框架的时候,会自动导入这个框架所依赖框架
// cocoapods:2014的时候才流行
// cocoapods:管理第三方框架导入

// 占位视图:当前界面层次结构已经确定,但是某些子控件的尺寸位置不确定,可以使用占位视图

//  http请求流程
// "Request failed: unacceptable content-type: text/html"

// AFN不支持text/html格式数据
// 服务器返回真实数据是json,AFN能解析,才让AFN支持text/html

// 广告界面业务逻辑
// 1.点击广告图片 展示另外网页 safari打开
// 2.点击跳过,直接进入主框架界面,销毁定时器
// 3.跳过 倒计时

// 开发步骤:

// 请求数据 -> 查看接口文档 -> 验证接口是否正确 -> AFN发送请求 -> 解析数据(直接把数据写成plist)

// -> 解析plist(获取最想要的数据,界面需要什么就获取什么) -> 设计模型 -> 自定义模型

#define XMGCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface XMGADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
@property (nonatomic, strong) XMGADItem *item;
@property (nonatomic,weak) NSTimer *timer;
@end

@implementation XMGADViewController

#pragma mark - 加载控制器的view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 设置启动图片
    [self setupLaunchImage];
    
    // 插入广告图片 -> 活数据 -> 请求数据 -> 查看接口文档 -> AFN -> 导入AFN -> cocoapods
    [self loadADData];
    
    // 定时器
   _timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
}

// 每隔一秒调用一次
- (void)timeChange
{
    static int i = 3;
    
    i--;
    
    // 修改按钮文字
    // 跳过 (1)
    NSString *title = [NSString stringWithFormat:@"跳过 (%d)",i];
    [_jumpButton setTitle:title forState:UIControlStateNormal];
    
    if (i == -1) {
        // 3秒已到,跳转到主框架界面
        [self jump];
    }
}

#pragma mark - 加载广告数据
- (void)loadADData
{
    // 1.创建一个请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = XMGCode2;
    
    // 3.发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        // 请求成功,自动调用
        [responseObject writeToFile:@"/Users/a1/Desktop/课堂共享/05-百思项目/0531/代码/02-广告界面/ad.plist" atomically:YES];

        // 获取广告字典
       NSDictionary *adDict = [responseObject[@"ad"] firstObject];
        // 字典转模型 MJExtension
       XMGADItem *item =  [XMGADItem mj_objectWithKeyValues:adDict];
        _item = item;
        
        // 把广告数据展示到广告界面
        UIImageView *adImageView = [[UIImageView alloc] init];
        [self.containView addSubview:adImageView];
        
        // 设置尺寸
        CGFloat w = XMGScreenW;
        CGFloat h = 0;
        
        // 除以某个数,加个判断,判断这个数是否为0
        if (item.w) {
           h = w / item.w * item.h;
        }
        if (h > XMGScreenH * 0.7) {
            h = XMGScreenH * 0.85;
        }
        adImageView.frame = CGRectMake(0, 0, w, h);
        
        // 设置图片
        [adImageView sd_setImageWithURL:[NSURL URLWithString:item.w_picurl]];
        
        // 添加一个点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        adImageView.userInteractionEnabled = YES;
        [adImageView addGestureRecognizer:tap];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败,自动调用
        NSLog(@"%@",error);
        
    }];
    
}

- (void)tap
{
    NSLog(@"点击了图片");
    // 用safari打开网页
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        
        [[UIApplication sharedApplication] openURL:url];
    }
}
// 点击跳过
- (IBAction)jump {
    // 进入到主框架界面 1.push 2.modal 3.修改窗口根控制器
    XMGTabBarController *tabBarVC = [[XMGTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    
    // 销毁定时器
    [_timer invalidate];
    
}

#pragma mark - 设置启动图片
- (void)setupLaunchImage
{
    // 启动图片拉伸的太难看
    // iPhone6P(736) : LaunchImage-800-Portrait-736h@3x
    // iPhone6(667) : LaunchImage-800-667h@2x
    // iPhone5(568) : LaunchImage-700-568h@2x
    // iPhone4(480) : LaunchImage@2x
    UIImage *image = nil;
    
    if (iPhone6P) { // iPhone6P
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iPhone6) { // iPhone6
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone5) { // iPhone5
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iPhone4) { // iPhone4
        image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    
    _launchImageView.image = image;
}

@end
