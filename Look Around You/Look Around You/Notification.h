//
//  Notification.h
//  Look Around You
//
//  Created by Neil Kimmett on 07/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

@import Foundation;
@import CoreLocation;

@interface Notification : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, strong) NSDate *date;

+ (instancetype)notificationFromJSON:(NSDictionary *)json;

@end
