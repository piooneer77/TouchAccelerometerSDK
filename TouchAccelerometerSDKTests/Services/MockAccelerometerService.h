//
//  MockAccelerometerService.h
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import "AccelerometerServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockAccelerometerService : NSObject <AccelerometerServiceProtocol>
// Optionally add properties to track start/stop calls or simulate data
@property (nonatomic, assign) BOOL isTracking;
@end

NS_ASSUME_NONNULL_END
