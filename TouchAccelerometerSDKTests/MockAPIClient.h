//
//  MockAPIClient.h
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 04.11.24.
//

#import <Foundation/Foundation.h>
#import "APIClientProtocol.h"

@interface MockAPIClient : NSObject <APIClientProtocol>
@property (nonatomic, strong) NSMutableArray *sentTouchEvents;
@property (nonatomic, strong) NSMutableArray *sentAccelerometerEvents;
@end
