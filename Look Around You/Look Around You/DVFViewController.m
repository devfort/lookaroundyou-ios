//
//  DVFViewController.m
//  Look Around You
//
//  Created by Neil Kimmett on 07/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import "DVFViewController.h"
#import "Notification.h"
#import "DVFLookAroundYouAPIClient.h"
#import "Person.h"
#import "DVFStyle.h"
#import "DVFConstants.h"
#import "DVFNotificationTableViewCell.h"
#import "DVFSettingsViewController.h"
#import "UIViewController+ModalPresentation.h"

@interface DVFViewController ()
@property (nonatomic, strong) NSArray *notifications;
@end

@implementation DVFViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Home";
        self.navigationItem.titleView = [DVFStyle labelForTitleView];
    }
    return self;
}

static NSString *CellIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fetchNotificationsFromAPI];
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(didTapSettingsButton:)];
    self.navigationItem.leftBarButtonItem = settingsButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRemoteNotification:) name:DVFReceivedNotificationKey object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DVFNotificationTableViewCell"
                                               bundle:[NSBundle mainBundle]]
                               forCellReuseIdentifier:CellIdentifier];
}

- (void)fetchNotificationsFromAPI
{
    NSString *clientID = [Person clientID];
    NSString *url =[NSString stringWithFormat:@"people/%@/notifications", clientID];
    
    [[DVFLookAroundYouAPIClient shared] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSArray *responseObject) {
        NSLog(@"notification response %@", responseObject);
        NSMutableArray *notifications = [NSMutableArray array];
        for (NSDictionary *json in responseObject) {
            Notification *notification = [Notification notificationFromJSON:json];
            [notifications addObject:notification];
        }
        self.notifications = notifications;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        NSLog(@"%@", task.response);
    }];
    self.notifications = @[[Notification notificationFromJSON:@{@"body": @"Thing thats happening", @"created_at": @"2013-09-29T10:40:15.765"}]];
}

- (void)didReceiveRemoteNotification:(NSNotification *)notification
{
    [self fetchNotificationsFromAPI];
}

#pragma mark - Constructors
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    });
    return dateFormatter;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DVFNotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    Notification *notification = self.notifications[indexPath.row];
    cell.titleLabel.text = notification.body;
    cell.dateLabel.text = [[self dateFormatter] stringFromDate:notification.date];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

#pragma mark - Buttons
- (void)didTapSettingsButton:(UIBarButtonItem *)button
{
    DVFSettingsViewController *viewController = [[DVFSettingsViewController alloc] init];
    [self presentNavigationControllerModallyWithViewController:viewController];
}

@end
