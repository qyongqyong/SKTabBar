//
//  SKTabBarController.m
//  SKTabBar
//
//  Created by nachuan on 16/6/17.
//  Copyright © 2016年 SoKon. All rights reserved.
//

#import "SKTabBarController.h"
#import "SKTabBar.h"
@interface SKTabBarController ()
{
    NSTimer *_timer;
}


@end

@implementation SKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    SKTabBar *tabBar = [[SKTabBar alloc] initWithFrame:self.tabBar.frame];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.isNeedCenterTabBarItem = YES;
    tabBar.titleSelectedColor = [UIColor orangeColor];
    [tabBar setCenterTabBarItemImageName:@"tabbar_compose_icon_add"];
    [tabBar setCenterTabBarItemBackgroundImageName:@"tabbar_compose_button"];
    [self.view addSubview:tabBar];
    
    [self setTabBarController:nil title:@"首页" imageName:@"tabbar_home" tabBar:tabBar tag:0];
    [self setTabBarController:nil title:@"消息" imageName:@"tabbar_message_center" tabBar:tabBar tag:1];
    [self setTabBarController:nil title:@"广场" imageName:@"tabbar_discover" tabBar:tabBar tag:2];
    [self setTabBarController:nil title:@"我的" imageName:@"tabbar_profile" tabBar:tabBar tag:3];
    
    [self addTimer];
}

- (void)addTimer
{
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
}

- (void)timerRun:(NSTimer *)timer
{
    NSInteger num = arc4random_uniform(20);
    NSArray *items = self.tabBar.items;
    UITabBarItem *item = items[0];
    item.badgeValue = [NSString stringWithFormat:@"%ld",(long)num];
}

- (void)setTabBarController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName tabBar:(SKTabBar *)tabBar tag:(NSInteger)tag
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = title;
    vc.tabBarItem.tag = tag;
    [vc.tabBarItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    [tabBar addTabBarItem:vc.tabBarItem];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
