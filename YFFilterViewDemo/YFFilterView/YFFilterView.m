//
//  TMFilterView.m
//  MasonryTestDemo
//
//  Created by 澳达国际 on 16/12/8.
//  Copyright © 2016年 澳达国际. All rights reserved.
//

#import "YFFilterView.h"
#import "Masonry.h"

@interface YFFilterView ()

/**
 标题数组
 */
@property (nonatomic, strong) NSMutableArray *titleArray;

/**
 按钮未选中的图片
 */
@property (nonatomic, strong) UIImage *normalImg;
/**
 按钮选中后的图片
 */
@property (nonatomic, strong) UIImage *selectedImg;

/**
 字体属性字典
 */
@property (nonatomic, strong) NSDictionary *fontAttributes;

/**
 点击按钮调用的block
 */
@property (nonatomic, copy) void(^selectionHandler)(UIButton * btn);

@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) NSMutableArray *lineArray;

@end

@implementation YFFilterView
- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (UIImage *)selectedImg {
    if (!_selectedImg) {
        _selectedImg = [UIImage imageNamed:@"btn_xiajiantou_h"];
    }
    return _selectedImg;
}

- (UIImage *)normalImg {
    if (!_normalImg) {
        _normalImg  = [UIImage imageNamed:@"btn_xiajiantou_n"];
    }
    return _normalImg;
}

- (NSDictionary *)fontAttributes {
    if (!_fontAttributes) {
        _fontAttributes = @{
                            NSFontAttributeName: [UIFont systemFontOfSize:15],
                            NSForegroundColorAttributeName: [UIColor blackColor]
                            };
    }
    return _fontAttributes;
}

- (void)setNormalImage:(UIImage *)nImg selectedImage:(UIImage *)hImg {
    self.normalImg = nImg;
    self.selectedImg = hImg;
}

- (void)setupUIWithTitleArray:(NSMutableArray *)array fontAttributes:(NSDictionary *)attributes handler:(void (^)(UIButton *))handler {
    self.selectionHandler = handler;
    
    self.titleArray = array;
    self.fontAttributes = attributes;
    
    for (int i = 0; i < self.titleArray.count; i++) {
        
        UIButton *itemButton = [UIButton new];
        itemButton.tag = i;
        [itemButton addTarget:self action:@selector(filterItemDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemButton];
        [self.btnArray addObject:itemButton];
        
        id normalStr = [self buttonTitleWithText:self.titleArray[i] image:self.normalImg];
        [itemButton setAttributedTitle:normalStr forState:UIControlStateNormal];
        
        id hStr = [self buttonTitleWithText:self.titleArray[i] image:self.selectedImg];
        [itemButton setAttributedTitle:hStr forState:UIControlStateSelected];
        
        if (i == 0) {
            // 第一个
            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                
            }];
        } else {
            
            UIView *line = [UIView new];
            [line setBackgroundColor:[UIColor blackColor]];
            [self addSubview:line];
            [self.lineArray addObject:line];
            
            UIButton *lastBtn = self.btnArray[i-1];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(1);
                make.height.mas_equalTo(self.frame.size.height/2.0);
                make.left.mas_equalTo(lastBtn.mas_right);
                make.centerY.mas_equalTo(lastBtn.mas_centerY);
            }];
            
            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(line.mas_right);
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(lastBtn);
                
            }];
            
            if (i == self.titleArray.count -1) {
                // 最后一个
                [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(0);
                }];
                
            }
        }
        
    }

    [self prepareBackgroundView];
}

- (void)prepareBackgroundView {
    
    {
        // 边框
        CALayer *bottomBorder = [CALayer layer];
        
        bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height-1, self.frame.size.width, 1.0f);
        
        bottomBorder.backgroundColor = [UIColor blackColor].CGColor;
        
        [self.layer addSublayer:bottomBorder];
        
        CALayer *topBorder = [CALayer layer];
        
        topBorder.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 1.0f);
        
        topBorder.backgroundColor = [UIColor blackColor].CGColor;
        
        [self.layer addSublayer:topBorder];
    }
    
    // 背景视图
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    bgView.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBgView)];
    [bgView addGestureRecognizer:tap];
    self.bgView = bgView;
    
    UIView *superview = self.superview;
    [superview addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(superview.mas_left);
        make.right.mas_equalTo(superview.mas_right);
        make.bottom.mas_equalTo(superview.mas_bottom);
    }];
    
}

- (void)filterItemDidSelected:(UIButton *)sender {
    
    if (![sender isKindOfClass:[UIButton class]]) {
        return;
    }
    self.bgView.hidden = sender.selected;
    
    // 隐藏子视图
    for (UIView *view in self.bgView.subviews) {
        view.hidden = YES;
    }
    
    if (!sender.selected) {
        // 未选中状态调用block
        self.selectionHandler(sender);
    }
    // 改变选中状态
    sender.selected = !sender.selected;
    for (UIButton *btn in self.btnArray) {
        if (btn != sender) {
            btn.selected = NO;
        }
    }
    
    NSLog(@"filter view item did selected at index:%ld", [sender tag]);
    
}

- (void)itemDidChosenWithTitle:(NSString *)title atIndex:(NSUInteger)index {
    UIButton *btn = self.btnArray[index];
    
    [self.titleArray replaceObjectAtIndex:index withObject:title];
    
    [btn setSelected:NO];
    [btn setAttributedTitle:[self buttonTitleWithText:title image:self.normalImg] forState:UIControlStateNormal];
    [btn setAttributedTitle:[self buttonTitleWithText:title image:self.selectedImg] forState:UIControlStateSelected];
    
}


#pragma mark --------------------- custom method ---------------------

- (void)dismissBgView {
    self.bgView.hidden = YES;
    for (UIButton *btn in self.btnArray) {
        btn.selected = NO;
    }
}

- (NSMutableAttributedString *)buttonTitleWithText:(NSString *)text image:(UIImage *)image {
    
    // attribute text
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = image;
    attach.bounds = CGRectMake(0, -5, 15, 20);
    NSAttributedString *attachStr = [NSAttributedString attributedStringWithAttachment:attach];
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:text attributes:self.fontAttributes];
    [attrText appendAttributedString:attachStr];
    
    return attrText;
}

@end
