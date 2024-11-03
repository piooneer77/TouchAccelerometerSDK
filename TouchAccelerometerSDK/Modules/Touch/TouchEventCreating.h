//
//  TouchEventCreating.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TouchEvent.h"

@protocol TouchEventCreating <NSObject>
- (nullable TouchEvent *)createEventFromTouch:(UITouch *)touch
                                       inView:(UIView *)view
                            forViewController:(UIViewController *)viewController;
@end
