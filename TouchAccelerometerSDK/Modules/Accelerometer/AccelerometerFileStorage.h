//
//  AccelerometerFileStorage.h
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import "AccelerometerEventStoring.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccelerometerFileStorage : NSObject <AccelerometerEventStoring>
- (instancetype)initWithFilename:(NSString *)filename;
@end

NS_ASSUME_NONNULL_END
