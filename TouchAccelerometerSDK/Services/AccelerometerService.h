//
//  AccelerometerService.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import "AccelerometerServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccelerometerService : NSObject <AccelerometerServiceProtocol>
- (void)startTracking;
- (void)stopTracking;
@end

NS_ASSUME_NONNULL_END
