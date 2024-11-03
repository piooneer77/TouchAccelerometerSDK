//
//  TouchEventInterceptor.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import "TouchEventIntercepting.h"
#import "TouchEventCreating.h"

@interface TouchEventInterceptor : NSObject <TouchEventIntercepting>
- (instancetype)initWithEventFactory:(id<TouchEventCreating>)eventFactory;
@end
