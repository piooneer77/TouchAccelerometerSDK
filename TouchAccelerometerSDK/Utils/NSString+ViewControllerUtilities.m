//
//  NSString+ViewControllerUtilities.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import "NSString+ViewControllerUtilities.h"

@implementation NSString (ViewControllerUtilities)

+ (NSString *)viewControllerNameFromController:(nullable UIViewController *)viewController {
    if (!viewController) {
        return @"Unknown";
    }
    
    return NSStringFromClass([viewController class]);
}

@end
