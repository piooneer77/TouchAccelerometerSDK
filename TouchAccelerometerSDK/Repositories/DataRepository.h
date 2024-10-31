//
//  DataRepository.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataRepository : NSObject
- (void)storeEvent:(NSDictionary *)event;
- (NSArray<NSDictionary *> *)fetchAllEventsSortedByTimestamp;
@end

NS_ASSUME_NONNULL_END
