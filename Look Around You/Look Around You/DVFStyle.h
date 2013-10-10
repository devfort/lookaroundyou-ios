//
//  DVFStyle.h
//  Look Around You
//
//  Created by Neil Kimmett on 10/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVFStyle : NSObject

+ (void)applyGlobalStyleToWindow:(UIWindow *)window;
+ (UIFont *)fontWithSize:(CGFloat)size;
+ (UILabel *)labelForTitleView;

@end
