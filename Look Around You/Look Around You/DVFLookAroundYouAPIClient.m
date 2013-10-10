//
//  DVFLookAroundYouAPIClient.m
//  Look Around You
//
//  Created by Neil Kimmett on 07/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import "DVFLookAroundYouAPIClient.h"
#import "Person.h"
#import "DVFRFC8601DateFormatter.h"

@implementation DVFLookAroundYouAPIClient

+ (instancetype)shared
{
    static DVFLookAroundYouAPIClient *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://lookaroundyou.co/api/v1/"];
        _shared = [[self alloc] initWithBaseURL:baseURL];
        _shared.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    return _shared;
}

- (NSDictionary *)serializedLocationFromLocation:(CLLocation *)location
{
    NSString *nowDateString = [[DVFRFC8601DateFormatter shared] stringFromDate:[NSDate date]];
    return @{
             @"point": @{
                     @"type": @"point",
                     @"coordinates": @[@(location.coordinate.longitude), @(location.coordinate.latitude)]},
             @"altitude": @(location.altitude),
             @"horizontal_accuracy": @(location.horizontalAccuracy),
             @"vertical_accuracy": @(location.verticalAccuracy),
             @"course": @(location.course),
             @"speed": @(location.speed),
             @"measured_at": nowDateString
    };
}

- (void)POSTLocation:(CLLocation *)location
{
    NSDictionary *serializedLocation = [self serializedLocationFromLocation:location];
    NSString *url = [NSString stringWithFormat:@"people/%@/locations", [Person clientID]];
    [self POST:url parameters:serializedLocation success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"location post succ: %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"location post ERR: %@", error);
    }];
}

@end
