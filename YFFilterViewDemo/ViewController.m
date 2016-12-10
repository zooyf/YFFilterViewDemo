//
//  ViewController.m
//  MasonryTestDemo
//
//  Created by 澳达国际 on 16/12/8.
//  Copyright © 2016年 澳达国际. All rights reserved.
//

#import "ViewController.h"
#import "YFFilterView.h"
#import "Masonry.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet YFFilterView *filterView;

@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UIView *thirdView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YFFilterView *view = self.filterView;
    __weak ViewController *blockSelf = self;
    [view setupUIWithTitleArray:@[@"目的地", @"旅行主题", @"旅行天数", @"hhh"].mutableCopy fontAttributes:nil handler:^(UIButton *btn) {
        NSLog(@"%ld", btn.tag);
        [blockSelf changeSelectionView:btn.tag];
        
    }];
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)changeSelectionView:(NSUInteger)index {
    switch (index) {
        case 0: {
            
            if (!self.firstView) {
                self.firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                self.firstView.backgroundColor = [UIColor redColor];
                [self.filterView.bgView addSubview:self.firstView];
            }
            self.firstView.hidden = NO;
            
            [self.filterView itemDidChosenWithTitle:@"哈哈哈" atIndex:0];
            break;
        }
            
        case 1:{
            if (!self.secondView) {
                self.secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
                self.secondView.backgroundColor = [UIColor blueColor];
                [self.filterView.bgView addSubview:self.secondView];;
            }
            
            self.secondView.hidden = NO;
            break;
        }
            
        case 2: {
            if (!self.thirdView) {
                self.thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                self.thirdView.backgroundColor = [UIColor yellowColor];
                [self.filterView.bgView addSubview:self.thirdView];;
            }
            
            self.thirdView.hidden = NO;
            break;
        }
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
