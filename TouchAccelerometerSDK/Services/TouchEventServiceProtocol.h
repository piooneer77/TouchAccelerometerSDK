//
//  TouchEventServiceProtocol.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TouchEventServiceProtocol <NSObject>
- (void)startTracking;
- (void)stopTracking;
@end

NS_ASSUME_NONNULL_END
