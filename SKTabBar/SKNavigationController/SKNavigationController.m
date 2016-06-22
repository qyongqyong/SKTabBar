//
//  SKNavigationController.m
//  SKTabBar
//
//  Created by nachuan on 16/6/22.
//  Copyright © 2016年 SoKon. All rights reserved.
//

#import "SKNavigationController.h"

@interface SKNavigationController ()

@end

@implementation SKNavigationController


+ (void)initialize
{
//    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]];
//    [item setTintColor:[UIColor orangeColor]];
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateNormal];
    
    UINavigationBar *navgationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    [navgationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}];
    navgationBar.tintColor = [UIColor cyanColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setImage:[[UIImage imageNamed:@"navigationbar_back_withtext_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        UIBarButtonItem *rightRightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] init];
        rightItem.title = @"hh";
        rightItem.image = [[UIImage imageNamed:@"navigationbar_back_withtext_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.rightBarButtonItems = @[rightItem, rightRightItem];

    }
    [super pushViewController:viewController animated:animated];
}


@end
