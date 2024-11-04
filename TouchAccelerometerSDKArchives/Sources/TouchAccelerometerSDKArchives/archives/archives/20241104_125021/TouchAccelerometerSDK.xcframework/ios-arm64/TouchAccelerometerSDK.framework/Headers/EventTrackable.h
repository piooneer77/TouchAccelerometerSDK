//
//  EventTrackable.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EventTrackable <NSObject>
@property (nonatomic, readonly, strong) NSDate *timestamp;
@property (nonatomic, readonly, copy) NSString *viewIdentifier;
@end

NS_ASSUME_NONNULL_END
