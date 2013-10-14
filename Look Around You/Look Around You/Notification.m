//
//  Notification.m
//  Look Around You
//
//  Created by Neil Kimmett on 07/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import "Notification.h"
#import "DVFRFC8601DateFormatter.h"

@implementation Notification

+ (instancetype)notificationFromJSON:(NSDictionary *)json
{
    Notification *notification = [[self alloc] init];
    notification.title = json[@"title"];
    notification.body = json[@"body"];
    notification.date = [[DVFRFC8601DateFormatter shared] dateFromString:json[@"created_at"]];
    if (json[@"location"]) {
        CLLocationDegrees latitude = [json[@"location"][@"latitude"] floatValue];
        CLLocationDegrees longitude = [json[@"location"][@"longitude"] floatValue];
        notification.location = CLLocationCoordinate2DMake(latitude, longitude);
    }
    else {
        notification.location = kCLLocationCoordinate2DInvalid;
    }
    return notification;
}

@end
