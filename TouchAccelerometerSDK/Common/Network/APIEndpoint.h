//
//  APIEndpoint.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import "TouchEvent.h"
#import "AccelerometerEvent.h"

typedef NS_ENUM(NSInteger, HTTPMethod) {
    HTTPMethodGET,
    HTTPMethodPOST
};

typedef NS_ENUM(NSInteger, NetworkError) {
    NetworkErrorInvalidURL,
    NetworkErrorRequestFailed,
    NetworkErrorInvalidResponse,
    NetworkErrorDecodingFailed,
    NetworkErrorHTTPError
};

@interface APIEndpoint : NSObject

@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) HTTPMethod method;
@property (nonatomic, readonly, nullable) NSDictionary<NSString *, NSString *> *headers;
@property (nonatomic, readonly, nullable) NSArray<NSURLQueryItem *> *queryItems;
@property (nonatomic, readonly, nullable) NSDictionary *parameters;

+ (instancetype)sendTouchEvents:(NSArray<TouchEvent *> *)events;
+ (instancetype)sendAccelerometerEvents:(NSArray<AccelerometerEvent *> *)events;

- (nullable NSData *)body:(NSError **)error;

@end
