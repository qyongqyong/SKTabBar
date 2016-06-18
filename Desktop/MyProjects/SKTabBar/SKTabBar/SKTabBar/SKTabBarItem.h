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


@end
