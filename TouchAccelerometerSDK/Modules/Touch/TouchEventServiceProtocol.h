//
//  TouchEventServiceProtocol.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import <TouchAccelerometerSDK/TouchEvent.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TouchEventServiceProtocol <NSObject>
- (void)startTouchEventCollection;
- (void)stopTouchEventCollection;
- (NSArray<TouchEvent *> *)retrieveTouchEvents;
@end

NS_ASSUME_NONNULL_END
