//
//  Person.m
//  Look Around You
//
//  Created by Neil Kimmett on 10/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import "Person.h"
#import "DVFConstants.h"

static NSString * const DVFClientIDKey = @"DVFClientID";
static NSString * const DVFTrackLocationInBackground = @"DVFTrackLocationInBackground";

@implementation Person

+ (NSString *)clientID
{
#if (TARGET_IPHONE_SIMULATOR)
    return @"b1d28eab-3263-4ce5-8580-b0b11ce663d4";
#else
    return [[NSUserDefaults standardUserDefaults] stringForKey:DVFClientIDKey];
#endif
}

+ (void)setClientID:(NSString *)clientID
{
    [[NSUserDefaults standardUserDefaults] setValue:clientID forKey:DVFClientIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)trackLocationInBackground
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:DVFTrackLocationInBackground];
}

+ (void)setTrackLocationInBackground:(BOOL)track
{
    [[NSUserDefaults standardUserDefaults] setBool:track forKey:DVFTrackLocationInBackground];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
