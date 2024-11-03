//
//  TouchEventFactory.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import "TouchEventFactory.h"
#import "NSString+ViewControllerUtilities.h"

@implementation TouchEventFactory

- (nullable TouchEvent *)createEventFromTouch:(UITouch *)touch
                                       inView:(UIView *)view
                            forViewController:(UIViewController *)viewController {
    if (!touch || !view) return nil;
    
    NSString *viewControllerName = [NSString viewControllerNameFromController:viewController];
    CGPoint location = [touch locationInView:view];
    
    switch (touch.phase) {
        case UITouchPhaseBegan:
        case UITouchPhaseEnded:
            return [self createTapEventWithLocation:location
                                     viewController:viewControllerName];
            
        case UITouchPhaseMoved:
            return [self createSwipeEventWithTouch:touch
                                            inView:view
                                    viewController:viewControllerName];
            
        default:
            return nil;
    }
}

- (TouchEvent *)createTapEventWithLocation:(CGPoint)location
                            viewController:(NSString *)viewControllerName {
    return [TouchEvent tapEventWithTimestamp:[NSDate date]
                              viewIdentifier:viewControllerName
                                    location:location];
}

- (nullable TouchEvent *)createSwipeEventWithTouch:(UITouch *)touch
                                            inView:(UIView *)view
                                    viewController:(NSString *)viewControllerName {
    CGPoint currentLocation = [touch locationInView:view];
    CGPoint previousLocation = [touch previousLocationInView:view];
    
    UISwipeGestureRecognizerDirection direction = [self determineSwipeDirection:currentLocation
                                                               previousLocation:previousLocation];
    
    if (direction != 0) {
        return [TouchEvent swipeEventWithTimestamp:[NSDate date]
                                    viewIdentifier:viewControllerName
                                          location:currentLocation
                                    swipeDirection:direction];
    }
    
    return nil;
}

- (UISwipeGestureRecognizerDirection)determineSwipeDirection:(CGPoint)currentLocation
                                            previousLocation:(CGPoint)previousLocation {
    CGFloat deltaX = currentLocation.x - previousLocation.x;
    CGFloat deltaY = currentLocation.y - previousLocation.y;
    CGFloat threshold = 50.0;
    
    if (fabs(deltaX) > fabs(deltaY)) {
        if (deltaX > threshold) return UISwipeGestureRecognizerDirectionRight;
        if (deltaX < -threshold) return UISwipeGestureRecognizerDirectionLeft;
    } else {
        if (deltaY > threshold) return UISwipeGestureRecognizerDirectionDown;
        if (deltaY < -threshold) return UISwipeGestureRecognizerDirectionUp;
    }
    
    return 0;
}

@end
