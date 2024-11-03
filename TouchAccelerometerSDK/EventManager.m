//
//  EventManager.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import "EventManager.h"
#import "TouchEventService.h"
#import "AccelerometerService.h"

@interface EventManager ()
@property (nonatomic, strong, readonly) id<TouchEventServiceProtocol> touchEventService;
@property (nonatomic, strong, readonly) id<AccelerometerServiceProtocol> accelerometerService;
@property (nonatomic, assign) EventCollectionState collectionState;
@property (nonatomic, strong) NSError *lastError;
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
    return [self initWithTouchService:[[TouchEventService alloc] init]
                 accelerometerService:[[AccelerometerService alloc] init]];
}

- (instancetype)initWithTouchService:(id<TouchEventServiceProtocol>)touchService
                accelerometerService:(id<AccelerometerServiceProtocol>)accelerometerService {
    self = [super init];
    if (self) {
        _touchEventService = touchService;
        _accelerometerService = accelerometerService;
        _collectionState = EventCollectionStateIdle;
    }
    return self;
}

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)dealloc {
    [self stopCollection];
}

- (void)startCollection {
    @try {
        self.collectionState = EventCollectionStateCollecting;
        [self.touchEventService startTouchEventCollection];
        [self.accelerometerService startAccelerometerCollection];
    } @catch (NSException *exception) {
        self.lastError = [NSError errorWithDomain:@"com.touchaccelerometersdk"
                                             code:1001
                                         userInfo:@{NSLocalizedDescriptionKey: exception.reason ?: @"Failed to start collection"}];
        self.collectionState = EventCollectionStateError;
    }
}

- (void)stopCollection {
    @try {
        [self.touchEventService stopTouchEventCollection];
        [self.accelerometerService stopAccelerometerCollection];
        self.collectionState = EventCollectionStateIdle;
    } @catch (NSException *exception) {
        self.lastError = [NSError errorWithDomain:@"com.touchaccelerometersdk"
                                             code:1002
                                         userInfo:@{NSLocalizedDescriptionKey: exception.reason ?: @"Failed to stop collection"}];
        self.collectionState = EventCollectionStateError;
    }
}

- (NSArray<TouchEvent *> *)retrieveTouchEvents {
    return [self.touchEventService retrieveTouchEvents];
}

- (NSArray<AccelerometerEvent *> *)retrieveAccelerometerEvents {
    return [self.accelerometerService retrieveAccelerometerData];
}

- (NSArray<id<EventTrackable>> *)retrieveCollectedData {
    NSArray *touchEvents = [self retrieveTouchEvents];
    NSArray *accelerometerData = [self retrieveAccelerometerEvents];
    return [self mergeAndSortData:touchEvents accelerometerData:accelerometerData];
}

- (NSArray<id<EventTrackable>> *)mergeAndSortData:(NSArray<TouchEvent *> *)touchEvents
                                accelerometerData:(NSArray<AccelerometerEvent *> *)accelerometerData {
    NSMutableArray<id<EventTrackable>> *mergedData = [NSMutableArray array];
    
    [mergedData addObjectsFromArray:touchEvents];
    [mergedData addObjectsFromArray:accelerometerData];
    
    [mergedData sortUsingComparator:^NSComparisonResult(id<EventTrackable> obj1, id<EventTrackable> obj2) {
        return [obj1.timestamp compare:obj2.timestamp];
    }];
    
    return [mergedData copy];
}

@end
