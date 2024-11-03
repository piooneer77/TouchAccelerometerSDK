//
//  EventManager.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import <TouchAccelerometerSDK/TouchEventServiceProtocol.h>
#import <TouchAccelerometerSDK/AccelerometerServiceProtocol.h>
#import <TouchAccelerometerSDK/EventTrackable.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EventCollectionState) {
    EventCollectionStateIdle,
    EventCollectionStateCollecting,
    EventCollectionStateError
};

@interface EventManager : NSObject

@property (nonatomic, readonly) EventCollectionState collectionState;
@property (nonatomic, readonly) NSError *lastError;

+ (instancetype)sharedInstance;

- (void)startCollection;
- (void)stopCollection;

- (NSArray<id<EventTrackable>> *)retrieveCollectedData;
- (NSArray<TouchEvent *> *)retrieveTouchEvents;
- (NSArray<AccelerometerEvent *> *)retrieveAccelerometerEvents;

- (instancetype)initWithTouchService:(id<TouchEventServiceProtocol>)touchService
                accelerometerService:(id<AccelerometerServiceProtocol>)accelerometerService;

@end

NS_ASSUME_NONNULL_END
