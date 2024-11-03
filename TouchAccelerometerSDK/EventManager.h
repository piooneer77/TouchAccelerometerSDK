//
//  EventManager.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import <TouchAccelerometerSDK/TouchEventServiceProtocol.h>
#import <TouchAccelerometerSDK/AccelerometerServiceProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventManager : NSObject
+ (instancetype)sharedInstance;
- (void)startCollection;
- (void)stopCollection;
- (NSArray<NSDictionary *> *)retrieveCollectedData;
@end

NS_ASSUME_NONNULL_END


