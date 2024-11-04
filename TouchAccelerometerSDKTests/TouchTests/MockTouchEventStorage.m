//
//  MockTouchEventStorage.m
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 04.11.24.
//

#import "MockTouchEventStorage.h"

@implementation MockTouchEventStorage

- (instancetype)init {
    self = [super init];
    if (self) {
        _storedEvents = [NSMutableArray array];
    }
    return self;
}

- (void)storeEvent:(TouchEvent *)event {
    [self.storedEvents addObject:event];
}

- (NSArray<TouchEvent *> *)retrieveEvents {
    return [self.storedEvents copy];
}

- (void)clearEvents {
    [self.storedEvents removeAllObjects];
}

@end
