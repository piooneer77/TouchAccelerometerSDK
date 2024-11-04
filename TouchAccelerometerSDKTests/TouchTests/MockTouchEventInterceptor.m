//
//  MockTouchEventInterceptor.m
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 04.11.24.
//

#import "MockTouchEventInterceptor.h"

@implementation MockTouchEventInterceptor

- (instancetype)init {
    self = [super init];
    if (self) {
        _interceptedWindows = [NSMutableArray array];
    }
    return self;
}

- (void)interceptTouchesForWindow:(UIWindow *)window {
    [self.interceptedWindows addObject:window];
}

- (void)stopInterceptingForWindow:(UIWindow *)window {
    [self.interceptedWindows removeObject:window];
}

- (void)registerCallback:(void(^)(TouchEvent *event))callback {
    self.eventCallback = callback;
}

@end
