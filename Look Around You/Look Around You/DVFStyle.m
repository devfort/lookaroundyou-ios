//
//  DVFStyle.m
//  Look Around You
//
//  Created by Neil Kimmett on 10/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import "DVFStyle.h"

@implementation DVFStyle

+ (void)applyGlobalStyleToWindow:(UIWindow *)window
{
    UIColor *tintColor = UIColorFromRGB(0xef6d28);
    window.tintColor = tintColor;

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [[UINavigationBar appearance] setBarTintColor:tintColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName: [self mediumFontWithSize:18],
                                                           NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName: [self fontWithSize:16]} forState:UIControlStateNormal];
}

+ (UIFont *)fontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"STHeitiSC-Light" size:size];
}

+ (UIFont *)mediumFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"STHeitiSC-Medium" size:size];
}

+ (UILabel *)labelForTitleView
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"Look Around You";
    label.font = [self fontWithSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, 150, 40);
    label.textColor = [UIColor whiteColor];
    return label;
}

@end
