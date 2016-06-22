//
//  SKTabBarItem.h
//  SKTabBar
//
//  Created by nachuan on 16/6/17.
//  Copyright © 2016年 SoKon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKTabBarItem : UIButton

/** 图片占整个item的比例 default 0.7 */
@property (nonatomic, assign) CGFloat ratio;

/** 用于保存系统tabBarItem数据 */
@property (nonatomic, strong) UITabBarItem *item;

/** 默认为nil */
@property (nonatomic, copy) NSString *badgeValue;

/** 按钮的点击事件 */
@property (nonatomic, strong) UITapGestureRecognizer *tap;

/** normal 文字颜色 */
@property (readonly, nonatomic, strong) UIColor *titleColor;

/** selected 文字颜色 */
@property (readonly, nonatomic, strong) UIColor *titleSelectedColor;

/** normal 图片 */
@property (readonly, nonatomic, strong) UIImage *image;

/** selected 图片 */
@property (readonly, nonatomic, strong) UIImage *selectedImage;

/** 动画时长 */
@property (nonatomic, assign) NSInteger duration;

/** 动画重复次数 */
@property (nonatomic, assign) NSInteger repeatCount;

/** 动画图片数组 */
@property (nonatomic, strong) NSArray *images;


@end
