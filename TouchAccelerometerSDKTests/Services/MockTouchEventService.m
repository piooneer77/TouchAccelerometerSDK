//
//  MockTouchEventService.m
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 31.10.24.
//

#import "MockTouchEventService.h"


@implementation MockTouchEventService
- (void)startTracking {
    NSLog(@"Mock touch event tracking started.");
}

- (void)stopTracking {
    NSLog(@"Mock touch event tracking stopped.");
}
@end
