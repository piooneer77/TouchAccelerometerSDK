//
//  TouchEventService.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import "TouchEventService.h"
#import "WindowManager.h"
#import "TouchEventInterceptor.h"
#import "TouchEventFileStorage.h"

@interface TouchEventService ()
@property (nonatomic, strong) id<WindowManaging> windowManager;
@property (nonatomic, strong) id<TouchEventIntercepting> eventInterceptor;
@property (nonatomic, strong) id<TouchEventStoring> storage;
@property (nonatomic, assign) BOOL isCollecting;
@end

@implementation TouchEventService

- (instancetype)init {
    return [self initWithWindowManager:[[WindowManager alloc] init]
                      eventInterceptor:[[TouchEventInterceptor alloc] init]
                               storage:[[TouchEventFileStorage alloc] initWithFilename:@"touch_events.csv"]];
}

- (instancetype)initWithWindowManager:(id<WindowManaging>)windowManager
                     eventInterceptor:(id<TouchEventIntercepting>)interceptor
                              storage:(id<TouchEventStoring>)storage {
    self = [super init];
    if (self) {
        _windowManager = windowManager;
        _eventInterceptor = interceptor;
        _storage = storage;
        _isCollecting = NO;
        
        __weak typeof(self) weakSelf = self;
        [_windowManager registerCallback:^(UIWindow *window) {
            [weakSelf.eventInterceptor interceptTouchesForWindow:window];
        }];
        
        [_eventInterceptor registerCallback:^(TouchEvent *event) {
            [weakSelf.storage storeEvent:event];
        }];
    }
    return self;
}

- (void)startTouchEventCollection {
    if (self.isCollecting) return;
    self.isCollecting = YES;
    [self.windowManager startObservingWindows];
}

- (void)stopTouchEventCollection {
    if (!self.isCollecting) return;
    self.isCollecting = NO;
    [self.windowManager stopObservingWindows];
}

- (NSArray<TouchEvent *> *)retrieveTouchEvents {
    return [self.storage retrieveEvents];
}

@end
