//
//  TouchEventFileStorage.h
//
//
//  Created by Halawany on 03.11.24.
//

#import <Foundation/Foundation.h>
#import "TouchEventStoring.h"

NS_ASSUME_NONNULL_BEGIN

@interface TouchEventFileStorage : NSObject <TouchEventStoring>
- (instancetype)initWithFilename:(NSString *)filename;
@end

NS_ASSUME_NONNULL_END
