//
//  TouchEventService.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import "TouchEventServiceProtocol.h"
#import "WindowManaging.h"
#import "TouchEventIntercepting.h"
#import "TouchEventStoring.h"

@interface TouchEventService : NSObject <TouchEventServiceProtocol>
- (instancetype)initWithWindowManager:(id<WindowManaging>)windowManager
                     eventInterceptor:(id<TouchEventIntercepting>)interceptor
                              storage:(id<TouchEventStoring>)storage;
@end
