//
//  HomeViewController.m
//  SKTabBar
//
//  Created by nachuan on 16/6/22.
//  Copyright © 2016年 SoKon. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(100, 100, 50, 50);
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(pushNextViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)pushNextViewController:(UIButton *)sender
{
    HomeViewController *vc = [[HomeViewController alloc] init];
    vc.title = @"NEXT";
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
