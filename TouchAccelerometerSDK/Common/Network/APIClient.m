//
//  APIClient.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 04.11.24.
//

#import <Foundation/Foundation.h>
#import "APIClient.h"

@interface APIClient ()
@property (nonatomic, strong) NetworkService *networkService;
@end

@implementation APIClient

- (instancetype)initWithNetworkService:(NetworkService *)networkService {
    self = [super init];
    if (self) {
        _networkService = networkService;
    }
    return self;
}

- (void)sendTouchEvents:(NSArray<TouchEvent *> *)events
             completion:(void(^)(BOOL success, NSError * _Nullable error))completion {
    APIEndpoint *endpoint = [APIEndpoint sendTouchEvents:events];
    [self.networkService requestWithEndpoint:endpoint completion:^(id response, NSError *error) {
        completion(error == nil, error);
    }];
}

- (void)sendAccelerometerEvents:(NSArray<AccelerometerEvent *> *)events
                     completion:(void(^)(BOOL success, NSError * _Nullable error))completion {
    APIEndpoint *endpoint = [APIEndpoint sendAccelerometerEvents:events];
    [self.networkService requestWithEndpoint:endpoint completion:^(id response, NSError *error) {
        completion(error == nil, error);
    }];
}

@end
