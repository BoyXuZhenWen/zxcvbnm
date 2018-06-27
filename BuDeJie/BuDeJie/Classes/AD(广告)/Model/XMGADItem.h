//
//  XMGADItem.h
//  BuDeJie
//
//  Created by 1 on 16/5/31.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGADItem : NSObject
// w_picurl w h ori_curl

// 广告图片网址
@property (nonatomic, strong) NSString *w_picurl;
// 点击广告跳转的网址
@property (nonatomic, strong) NSString *ori_curl;

@property (nonatomic,assign) CGFloat w;

@property (nonatomic,assign) CGFloat h;

@end
