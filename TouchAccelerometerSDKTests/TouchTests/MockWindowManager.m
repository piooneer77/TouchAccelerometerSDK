//
//  MockWindowManager.m
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 04.11.24.
//

#import "MockWindowManager.h"

@implementation MockWindowManager

- (void)startObservingWindows {
    self.isObserving = YES;
}

- (void)stopObservingWindows {
    self.isObserving = NO;
}

- (void)registerCallback:(void(^)(UIWindow *window))callback {
    self.windowCallback = callback;
}

@end
