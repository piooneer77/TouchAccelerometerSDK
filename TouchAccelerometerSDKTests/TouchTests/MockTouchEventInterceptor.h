//
//  MockTouchEventInterceptor.h
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 04.11.24.
//

#import <Foundation/Foundation.h>
#import "TouchEventIntercepting.h"

@interface MockTouchEventInterceptor : NSObject <TouchEventIntercepting>
@property (nonatomic, copy) void(^eventCallback)(TouchEvent *event);
@property (nonatomic, strong) NSMutableArray<UIWindow *> *interceptedWindows;
@end
