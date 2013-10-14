//
//  DVFLocationManager.h
//  Look Around You
//
//  Created by Neil Kimmett on 08/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVFLocationManager : NSObject

+ (instancetype)shared;
- (void)startSignificantChangeUpdates;
- (void)stopSignificantChangeUpdates;

@end