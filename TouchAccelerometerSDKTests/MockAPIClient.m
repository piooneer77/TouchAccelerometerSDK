//
//  MockAPIClient.m
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 04.11.24.
//

#import "MockAPIClient.h"

@implementation MockAPIClient

- (instancetype)init {
    self = [super init];
    if (self) {
        _sentTouchEvents = [NSMutableArray array];
        _sentAccelerometerEvents = [NSMutableArray array];
    }
    return self;
}

- (void)sendTouchEvents:(NSArray<TouchEvent *> *)events completion:(void (^)(BOOL, NSError * _Nullable))completion {
    [self.sentTouchEvents addObjectsFromArray:events];
    if (completion) {
        completion(YES, nil);
    }
}

- (void)sendAccelerometerEvents:(NSArray<AccelerometerEvent *> *)events completion:(void (^)(BOOL, NSError * _Nullable))completion {
    [self.sentAccelerometerEvents addObjectsFromArray:events];
    if (completion) {
        completion(YES, nil);
    }
}

@end
