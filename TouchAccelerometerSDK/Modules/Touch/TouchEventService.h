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
#import "APIClientProtocol.h"

@interface TouchEventService : NSObject <TouchEventServiceProtocol>
- (instancetype)initWithWindowManager:(id<WindowManaging>)windowManager
                     eventInterceptor:(id<TouchEventIntercepting>)interceptor
                              storage:(id<TouchEventStoring>)storage
                            apiClient:(id<APIClientProtocol>)apiClient;
@end
