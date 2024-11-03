//
//  WindowManaging.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol WindowManaging <NSObject>
- (void)startObservingWindows;
- (void)stopObservingWindows;
- (void)registerCallback:(void(^)(UIWindow *window))callback;
@end
