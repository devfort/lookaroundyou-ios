//
//  DVFRFC8601DateFormatter.m
//  Look Around You
//
//  Created by Neil Kimmett on 10/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import "DVFRFC8601DateFormatter.h"

@implementation DVFRFC8601DateFormatter

- (id)init
{
    self = [super init];
    if (self) {
        self.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    }
    return self;
}

+ (instancetype)shared
{
    static DVFRFC8601DateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[self alloc] init];
    });
    return _dateFormatter;
}

@end
