//
//  UIViewController+ModalPresentation.h
//  Food(ness)
//
//  Created by Neil Kimmett on 26/06/2013.
//  Copyright (c) 2013 Marks & Spencer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ModalPresentation)

- (void)presentNavigationControllerModallyWithViewController:(UIViewController *)viewController;

- (UINavigationController *)navigationControllerForModalPresentationWithViewController:(UIViewController *)viewController
                                                                      closeButtonTitle:(NSString *)closeButtonTitle;

- (void)presentNavigationControllerModallyWithViewController:(UIViewController *)viewController
                                            closeButtonTitle:(NSString *)closeButtonTitle;
@end
