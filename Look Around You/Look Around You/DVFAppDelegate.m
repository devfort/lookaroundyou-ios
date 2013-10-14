//
//  DVFAppDelegate.m
//  Look Around You
//
//  Created by Neil Kimmett on 07/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import "DVFAppDelegate.h"
#import "DVFNotificationListViewController.h"
#import "DVFConstants.h"
#import "DVFLookAroundYouAPIClient.h"
#import "DVFLocationManager.h"
#import "Person.h"
#import "DVFStyle.h"

@implementation DVFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [DVFStyle applyGlobalStyleToWindow:self.window];
    
    DVFNotificationListViewController *viewController = [[DVFNotificationListViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];

    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert];
    
    if ([Person trackLocationInBackground]) {
        [[DVFLocationManager shared] startSignificantChangeUpdates];
    }
    return YES;
}

- (NSString *)deviceTokenFromData:(NSData *)deviceToken
{
    // Convert NSData token to string
    return [[[deviceToken description] stringByTrimmingCharactersInSet:
             [NSCharacterSet characterSetWithCharactersInString:@"<>"]]
            stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSDictionary *params = @{@"apns_token": [self deviceTokenFromData:deviceToken]};
    NSString *clientID = [Person clientID];
    if (clientID) {
        NSString *patchURL = [NSString stringWithFormat:@"people/%@", clientID];
        [[DVFLookAroundYouAPIClient shared] PATCH:patchURL parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            [self handleSuccessfulDeviceTokenRegistrationWithResponse:responseObject];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"PATCH error: %@", error);
        }];
    }
    else {
        [[DVFLookAroundYouAPIClient shared] POST:@"people" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            [self handleSuccessfulDeviceTokenRegistrationWithResponse:responseObject];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"POST error: %@", error);
        }];
    }
}

- (void)handleSuccessfulDeviceTokenRegistrationWithResponse:(NSDictionary *)response
{
    [Person setClientID:response[@"id"]];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"FAILd to register for remote notifications: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:DVFReceivedNotificationKey object:self];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
