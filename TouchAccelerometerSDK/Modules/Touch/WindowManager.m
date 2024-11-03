//
//  WindowManager.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import "WindowManager.h"

@interface WindowManager ()
@property (nonatomic, strong) NSHashTable *observedWindows;
@property (nonatomic, copy) void(^windowCallback)(UIWindow *window);
@end

@implementation WindowManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _observedWindows = [NSHashTable weakObjectsHashTable];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(windowDidBecomeKey:)
                                                     name:UIWindowDidBecomeKeyNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerCallback:(void(^)(UIWindow *window))callback {
    self.windowCallback = callback;
}

- (void)windowDidBecomeKey:(NSNotification *)notification {
    UIWindow *window = notification.object;
    if (![self.observedWindows containsObject:window]) {
        [self.observedWindows addObject:window];
        if (self.windowCallback) {
            self.windowCallback(window);
        }
    }
}

- (void)startObservingWindows {
    if (@available(iOS 15.0, *)) {
        NSSet<UIScene *> *scenes = UIApplication.sharedApplication.connectedScenes;
        for (UIScene *scene in scenes) {
            if ([scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                for (UIWindow *window in windowScene.windows) {
                    if (![self.observedWindows containsObject:window]) {
                        [self.observedWindows addObject:window];
                        if (self.windowCallback) {
                            self.windowCallback(window);
                        }
                    }
                }
            }
        }
    } else {
        for (UIWindow *window in UIApplication.sharedApplication.windows) {
            if (![self.observedWindows containsObject:window]) {
                [self.observedWindows addObject:window];
                if (self.windowCallback) {
                    self.windowCallback(window);
                }
            }
        }
    }
}

- (void)stopObservingWindows {
    [self.observedWindows removeAllObjects];
}

@end
