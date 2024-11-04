//
//  APIClientProtocol.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 04.11.24.
//

#import <Foundation/Foundation.h>
#import "TouchEvent.h"
#import "AccelerometerEvent.h"

@protocol APIClientProtocol <NSObject>
- (void)sendTouchEvents:(NSArray<TouchEvent *> *)events
             completion:(void(^)(BOOL success, NSError * _Nullable error))completion;
- (void)sendAccelerometerEvents:(NSArray<AccelerometerEvent *> *)events
                    completion:(void(^)(BOOL success, NSError * _Nullable error))completion;
@end
