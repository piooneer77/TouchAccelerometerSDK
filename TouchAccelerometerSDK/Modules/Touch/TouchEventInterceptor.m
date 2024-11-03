//
//  TouchEventInterceptor.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import "TouchEventInterceptor.h"
#import <objc/runtime.h>
#import "UIViewController+TopMost.h"
#import "NSString+ViewControllerUtilities.h"
#import "TouchEventFactory.h"

static NSString *const kTouchEventInterceptorKey = @"TouchEventInterceptorKey";

@interface TouchEventInterceptor ()
@property (nonatomic, copy) void(^eventCallback)(TouchEvent *event);
@property (nonatomic, strong) id<TouchEventCreating> eventFactory;
@end

@implementation TouchEventInterceptor

- (instancetype)init {
    return [self initWithEventFactory:[[TouchEventFactory alloc] init]];
}

- (instancetype)initWithEventFactory:(id<TouchEventCreating>)eventFactory {
    self = [super init];
    if (self) {
        _eventFactory = eventFactory;
    }
    return self;
}

- (void)registerCallback:(void(^)(TouchEvent *event))callback {
    self.eventCallback = callback;
}

- (void)interceptTouchesForWindow:(UIWindow *)window {
    [self swizzleWindowSendEvent:window];
}

- (void)stopInterceptingForWindow:(UIWindow *)window {
    objc_setAssociatedObject(window,
                             (__bridge const void *)(kTouchEventInterceptorKey),
                             nil,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)swizzleWindowSendEvent:(UIWindow *)window {
    Class windowClass = [window class];
    SEL originalSelector = @selector(sendEvent:);
    SEL swizzledSelector = @selector(swizzled_sendEvent:);
    
    Method originalMethod = class_getInstanceMethod(windowClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    
    if (!originalMethod || !swizzledMethod) return;
    
    IMP swizzledImplementation = method_getImplementation(swizzledMethod);
    const char *swizzledTypes = method_getTypeEncoding(swizzledMethod);
    
    if (!class_addMethod(windowClass, swizzledSelector, swizzledImplementation, swizzledTypes)) return;
    
    Method newMethod = class_getInstanceMethod(windowClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, newMethod);
    
    objc_setAssociatedObject(window,
                             (__bridge const void *)(kTouchEventInterceptorKey),
                             self,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)swizzled_sendEvent:(UIEvent *)event {
    [self swizzled_sendEvent:event];
    
    TouchEventInterceptor *interceptor = objc_getAssociatedObject(self, (__bridge const void *)(kTouchEventInterceptorKey));
    
    if (interceptor && event.type == UIEventTypeTouches) {
        NSSet *touches = [event allTouches];
        for (UITouch *touch in touches) {
            if (touch.phase == UITouchPhaseBegan ||
                touch.phase == UITouchPhaseMoved ||
                touch.phase == UITouchPhaseEnded) {
                
                UIViewController *topViewController = [UIViewController topMostViewController];
                TouchEvent *touchEvent = [interceptor.eventFactory createEventFromTouch:touch
                                                                                 inView:touch.view
                                                                      forViewController:topViewController];
                
                if (touchEvent && interceptor.eventCallback) {
                    interceptor.eventCallback(touchEvent);
                }
            }
        }
    }
}

- (UISwipeGestureRecognizerDirection)determineSwipeDirection:(CGFloat)deltaX deltaY:(CGFloat)deltaY {
    CGFloat threshold = 50.0;
    
    if (fabs(deltaX) > fabs(deltaY)) {
        if (deltaX > threshold) return UISwipeGestureRecognizerDirectionRight;
        if (deltaX < -threshold) return UISwipeGestureRecognizerDirectionLeft;
    } else {
        if (deltaY > threshold) return UISwipeGestureRecognizerDirectionDown;
        if (deltaY < -threshold) return UISwipeGestureRecognizerDirectionUp;
    }
    
    return 0;
}

@end
