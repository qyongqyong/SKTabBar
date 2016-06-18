//
//  SKTabBar.m
//  SKTabBar
//
//  Created by nachuan on 16/6/17.
//  Copyright © 2016年 SoKon. All rights reserved.
//

#import "SKTabBar.h"
#import "SKTabBarItem.h"
#import "SKBadgeItem.h"
@interface SKTabBar ()

/** tabBar中间按钮 */
@property (nonatomic, strong) UIButton *centerBtn;

@end


@implementation SKTabBar
@synthesize titleColor = _titleColor;
@synthesize titleSelectedColor = _titleSelectedColor;

- (void)setIsNeedCenterTabBarItem:(BOOL)isNeedCenterTabBarItem
{
    _isNeedCenterTabBarItem = isNeedCenterTabBarItem;
    if (isNeedCenterTabBarItem == YES) {
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.tag = 10000;
        [_centerBtn addTarget:self action:@selector(centerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_centerBtn];
    }
}

- (void)setCenterTabBarItemImageName:(NSString *)imageName
{
    [_centerBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_centerBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateSelected];
}

- (void)setCenterTabBarItemBackgroundImageName:(NSString *)backgroundImageName
{
    [_centerBtn setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    [_centerBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",backgroundImageName]] forState:UIControlStateSelected];
}

- (void)setCenterTabBarItemImageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName
{
    [self setCenterTabBarItemImageName:imageName];
    [self setCenterTabBarItemBackgroundImageName:backgroundImageName];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (self.isNeedCenterTabBarItem) {
        [_centerBtn removeFromSuperview];   //移除中心按钮
        NSArray *items = self.subviews;
        [self insertSubview:_centerBtn belowSubview:items[items.count / 2]];    //添加中心按钮在中间位置
        items = self.subviews;
        CGFloat width = self.frame.size.width / items.count;
        for (int i=0; i<items.count; i++) {                                 //此处数组一般不会有其他的View.确保不会出错.做了类型判断
            UIView *view = items[i];
            if ([view isKindOfClass:[SKTabBarItem class]]) {
                SKTabBarItem *item = (SKTabBarItem *)view;
                item.frame = CGRectMake(i * width, 0, width, self.frame.size.height);
            }else if (view == _centerBtn) {
                _centerBtn.frame = CGRectMake(i * width, 0, width, self.frame.size.height);
            }
        }
    }else{
        NSArray *items = self.subviews;
        CGFloat width = self.frame.size.width / items.count;
        for (int i=0; i<items.count; i++) {
            UIView *view = items[i];
            if ([view isKindOfClass:[SKTabBarItem class]]) {
                SKTabBarItem *item = (SKTabBarItem *)view;
                item.frame = CGRectMake(i * width, 0, width, self.frame.size.height);
            }
        }
    }
}

- (void)addTabBarItem:(UITabBarItem *)item
{
    SKTabBarItem *tabBarItem = [[SKTabBarItem alloc] init];
    tabBarItem.item = item;
    tabBarItem.tag = item.tag;
    [tabBarItem setTitleColor:self.titleColor forState:UIControlStateNormal];
    [tabBarItem setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
    [tabBarItem setTitle:item.title forState:UIControlStateNormal];
    [tabBarItem setImage:item.image forState:UIControlStateNormal];
    [tabBarItem setImage:item.selectedImage forState:UIControlStateSelected];
    [tabBarItem addTarget:self action:@selector(tabBarItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tabBarItem];
}

- (void)addAnimationTabBarItem:(UITabBarItem *)item withAnimationImages:(NSArray *)images animationDuration:(NSInteger)duration
{
    
}

/** tabBarItem点击事件 */
- (void)tabBarItemClicked:(SKTabBarItem *)item
{
    NSLog(@"%d",item.selected);
    NSLog(@"from: %ld to: %ld",(long)self.selectedItem.tag, (long)item.tag);
    if (item.selected == NO) {
        item.selected = YES;
        self.selectedItem.selected = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(sk_tabBar:didSelectedTabBarItemFrom:to:)]) {
            [self.delegate sk_tabBar:self didSelectedTabBarItemFrom:self.selectedItem.tag to:item.tag];
        }
        self.selectedItem = item;
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(sk_tabBar:didSelectedTabBarItem:)]) {
            [self.delegate sk_tabBar:self didSelectedTabBarItem:item];
        }
    }
    
}

/** 中心按钮点击事件 */
- (void)centerBtnClicked:(UIButton *)sender
{
    NSLog(@"%ld",(long)sender.tag);
}



#pragma mark - 重写 setter getter 方法

- (UIColor *)titleColor
{
    if (_titleColor == nil) {
        _titleColor = [UIColor grayColor];
    }
    return _titleColor;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[SKTabBarItem class]]) {
            SKTabBarItem *item = (SKTabBarItem *)view;
            [item setTitleColor:titleColor forState:UIControlStateNormal];
        }
    }
}

- (UIColor *)titleSelectedColor
{
    if (_titleSelectedColor == nil) {
        _titleSelectedColor = [UIColor blueColor];
    }
    return _titleSelectedColor;
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor
{
    _titleSelectedColor = titleSelectedColor;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[SKTabBarItem class]]) {
            SKTabBarItem *item = (SKTabBarItem *)view;
            [item setTitleColor:titleSelectedColor forState:UIControlStateSelected];
        }
    }
}



@end
