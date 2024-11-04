# TouchAccelerometerSDK

Track and analyze touch events and device accelerometer data in your iOS applications.

## Overview

TouchAccelerometerSDK provides a solution for capturing user interactions through touch events and device movements. The SDK automatically collects, processes, and sends this data to your specified endpoint for analysis.

## Integration

### Installation

1. Add the TouchAccelerometerSDK framework to your Xcode project
2. Import the framework in your source files:
```swift
import TouchAccelerometerSDK
```

### Basic Usage

Start collecting events by initializing the EventManager:

```swift
let eventManager = EventManager.sharedInstance()
eventManager.startCollection()
```

Stop collection when needed:

```swift
eventManager.stopCollection()
```

Retrieve collected data:

```swift
let touchEvents = eventManager.retrieveTouchEvents()
let accelerometerEvents = eventManager.retrieveAccelerometerEvents()
```

## Architecture

The SDK follows a modular architecture with these key components:

- **EventManager**: Central coordinator that manages the collection of both touch and accelerometer events
- **TouchEventService**: Handles touch event collection and processing
- **AccelerometerService**: Manages accelerometer data collection
- **Storage Layer**: Persists events using file-based storage
- **Network Layer**: Handles data transmission to the server
- **Event Models**: 
  - `TouchEvent`: Captures tap and swipe interactions
  - `AccelerometerEvent`: Records device movement data

### Key Features

- Automatic touch event interception
- Real-time accelerometer data collection
- Persistent storage of events
- Automatic batch uploading
- Error handling and retry logic
- Thread-safe operations

## Error Handling

The SDK provides error states through the `EventCollectionState` enum:
- `.idle`: Collection is not active
- `.collecting`: Actively collecting data
- `.error`: An error has occurred

Check the collection state and last error:

```swift
if eventManager.collectionState == .error {
    let error = eventManager.lastError
    // Handle error
}
```
