//
//  EventManager.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import "TouchEventServiceProtocol.h"
#import "AccelerometerServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventManager : NSObject
- (instancetype)initWithTouchService:(id<TouchEventServiceProtocol>)touchService
                    accelerometerService:(id<AccelerometerServiceProtocol>)accelerometerService;
- (void)startCollection;
- (void)stopCollection;
- (NSArray<NSDictionary *> *)retrieveCollectedData;
@end

NS_ASSUME_NONNULL_END


