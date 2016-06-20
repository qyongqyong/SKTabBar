//
//  SKBadgeItem.m
//  SKTabBar
//
//  Created by nachuan on 16/6/17.
//  Copyright © 2016年 SoKon. All rights reserved.
//

#import "SKBadgeItem.h"

@implementation SKBadgeItem

- (instancetype)init
{
    if (self = [super init]) {
        self.titleLabel.font = [UIFont systemFontOfSize:9];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[[UIImage imageNamed:@"main_badge"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 9, 0, 9) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    }
    return self;
}



@end
