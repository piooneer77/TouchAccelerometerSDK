//
//  AccelerometerEvent.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import "AccelerometerEvent.h"

@implementation AccelerometerEvent

- (instancetype)initWithTimestamp:(NSDate *)timestamp
                   viewIdentifier:(NSString *)viewIdentifier
                     acceleration:(CMAcceleration)acceleration {
    self = [super init];
    if (self) {
        _timestamp = timestamp;
        _viewIdentifier = [viewIdentifier copy];
        _acceleration = acceleration;
    }
    return self;
}

@end
