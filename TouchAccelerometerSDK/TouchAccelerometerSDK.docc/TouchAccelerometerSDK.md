# TouchAccelerometerSDK Integration Guide

## Overview
TouchAccelerometerSDK is a framework for iOS that tracks and collects user interactions through touch events and device accelerometer data. It automatically captures tap locations, swipe gestures, and device motion using UIResponder object method swizzling, organizing them by view controller and timestamp. The SDK handles data storage and periodic API uploads to LexisNexis servers.

## Installation
Add TouchAccelerometerSDK.framework to your project's target dependencies and embed it in your app binary.
I was in the proccess of creating an SPM for it however I think I should deliver no later than today

## Integration

### Objective-C with AppDelegate
```objc
// AppDelegate.h
#import <UIKit/UIKit.h>
#import <TouchAccelerometerSDK/TouchAccelerometerSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

// AppDelegate.m
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    EventManager *manager = [EventManager sharedInstance];
    [manager startCollection];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.eventManager stopCollection];
}
```

### Swift with AppDelegate
```swift
// Add to your bridging header:
#import <TouchAccelerometerSDK/TouchAccelerometerSDK.h>

// AppDelegate.swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let manager = EventManager.sharedInstance()
        manager.startCollection()
        return true
    }
}
```

### SwiftUI
```swift
// Add to your bridging header:
#import <TouchAccelerometerSDK/TouchAccelerometerSDK.h>

// App.swift
import SwiftUI

@main
struct YourApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// AppDelegate.swift
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let manager = EventManager.sharedInstance()
        manager.startCollection()
        return true
    }
}
```

## Key Features
- Automatic touch event tracking (taps and swipes)
- Device motion/accelerometer data collection
- Automatic data batching and upload
- View controller context awareness
- Persistent storage with automatic cleanup

## Data Collection States
The SDK supports three collection states:
- `EventCollectionStateIdle`: Not collecting data
- `EventCollectionStateCollecting`: Actively collecting data
- `EventCollectionStateError`: Error occurred during collection

## Event Types
- Touch Events: Captures tap locations and swipe gestures
- Accelerometer Events: Records device motion on X, Y, and Z axes
