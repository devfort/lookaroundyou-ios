//
//  DVFNotificationDetailViewController.h
//  Look Around You
//
//  Created by Neil Kimmett on 14/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

@import UIKit;
@import MapKit.MKMapView;

@class Notification;

@interface DVFNotificationDetailViewController : UIViewController

- (instancetype)initWithNotification:(Notification *)notification;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *bodyLabel;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@end
