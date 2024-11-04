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
#import "APIClientProtocol.h"
#import "APIClient.h"

@interface TouchEventService ()
@property (nonatomic, strong) id<WindowManaging> windowManager;
@property (nonatomic, strong) id<TouchEventIntercepting> eventInterceptor;
@property (nonatomic, strong) id<TouchEventStoring> storage;
@property (nonatomic, strong) id<APIClientProtocol> apiClient;
@property (nonatomic, assign) BOOL isCollecting;
@end

@implementation TouchEventService

- (instancetype)init {
    return [self initWithWindowManager:[[WindowManager alloc] init]
                      eventInterceptor:[[TouchEventInterceptor alloc] init]
                               storage:[[TouchEventFileStorage alloc] initWithFilename:@"touch_events.csv"]
                             apiClient:[[APIClient alloc] initWithNetworkService:[NetworkService shared]]];
}

- (instancetype)initWithWindowManager:(id<WindowManaging>)windowManager
                     eventInterceptor:(id<TouchEventIntercepting>)interceptor
                              storage:(id<TouchEventStoring>)storage
                            apiClient:(id<APIClientProtocol>)apiClient {
    self = [super init];
    if (self) {
        _windowManager = windowManager;
        _eventInterceptor = interceptor;
        _storage = storage;
        _apiClient = apiClient;
        _isCollecting = NO;
        
        [self setupEventHandling];
    }
    return self;
}

- (void)setupEventHandling {
    __weak typeof(self) weakSelf = self;
    
    [self.windowManager registerCallback:^(UIWindow *window) {
        [weakSelf.eventInterceptor interceptTouchesForWindow:window];
    }];
    
    [self.eventInterceptor registerCallback:^(TouchEvent *event) {
        [weakSelf.storage storeEvent:event];
        
        NSArray<TouchEvent *> *events = [weakSelf.storage retrieveEvents];
        if (events.count >= 10) {
            [weakSelf.apiClient sendTouchEvents:events completion:^(BOOL success, NSError *error) {
                if (success) {
                    [weakSelf.storage clearEvents];
                }
            }];
        }
    }];
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
