//
//  SKTabBarItem.m
//  SKTabBar
//
//  Created by nachuan on 16/6/17.
//  Copyright © 2016年 SoKon. All rights reserved.
//

#import "SKTabBarItem.h"
#import "SKBadgeItem.h"
#define kOffset 3   //badgeValue 的偏移量

@interface SKTabBarItem ()

/** badgeItem */
@property (nonatomic, strong)SKBadgeItem *badgeItem;

@end

@implementation SKTabBarItem

- (instancetype)init
{
    if (self = [super init]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.adjustsImageWhenHighlighted = NO;
        self.adjustsImageWhenDisabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.badgeItem = [[SKBadgeItem alloc] init];
        [self addSubview:self.badgeItem];
    }
    return self;
}


- (void)setImages:(NSArray *)images
{
    if (!images) {
        return;
    }
    NSMutableArray *tempImages = [NSMutableArray array];
    if (images) {
        for (UIImage *tempImage in images) {
            [tempImages addObject:[self scaleToSize:CGSizeMake(30, 30) withImage:tempImage]];
        }
    }
    self.imageView.animationImages = images;
    _images = tempImages;
}

- (void)setDuration:(NSInteger)duration
{
    self.imageView.animationDuration = duration;
    _duration = duration;
}

- (void)setRepeatCount:(NSInteger)repeatCount
{
    self.imageView.animationRepeatCount = repeatCount;
    _repeatCount = repeatCount;
}

/**
 *  缩放图片
 *
 *  @param size  缩放后的尺寸
 *  @param image 原始图片
 *
 *  @return 缩放后的图片
 */
-(UIImage*)scaleToSize:(CGSize)size withImage:(UIImage *)image
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //Determine whether the screen is retina
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    }else{
        UIGraphicsBeginImageContext(size);
    }
    // 绘制改变大小的图片
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    [super setTitleColor:color forState:state];
    if (state == UIControlStateNormal) {
        _titleColor = color;
    }else if (state == UIControlStateSelected) {
        _titleSelectedColor = color;
    }
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    if (state == UIControlStateNormal) {
        _image = image;
    }else if (state == UIControlStateSelected) {
        _selectedImage = image;
    }
}

/**
 *  KVO回调方法
 *
 *  @param keyPath 监听的属性值
 *  @param object  监听的对象
 *  @param change  该变量
 *  @param context context地址
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![change isKindOfClass:[NSNull class]] && change != nil) {
        self.badgeValue = [change objectForKey:@"new"];
    }
}


- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat H = contentRect.size.height * self.ratio;
    CGFloat W = contentRect.size.width;
    return CGRectMake(0, 0, W, H);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat Y = contentRect.size.height * self.ratio;
    CGFloat H = contentRect.size.height * (1 - self.ratio);
    CGFloat W = contentRect.size.width;
    return CGRectMake(0, Y, W, H);
}

/** ratio的getter方法 */
- (CGFloat)ratio
{
    if (_ratio == 0.0) {
        return 0.7;
    }else{
        return _ratio;
    }
}

/** badgeValue 的setter方法 */
- (void)setBadgeValue:(NSString *)badgeValue
{
    if ([badgeValue isKindOfClass:[NSNull class]] || badgeValue == nil || [badgeValue isEqualToString:@""])
    {
        return;
    }
    _badgeValue = badgeValue;
    if ([badgeValue isEqualToString:@"new"]) {
        [self setBadgeItemWithNumber:2 badgeValue:badgeValue];
    }else{
        NSInteger num = [badgeValue integerValue];
        num = num > 99 ? 99 : num;
        if (num < 10 && num > 0) {
            [self setBadgeItemWithNumber:0 badgeValue:[NSString stringWithFormat:@"%ld",num]];
        }else if (10 <num && num <= 99) {
            [self setBadgeItemWithNumber:2 badgeValue:[NSString stringWithFormat:@"%ld",num]];
        }
    }
}

/**
 *  设置badgeValue
 *
 *  @param number     偏移量的倍数
 *  @param badgeValue badgeValue值
 */
- (void)setBadgeItemWithNumber:(NSUInteger)number badgeValue:(NSString *)badgeValue
{
    self.badgeItem.frame = CGRectMake(self.center.x + self.imageView.image.size.width / 2.0 - kOffset, 1, self.badgeItem.currentBackgroundImage.size.width + number * kOffset, self.badgeItem.currentBackgroundImage.size.height);
    [self.badgeItem setTitle:badgeValue forState:UIControlStateNormal];
}


- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}

@end
