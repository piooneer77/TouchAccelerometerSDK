//
//  TouchEventServiceTests.h
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 04.11.24.
//

#import <XCTest/XCTest.h>
#import "TouchEventService.h"
#import "MockWindowManager.h"
#import "MockTouchEventInterceptor.h"
#import "MockTouchEventStorage.h"
#import "MockAPIClient.h"

@interface TouchEventServiceTests : XCTestCase
@property (nonatomic, strong) TouchEventService *touchEventService;
@property (nonatomic, strong) MockWindowManager *mockWindowManager;
@property (nonatomic, strong) MockTouchEventInterceptor *mockEventInterceptor;
@property (nonatomic, strong) MockTouchEventStorage *mockStorage;
@property (nonatomic, strong) MockAPIClient *mockAPIClient;
@end
