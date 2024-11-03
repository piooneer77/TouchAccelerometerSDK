//
//  AccelerometerService.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import "AccelerometerServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const TouchEventServiceAssociatedKey;

@interface AccelerometerService : NSObject <AccelerometerServiceProtocol>
- (instancetype)init;
- (void)startAccelerometerCollection;
- (void)stopAccelerometerCollection;
- (NSArray<AccelerometerEvent *> *)retrieveAccelerometerData;
@end

NS_ASSUME_NONNULL_END
