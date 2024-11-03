//
//  EventManager.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import "EventManager.h"
#import "DataRepository.h"
#import "TouchEventService.h"
#import "AccelerometerService.h"

@interface EventManager ()
@property (nonatomic, strong, readonly) id<TouchEventServiceProtocol> touchEventService;
@property (nonatomic, strong, readonly) id<AccelerometerServiceProtocol> accelerometerService;
@property (nonatomic, strong, readonly) DataRepository *dataRepository;
@end

@implementation EventManager

+ (instancetype)sharedInstance {
    static EventManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initPrivate];
    });
    return sharedInstance;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _touchEventService = [[TouchEventService alloc] init];
        _accelerometerService = [[AccelerometerService alloc] init];
        _dataRepository = [[DataRepository alloc] init];
    }
    return self;
}

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)dealloc {
    [_touchEventService stopTouchEventCollection];
    [_accelerometerService stopAccelerometerCollection];
}

- (void)startCollection {
    [self.touchEventService startTouchEventCollection];
    [self.accelerometerService startAccelerometerCollection];
}

- (void)stopCollection {
    [self.touchEventService stopTouchEventCollection];
    [self.accelerometerService stopAccelerometerCollection];
}

- (NSArray<NSDictionary *> *)retrieveCollectedData {
    NSArray *touchEvents = [self.touchEventService retrieveTouchEvents];
    NSArray *accelerometerData = [self.accelerometerService retrieveAccelerometerData];
    // Sort and combine both arrays based on timestamp or criteria.
    return [self mergeAndSortData:touchEvents accelerometerData:accelerometerData];
}

- (NSArray<NSDictionary *> *)mergeAndSortData:(NSArray *)touchEvents accelerometerData:(NSArray *)accelerometerData {
    NSMutableArray *mergedData = [NSMutableArray array];
    [mergedData addObjectsFromArray:touchEvents];
    [mergedData addObjectsFromArray:accelerometerData];
    [mergedData sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        NSNumber *timestamp1 = obj1[@"timestamp"];
        NSNumber *timestamp2 = obj2[@"timestamp"];
        return [timestamp1 compare:timestamp2];
    }];
    return [mergedData copy];
}

@end
