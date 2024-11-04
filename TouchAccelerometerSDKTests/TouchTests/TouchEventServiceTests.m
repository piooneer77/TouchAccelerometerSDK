//
//  TouchEventServiceTests.m
//  TouchAccelerometerSDKTests
//
//  Created by Halawany on 04.11.24.
//

#import "TouchEventServiceTests.h"

@implementation TouchEventServiceTests

- (void)setUp {
    [super setUp];
    
    self.mockWindowManager = [[MockWindowManager alloc] init];
    self.mockEventInterceptor = [[MockTouchEventInterceptor alloc] init];
    self.mockStorage = [[MockTouchEventStorage alloc] init];
    self.mockAPIClient = [[MockAPIClient alloc] init];
    
    self.touchEventService = [[TouchEventService alloc] initWithWindowManager:self.mockWindowManager
                                                            eventInterceptor:self.mockEventInterceptor
                                                                   storage:self.mockStorage
                                                                 apiClient:self.mockAPIClient];
}

- (void)tearDown {
    self.touchEventService = nil;
    self.mockWindowManager = nil;
    self.mockEventInterceptor = nil;
    self.mockStorage = nil;
    self.mockAPIClient = nil;
    [super tearDown];
}

- (void)testTouchEventCollectionAndStorage {
    // Given
    UIWindow *testWindow = [[UIWindow alloc] init];
    TouchEvent *testEvent = [TouchEvent tapEventWithTimestamp:[NSDate date]
                                              viewIdentifier:@"TestViewController"
                                                    location:CGPointMake(100, 100)];
    
    // When
    [self.touchEventService startTouchEventCollection];
    
    // Simulate window callback
    self.mockWindowManager.windowCallback(testWindow);
    
    // Simulate touch event
    self.mockEventInterceptor.eventCallback(testEvent);
    
    // Then
    XCTAssertTrue(self.mockWindowManager.isObserving, @"Window manager should be observing");
    XCTAssertTrue([self.mockEventInterceptor.interceptedWindows containsObject:testWindow], @"Window should be intercepted");
    XCTAssertEqual(self.mockStorage.storedEvents.count, 1, @"One event should be stored");
    XCTAssertEqualObjects(self.mockStorage.storedEvents.firstObject, testEvent, @"Stored event should match test event");
}

@end
