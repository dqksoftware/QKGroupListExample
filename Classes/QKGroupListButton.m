//
//  QKGroupListButton.m
//  QKGroupListExample
//
//  Created by 丁乾坤 on 2016/12/8.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKGroupListButton.h"
#import "UIView+QKFrame.h"
@implementation QKGroupListButton

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imageVLeft = 10.f; //图片左边的间距
    CGFloat imageVWidth = 15.f; //图片的宽度
    CGFloat imageVHeight = imageVWidth;
    self.imageView.qk_x = imageVLeft;
    self.imageView.qk_width = imageVWidth;
    self.imageView.qk_height = imageVHeight;
    self.imageView.qk_centerY = self.qk_centerY;
    self.titleLabel.qk_x = self.imageView.qk_right;
    self.titleLabel.qk_centerY = self.qk_centerY;
    
    //    self.groupNaneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    self.groupNaneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
}



//不需要高亮状态
- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
