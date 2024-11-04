//
//  APIClient.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 04.11.24.
//

#import <Foundation/Foundation.h>
#import "APIClientProtocol.h"
#import "NetworkService.h"

@interface APIClient : NSObject <APIClientProtocol>
- (instancetype)initWithNetworkService:(NetworkService *)networkService;
@end
