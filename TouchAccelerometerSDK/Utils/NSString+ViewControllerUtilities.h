//
//  NSString+ViewControllerUtilities.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ViewControllerUtilities)
+ (NSString *)viewControllerNameFromController:(nullable UIViewController *)viewController;
@end
