//
//  EventManager.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import "EventManager.h"
#import "DataRepository.h"

@interface EventManager ()
@property (nonatomic, strong) id<TouchEventServiceProtocol> touchEventService;
@property (nonatomic, strong) id<AccelerometerServiceProtocol> accelerometerService;
@property (nonatomic, strong) DataRepository *dataRepository;
@end

@implementation EventManager

- (instancetype)initWithTouchService:(id<TouchEventServiceProtocol>)touchService
                 accelerometerService:(id<AccelerometerServiceProtocol>)accelerometerService {
    self = [super init];
    if (self) {
        _touchEventService = touchService;
        _accelerometerService = accelerometerService;
        _dataRepository = [[DataRepository alloc] init];
    }
    return self;
}

- (void)startCollection {
    [self.touchEventService startTracking];
    [self.accelerometerService startTracking];
}

- (void)stopCollection {
    [self.touchEventService stopTracking];
    [self.accelerometerService stopTracking];
}

- (NSArray<NSDictionary *> *)retrieveCollectedData {
    return [self.dataRepository fetchAllEventsSortedByTimestamp];
}

@end
