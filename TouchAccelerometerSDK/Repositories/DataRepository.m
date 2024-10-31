//
//  DataRepository.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 31.10.24.
//

#import "DataRepository.h"

@implementation DataRepository {
    NSMutableArray<NSDictionary *> *eventData;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        eventData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)storeEvent:(NSDictionary *)event {
    @synchronized (self) {
        [eventData addObject:event];
    }
}

- (NSArray<NSDictionary *> *)fetchAllEventsSortedByTimestamp {
    return [eventData sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *a, NSDictionary *b) {
        NSDate *first = a[@"timestamp"];
        NSDate *second = b[@"timestamp"];
        return [first compare:second];
    }];
}

@end

