//
//  AccelerometerService.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <CoreMotion/CoreMotion.h>
#import "AccelerometerService.h"
#import "AccelerometerFileStorage.h"
#import "UIViewController+TopMost.h"
#import "NSString+ViewControllerUtilities.h"

@interface AccelerometerService ()
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) id<AccelerometerEventStoring> storage;
@end

@implementation AccelerometerService

- (instancetype)init {
    return [self initWithStorage:[[AccelerometerFileStorage alloc] initWithFilename:@"accelerometer_events.csv"]];
}

- (instancetype)initWithStorage:(id<AccelerometerEventStoring>)storage {
    self = [super init];
    if (self) {
        _motionManager = [[CMMotionManager alloc] init];
        _storage = storage;
    }
    return self;
}

- (void)dealloc {
    [self stopAccelerometerCollection];
    _motionManager = nil;
}

- (void)startAccelerometerCollection {
    if (self.motionManager.isAccelerometerAvailable) {
        self.motionManager.accelerometerUpdateInterval = 0.1;
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMAccelerometerData * _Nullable data, NSError * _Nullable error) {
            if (data) {
                UIViewController *topViewController = [UIViewController topMostViewController];
                NSString *viewIdentifier = [NSString viewControllerNameFromController:topViewController];
                
                AccelerometerEvent *event = [[AccelerometerEvent alloc]
                                             initWithTimestamp:[NSDate date]
                                             viewIdentifier:viewIdentifier
                                             acceleration:data.acceleration];
                
                NSLog(@"Motion Event: x=%f, y=%f, z=%f",
                      event.acceleration.x,
                      event.acceleration.y,
                      event.acceleration.z);
                
                [self.storage storeEvent:event];
            }
        }];
    }
}

- (void)stopAccelerometerCollection {
    [self.motionManager stopAccelerometerUpdates];
}

- (NSArray<AccelerometerEvent *> *)retrieveAccelerometerData {
    return [self.storage retrieveEvents];
}

@end
