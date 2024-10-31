//
//  EventManagerTests.m
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 31.10.24.
//

#import <XCTest/XCTest.h>
#import "EventManager.h"
#import "MockTouchEventService.h"
#import "MockAccelerometerService.h"

@interface EventManagerTests : XCTestCase
@property (nonatomic, strong) EventManager *eventManager;
@end

@implementation EventManagerTests

- (void)setUp {
    [super setUp];
    MockTouchEventService *mockTouchService = [[MockTouchEventService alloc] init];
    MockAccelerometerService *mockAccelerometerService = [[MockAccelerometerService alloc] init];
    self.eventManager = [[EventManager alloc] initWithTouchService:mockTouchService accelerometerService:mockAccelerometerService];
}

- (void)testStartCollection {
    [self.eventManager startCollection];
    // Assertions or verifications can be made here.
}

@end
