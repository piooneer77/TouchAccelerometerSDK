//
//  TouchEventStoring.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import "TouchEvent.h"

@protocol TouchEventStoring <NSObject>
- (void)storeEvent:(TouchEvent *)event;
- (NSArray<TouchEvent *> *)retrieveEvents;
- (void)clearEvents;
@end
