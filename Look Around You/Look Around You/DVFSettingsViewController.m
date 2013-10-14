//
//  DVFSettingsViewController.m
//  Look Around You
//
//  Created by Neil Kimmett on 14/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import "DVFSettingsViewController.h"
#import "Person.h"
#import "DVFLocationManager.h"

@interface DVFSettingsViewController ()

@end

@implementation DVFSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Settings";
    
    self.backgroundLocationSwitch.on = [Person trackLocationInBackground];
    [self.backgroundLocationSwitch addTarget:self
                                      action:@selector(backgroundLocationSwitchDidSwitch:)
                            forControlEvents:UIControlEventValueChanged];
}

- (void)backgroundLocationSwitchDidSwitch:(UISwitch *)locationSwitch
{
    [Person setTrackLocationInBackground:locationSwitch.isOn];
    if (locationSwitch.isOn) {
        [[DVFLocationManager shared] startSignificantChangeUpdates];
    }
    else {
        [[DVFLocationManager shared] stopSignificantChangeUpdates];
    }
}

@end
