//
//  XMGSubTagCell.m
//  BuDeJie
//
//  Created by 1 on 16/6/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSubTagCell.h"

@implementation XMGSubTagCell

+ (instancetype)viewForXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
