//
//  TouchEventStorage.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import "TouchEventStorage.h"

@interface TouchEventStorage ()
@property (nonatomic, strong) NSMutableArray<TouchEvent *> *events;
@property (nonatomic, strong) dispatch_queue_t storageQueue;
@end

@implementation TouchEventStorage

- (instancetype)init {
    self = [super init];
    if (self) {
        _events = [NSMutableArray array];
        _storageQueue = dispatch_queue_create("com.toucheventsdk.storage", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)storeEvent:(TouchEvent *)event {
    dispatch_async(self.storageQueue, ^{
        [self.events addObject:event];
    });
}

- (NSArray<TouchEvent *> *)retrieveEvents {
    __block NSArray *eventsCopy;
    dispatch_sync(self.storageQueue, ^{
        eventsCopy = [self.events copy];
    });
    return eventsCopy;
}

- (void)clearEvents {
    dispatch_async(self.storageQueue, ^{
        [self.events removeAllObjects];
    });
}

@end
