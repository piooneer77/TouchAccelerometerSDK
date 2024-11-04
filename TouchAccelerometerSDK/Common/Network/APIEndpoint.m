//
//  APIEndpoint.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import "APIEndpoint.h"

@interface APIEndpoint ()
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) NSDictionary *pathParameters;
@property (nonatomic, strong) NSDictionary *requestParameters;
@end

@implementation APIEndpoint

+ (instancetype)sendTouchEvents:(NSArray<TouchEvent *> *)events {
    APIEndpoint *endpoint = [[APIEndpoint alloc] init];
    endpoint.path = @"/events/touch";
    endpoint.requestParameters = [self serializeTouchEvents:events];
    return endpoint;
}

+ (instancetype)sendAccelerometerEvents:(NSArray<AccelerometerEvent *> *)events {
    APIEndpoint *endpoint = [[APIEndpoint alloc] init];
    endpoint.path = @"/events/accelerometer";
    endpoint.requestParameters = [self serializeAccelerometerEvents:events];
    return endpoint;
}


+ (NSDictionary *)serializeTouchEvents:(NSArray<TouchEvent *> *)events {
    NSMutableArray *serializedEvents = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    for (TouchEvent *event in events) {
        [serializedEvents addObject:@{
            @"timestamp": [dateFormatter stringFromDate:event.timestamp],
            @"viewIdentifier": event.viewIdentifier,
            @"type": @(event.type),
            @"location": @{
                @"x": @(event.location.x),
                @"y": @(event.location.y)
            },
            @"swipeDirection": @(event.swipeDirection)
        }];
    }
    
    return @{@"events": serializedEvents};
}

+ (NSDictionary *)serializeAccelerometerEvents:(NSArray<AccelerometerEvent *> *)events {
    NSMutableArray *serializedEvents = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    for (AccelerometerEvent *event in events) {
        [serializedEvents addObject:@{
            @"timestamp": [dateFormatter stringFromDate:event.timestamp],
            @"viewIdentifier": event.viewIdentifier,
            @"acceleration": @{
                @"x": @(event.acceleration.x),
                @"y": @(event.acceleration.y),
                @"z": @(event.acceleration.z)
            }
        }];
    }
    
    return @{@"events": serializedEvents};
}

- (NSString *)domain {
    return @"https://www.lexisnexis.com/api";
}

- (NSURL *)url {
    __block NSString *formattedPath = [self.path copy];
    if (self.pathParameters) {
        [self.pathParameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *placeholder = [NSString stringWithFormat:@"%%%@", key];
            formattedPath = [formattedPath stringByReplacingOccurrencesOfString:placeholder
                                                                     withString:[obj description]];
        }];
    }
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self domain], formattedPath]];
}

- (HTTPMethod)method {
    return HTTPMethodPOST;
}

- (NSDictionary<NSString *,NSString *> *)headers {
    return nil;
}

- (NSArray<NSURLQueryItem *> *)queryItems {
    return nil;
}

- (NSDictionary *)parameters {
    return self.requestParameters;
}

- (NSData *)body:(NSError **)error {
    if (self.parameters) {
        return [NSJSONSerialization dataWithJSONObject:self.parameters
                                               options:0
                                                 error:error];
    }
    return nil;
}

@end
