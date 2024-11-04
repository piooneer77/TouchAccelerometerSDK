//
//  AccelerometerService.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import "AccelerometerServiceProtocol.h"
#import "AccelerometerEventStoring.h"
#import "APIClientProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccelerometerService : NSObject <AccelerometerServiceProtocol>
- (instancetype)init;
- (instancetype)initWithStorage:(id<AccelerometerEventStoring>)storage
                      apiClient:(id<APIClientProtocol>)apiClient;
@property (nonatomic, strong) CMMotionManager *motionManager;
@end

NS_ASSUME_NONNULL_END
