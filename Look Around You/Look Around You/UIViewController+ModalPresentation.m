//
//  UIViewController+ModalPresentation.m
//  Food(ness)
//
//  Created by Neil Kimmett on 26/06/2013.
//  Copyright (c) 2013 Marks & Spencer. All rights reserved.
//

#import "UIViewController+ModalPresentation.h"

@implementation UIViewController (ModalPresentation)

- (void)presentNavigationControllerModallyWithViewController:(UIViewController *)viewController
{
    [self presentNavigationControllerModallyWithViewController:viewController closeButtonTitle:@"Close"];
}

- (void)presentNavigationControllerModallyWithViewController:(UIViewController *)viewController
                                            closeButtonTitle:(NSString *)closeButtonTitle
{
    UINavigationController *navController = [self navigationControllerForModalPresentationWithViewController:viewController
                                                                                            closeButtonTitle:closeButtonTitle];
    [self presentViewController:navController animated:YES completion:nil];
}

- (UINavigationController *)navigationControllerForModalPresentationWithViewController:(UIViewController *)viewController
                                                                      closeButtonTitle:(NSString *)closeButtonTitle
{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:closeButtonTitle
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(dismissModalViewControllerAnimated:)];
    viewController.navigationItem.leftBarButtonItem = closeButton;
    return navController;
}


@end
