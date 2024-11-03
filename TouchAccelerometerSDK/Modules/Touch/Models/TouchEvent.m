//
//  TouchEvent.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import "TouchEvent.h"

@implementation TouchEvent

- (instancetype)initWithTimestamp:(NSDate *)timestamp
                   viewIdentifier:(NSString *)viewIdentifier
                         location:(CGPoint)location
                             type:(TouchEventType)type
                   swipeDirection:(UISwipeGestureRecognizerDirection)swipeDirection {
    self = [super init];
    if (self) {
        _timestamp = timestamp;
        _viewIdentifier = [viewIdentifier copy];
        _location = location;
        _type = type;
        _swipeDirection = swipeDirection;
    }
    return self;
}

+ (instancetype)tapEventWithTimestamp:(NSDate *)timestamp
                       viewIdentifier:(NSString *)viewIdentifier
                             location:(CGPoint)location {
    return [[self alloc] initWithTimestamp:timestamp
                            viewIdentifier:viewIdentifier
                                  location:location
                                      type:TouchEventTypeTap
                            swipeDirection:0];
}

+ (instancetype)swipeEventWithTimestamp:(NSDate *)timestamp
                         viewIdentifier:(NSString *)viewIdentifier
                               location:(CGPoint)location
                         swipeDirection:(UISwipeGestureRecognizerDirection)direction {
    return [[self alloc] initWithTimestamp:timestamp
                            viewIdentifier:viewIdentifier
                                  location:location
                                      type:TouchEventTypeSwipe
                            swipeDirection:direction];
}

@end
