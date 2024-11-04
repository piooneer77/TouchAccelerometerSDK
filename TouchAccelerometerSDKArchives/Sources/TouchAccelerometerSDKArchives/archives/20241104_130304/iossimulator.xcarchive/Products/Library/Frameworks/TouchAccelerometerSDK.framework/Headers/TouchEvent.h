//
//  TouchEvent.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <TouchAccelerometerSDK/EventTrackable.h>
#import <TouchAccelerometerSDK/TouchEvent.h>
#import <TouchAccelerometerSDK/TouchEventType.h>

NS_ASSUME_NONNULL_BEGIN

@interface TouchEvent : NSObject <EventTrackable>

@property (nonatomic, readonly, strong) NSDate *timestamp;
@property (nonatomic, readonly, copy) NSString *viewIdentifier;
@property (nonatomic, readonly) CGPoint location;
@property (nonatomic, readonly) TouchEventType type;
@property (nonatomic, readonly) UISwipeGestureRecognizerDirection swipeDirection;

- (instancetype)initWithTimestamp:(NSDate *)timestamp
                   viewIdentifier:(NSString *)viewIdentifier
                         location:(CGPoint)location
                             type:(TouchEventType)type
                   swipeDirection:(UISwipeGestureRecognizerDirection)swipeDirection;

+ (instancetype)tapEventWithTimestamp:(NSDate *)timestamp
                       viewIdentifier:(NSString *)viewIdentifier
                             location:(CGPoint)location;

+ (instancetype)swipeEventWithTimestamp:(NSDate *)timestamp
                         viewIdentifier:(NSString *)viewIdentifier
                               location:(CGPoint)location
                         swipeDirection:(UISwipeGestureRecognizerDirection)direction;

@end

NS_ASSUME_NONNULL_END
