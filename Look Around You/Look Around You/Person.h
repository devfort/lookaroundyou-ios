//
//  Person.h
//  Look Around You
//
//  Created by Neil Kimmett on 10/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

+ (NSString *)clientID;
+ (void)setClientID:(NSString *)clientID;
+ (BOOL)trackLocationInBackground;
+ (void)setTrackLocationInBackground:(BOOL)track;

@end
