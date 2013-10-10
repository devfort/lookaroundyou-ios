//
//  DVFLookAroundYouAPIClient.h
//  Look Around You
//
//  Created by Neil Kimmett on 07/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

@import CoreLocation;

#import "AFHTTPSessionManager.h"

@interface DVFLookAroundYouAPIClient : AFHTTPSessionManager

+ (instancetype)shared;
- (void)POSTLocation:(CLLocation *)location;

@end
