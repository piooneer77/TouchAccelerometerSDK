//
//  AccelerometerEventStoring.h
//
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import <TouchAccelerometerSDK/AccelerometerEvent.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AccelerometerEventStoring <NSObject>
- (void)storeEvent:(AccelerometerEvent *)event;
- (NSArray<AccelerometerEvent *> *)retrieveEvents;
- (void)clearEvents;
@end

NS_ASSUME_NONNULL_END
