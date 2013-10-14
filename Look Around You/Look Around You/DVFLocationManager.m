//
//  DVFLocationManager.m
//  Look Around You
//
//  Created by Neil Kimmett on 08/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

@import CoreLocation;

#import "DVFLocationManager.h"
#import "DVFLookAroundYouAPIClient.h"

@interface DVFLocationManager () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation DVFLocationManager

+ (instancetype)shared
{
    static DVFLocationManager *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (void)startSignificantChangeUpdates
{
    if (nil == _locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    self.locationManager.delegate = self;
    [self.locationManager startMonitoringSignificantLocationChanges];
}

- (void)stopSignificantChangeUpdates
{
    [self.locationManager stopMonitoringSignificantLocationChanges];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *location in locations) {
        [[DVFLookAroundYouAPIClient shared] POSTLocation:location];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Location error: %@", error);
}

@end
