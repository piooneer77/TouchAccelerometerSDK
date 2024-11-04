//
//  NetworkService.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import "APIEndpoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject
@property (class, readonly, strong) NetworkService *shared;
- (void)requestWithEndpoint:(APIEndpoint *)endpoint
                 completion:(void(^)(id _Nullable response, NSError * _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
