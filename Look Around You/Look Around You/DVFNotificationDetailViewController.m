//
//  DVFNotificationDetailViewController.m
//  Look Around You
//
//  Created by Neil Kimmett on 14/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import "DVFNotificationDetailViewController.h"
#import "Notification.h"

@interface DVFNotificationDetailViewController ()
@property (nonatomic, strong) Notification *notification;
@end

@implementation DVFNotificationDetailViewController

- (instancetype)initWithNotification:(Notification *)notification
{
    self = [super init];
    if (self) {
        _notification = notification;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = self.notification.title;
    self.bodyLabel.text = self.notification.body;
    
    if (CLLocationCoordinate2DIsValid(self.notification.location)) {
        self.mapView.centerCoordinate = self.notification.location;
    }
}

@end
