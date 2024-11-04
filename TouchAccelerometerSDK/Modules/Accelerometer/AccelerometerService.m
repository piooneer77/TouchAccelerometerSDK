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
#import "APIClient.h"

@interface AccelerometerService ()
@property (nonatomic, strong) id<AccelerometerEventStoring> storage;
@property (nonatomic, strong) id<APIClientProtocol> apiClient;
@end

@implementation AccelerometerService

- (instancetype)init {
    return [self initWithStorage:[[AccelerometerFileStorage alloc] initWithFilename:@"accelerometer_events.csv"]
                       apiClient:[[APIClient alloc] initWithNetworkService:[NetworkService shared]]];
}

- (instancetype)initWithStorage:(id<AccelerometerEventStoring>)storage
                      apiClient:(id<APIClientProtocol>)apiClient {
    self = [super init];
    if (self) {
        _motionManager = [[CMMotionManager alloc] init];
        _storage = storage;
        _apiClient = apiClient;
        
        [self setupEventHandling];
    }
    return self;
}

- (void)dealloc {
    [self stopAccelerometerCollection];
    _motionManager = nil;
}

- (void)setupEventHandling {
    __weak typeof(self) weakSelf = self;
    self.motionManager.accelerometerUpdateInterval = 0.1;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                             withHandler:^(CMAccelerometerData *data, NSError *error) {
        if (data) {
            UIViewController *topViewController = [UIViewController topMostViewController];
            NSString *viewIdentifier = [NSString viewControllerNameFromController:topViewController];
            
            AccelerometerEvent *event = [[AccelerometerEvent alloc]
                                         initWithTimestamp:[NSDate date]
                                         viewIdentifier:viewIdentifier
                                         acceleration:data.acceleration];
            
            [weakSelf.storage storeEvent:event];
            
            NSArray<AccelerometerEvent *> *events = [weakSelf.storage retrieveEvents];
            if (events.count >= 50) {
                [weakSelf.apiClient sendAccelerometerEvents:events completion:^(BOOL success, NSError *error) {
                    if (success) {
                        [weakSelf.storage clearEvents];
                    }
                }];
            }
        }
    }];
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
