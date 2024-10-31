//
//  TouchEventService.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import <Foundation/Foundation.h>
#import "TouchEventServiceProtocol.h"

@interface TouchEventService : NSObject <TouchEventServiceProtocol>
- (void)startTracking;
- (void)stopTracking;
@end
