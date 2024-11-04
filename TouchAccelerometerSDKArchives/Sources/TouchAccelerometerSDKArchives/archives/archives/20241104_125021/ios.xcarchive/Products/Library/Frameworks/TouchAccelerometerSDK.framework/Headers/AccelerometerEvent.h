//
//  AccelerometerEvent.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <TouchAccelerometerSDK/EventTrackable.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccelerometerEvent : NSObject <EventTrackable>

@property (nonatomic, readonly, strong) NSDate *timestamp;
@property (nonatomic, readonly, copy) NSString *viewIdentifier;
@property (nonatomic, readonly) CMAcceleration acceleration;

- (instancetype)initWithTimestamp:(NSDate *)timestamp
                   viewIdentifier:(NSString *)viewIdentifier
                     acceleration:(CMAcceleration)acceleration;

@end

NS_ASSUME_NONNULL_END
