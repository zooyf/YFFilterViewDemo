//
//  TMFilterView.h
//  MasonryTestDemo
//
//  Created by 澳达国际 on 16/12/8.
//  Copyright © 2016年 澳达国际. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFFilterView : UIView

/**
 背景图,点击视图消失
 */
@property (nonatomic, strong) UIView *bgView;

/**
 设置图片,需在setupUI前调用

 @param nImg 未选中的图片
 @param hImg 已选中的图片
 */
- (void)setNormalImage:(UIImage *)nImg selectedImage:(UIImage *)hImg;

/**
 设置UI,必须实现的函数
 */
- (void)setupUIWithTitleArray:(NSMutableArray *)array fontAttributes:(NSDictionary *)attributes handler:(void(^)(UIButton * btn))handler;


/**
 选择内容后改变button标题

 @param title 标题
 @param index 位置
 */
- (void)itemDidChosenWithTitle:(NSString *)title atIndex:(NSUInteger)index;

@end
