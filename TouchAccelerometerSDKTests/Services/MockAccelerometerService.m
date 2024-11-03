//
//  MockAccelerometerService.m
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 31.10.24.
//

#import "MockAccelerometerService.h"

@implementation MockAccelerometerService
- (void)startTracking {
    self.isTracking = YES;
    NSLog(@"Mock accelerometer tracking started.");
    // Here you could simulate accelerometer data generation if needed
}

- (void)stopTracking {
    self.isTracking = NO;
    NSLog(@"Mock accelerometer tracking stopped.");
    // Stop simulated data if needed
}
@end
