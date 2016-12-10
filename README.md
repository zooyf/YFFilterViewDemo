# YFFilterView -- iOS筛选控件

* 使用Masonry布局，动态添加按钮数量，实现效果如图所示

* Using Masonry layout. Dynamicly adding buttons. 

 ![](http://og40kagxh.bkt.clouddn.com/public/16-12-10/71797611.jpg)

## Using -- 使用   

### Create -- 创建    
通过正常的创建视图的方法创建即可`` YFFilterView *filterView = [[YFFilterView alloc] initWithFrame:frame] ``   

Create by the normal way. `` YFFilterView *filterView = [[YFFilterView alloc] initWithFrame:frame] ``   

### Initialize -- 初始化   

按钮根据传入的titleArray动态创建，在``setupUIWithTitleArray``方法执行后，视图元素才会被加载。   

The button was created with titleArray. The view element was loaded after ``setupUIWithTitleArray`` method get called.    

根据``block``中的``btn.tag``来判断第几个按钮被点击，从而进行相应的逻辑处理。   

Get the selected index by ``btn.tag`` in the ``block``. Implement the rest logic by yourself.

```
    [filterView setupUIWithTitleArray:@[@"目的地", @"旅行主题", @"旅行天数", @"hhh"].mutableCopy fontAttributes:nil handler:^(UIButton *btn) {
        NSLog(@"%ld", btn.tag);
        [self changeSelectionView:btn.tag];
        
    }];

```
   
由于按钮点击后的视图按需而变，故这里的逻辑留给coder自己处理。

### Selection logic -- 选中逻辑处理

一般地，在选中筛选条件后，按钮标题会变为选中项。``itemDidChosenWithTitle:atIndex:``方法实现该逻辑，``index``为按钮的位置。   

Generally, after selecting the condition. The title of that button would be changed to the selection item. ``itemDidChosenWithTitle:atIndex:`` this method implemented this logic & ``index`` was the button's index.

```
    [self.filterView itemDidChosenWithTitle:@"哈哈哈" atIndex:0];

```

### Switching selection view -- 选中视图切换   

使用视图隐藏的方式切换视图，视图的隐藏在YFFilterView中已封装，使用者只需在block中实现特定视图的显示即可。   

Switching the view by ``hidden`` property.

```
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

```

## Looking forwatd -- 期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的框架代码看看BUG修复没有）
* Issue me if you find bug
* 如果你想为YFFilterView输出代码，请拼命Pull Requests我
* Pull Requests ME Desperately!
