//
//  TouchEventIntercepting.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TouchEvent.h"

@protocol TouchEventIntercepting <NSObject>
- (void)interceptTouchesForWindow:(UIWindow *)window;
- (void)stopInterceptingForWindow:(UIWindow *)window;
- (void)registerCallback:(void(^)(TouchEvent *event))callback;
@end
