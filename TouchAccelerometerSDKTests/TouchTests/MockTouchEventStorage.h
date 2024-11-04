//
//  MockTouchEventStorage.h
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 04.11.24.
//

#import <Foundation/Foundation.h>
#import "TouchEventStoring.h"

@interface MockTouchEventStorage : NSObject <TouchEventStoring>
@property (nonatomic, strong) NSMutableArray<TouchEvent *> *storedEvents;
@end
