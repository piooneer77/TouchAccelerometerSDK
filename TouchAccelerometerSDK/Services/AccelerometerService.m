//
//  AccelerometerService.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <CoreMotion/CoreMotion.h>
#import "AccelerometerService.h"

@implementation AccelerometerService {
    CMMotionManager *motionManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        motionManager = [[CMMotionManager alloc] init];
    }
    return self;
}

- (void)startTracking {
    if (motionManager.isAccelerometerAvailable) {
        [motionManager startAccelerometerUpdates];
    }
}

- (void)stopTracking {
    [motionManager stopAccelerometerUpdates];
}

@end
