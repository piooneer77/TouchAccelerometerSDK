//
//  AccelerometerService.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <CoreMotion/CoreMotion.h>
#import "AccelerometerService.h"
#import "UIViewController+TopMost.h"
#import "NSString+ViewControllerUtilities.h"

@interface AccelerometerService ()
@property (atomic, strong) NSMutableArray<AccelerometerEvent *> *accelerometerData;
@property (nonatomic, strong) CMMotionManager *motionManager;
@end

@implementation AccelerometerService

- (instancetype)init {
    self = [super init];
    if (self) {
        _accelerometerData = [NSMutableArray array];
        _motionManager = [[CMMotionManager alloc] init];
    }
    return self;
}

- (void)dealloc {
    _motionManager = NULL;
    _accelerometerData = NULL;
}

- (void)startAccelerometerCollection {
    if (self.motionManager.isAccelerometerAvailable) {
        self.motionManager.accelerometerUpdateInterval = 0.2;
        [self.motionManager startAccelerometerUpdatesToQueue: [NSOperationQueue mainQueue]
                                                 withHandler: ^(CMAccelerometerData * _Nullable data, NSError * _Nullable error) {
            if (data) {
                UIViewController *topViewController = [UIViewController topMostViewController];
                NSString *viewIdentifier = [NSString viewControllerNameFromController:topViewController];
                
                AccelerometerEvent *event = [[AccelerometerEvent alloc]
                                             initWithTimestamp: [NSDate date]
                                             viewIdentifier: viewIdentifier
                                             acceleration: data.acceleration];
                
                NSLog(@"Motion Event: x=%f, y=%f, z=%f",
                      event.acceleration.x,
                      event.acceleration.y,
                      event.acceleration.z);
                
                [self.accelerometerData addObject: event];
            }
        }];
    }
}

- (void)stopAccelerometerCollection {
    [self.motionManager stopAccelerometerUpdates];
}

- (NSArray<NSDictionary *> *)retrieveAccelerometerData {
    return [self.accelerometerData copy];
}

@end
