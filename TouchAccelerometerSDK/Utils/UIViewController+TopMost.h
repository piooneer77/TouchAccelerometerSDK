//
//  UIViewController+TopMost.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TopMost)
+ (UIViewController *)topMostViewController;
+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController;
@end
