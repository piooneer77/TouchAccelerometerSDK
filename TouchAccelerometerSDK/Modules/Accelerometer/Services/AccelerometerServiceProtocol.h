//
//  AccelerometerServiceProtocol.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import <TouchAccelerometerSDK/AccelerometerEvent.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AccelerometerServiceProtocol <NSObject>
- (void)startAccelerometerCollection;
- (void)stopAccelerometerCollection;
- (NSArray<AccelerometerEvent *> *)retrieveAccelerometerData;
@end

NS_ASSUME_NONNULL_END
