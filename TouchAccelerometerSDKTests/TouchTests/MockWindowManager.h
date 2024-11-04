//
//  MockWindowManager.h
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 04.11.24.
//

#import <Foundation/Foundation.h>
#import "WindowManaging.h"

@interface MockWindowManager : NSObject <WindowManaging>
@property (nonatomic, copy) void(^windowCallback)(UIWindow *window);
@property (nonatomic, assign) BOOL isObserving;
@end
