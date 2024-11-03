//
//  AccelerometerService.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import "AccelerometerServiceProtocol.h"
#import "AccelerometerEventStoring.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccelerometerService : NSObject <AccelerometerServiceProtocol>
- (instancetype)init;
- (instancetype)initWithStorage:(id<AccelerometerEventStoring>)storage;
@end

NS_ASSUME_NONNULL_END
