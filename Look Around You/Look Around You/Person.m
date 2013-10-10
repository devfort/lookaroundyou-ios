//
//  Person.m
//  Look Around You
//
//  Created by Neil Kimmett on 10/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import "Person.h"
#import "DVFConstants.h"

@implementation Person

+ (NSString *)clientID
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:DVFClientIDKey];
}

+ (void)setClientID:(NSString *)clientID
{
    [[NSUserDefaults standardUserDefaults] setValue:clientID forKey:DVFClientIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

@end
