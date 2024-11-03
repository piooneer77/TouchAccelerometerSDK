//
//  AccelerometerFileStorage.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import "AccelerometerFileStorage.h"
#import "AccelerometerEvent.h"
#import <CoreMotion/CoreMotion.h>

@interface AccelerometerFileStorage ()
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSMutableArray<AccelerometerEvent *> *cachedEvents;
@property (nonatomic, strong) dispatch_queue_t fileQueue;
@end

@implementation AccelerometerFileStorage

- (instancetype)init {
    return [self initWithFilename:@"accelerometer_events.csv"];
}

- (instancetype)initWithFilename:(NSString *)filename {
    self = [super init];
    if (self) {
        NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _filePath = [documentsPath stringByAppendingPathComponent:filename];
        _cachedEvents = [NSMutableArray array];
        _fileQueue = dispatch_queue_create("com.accelerometersdk.filestorage", DISPATCH_QUEUE_SERIAL);
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:_filePath]) {
            NSString *header = @"timestamp,viewIdentifier,acceleration_x,acceleration_y,acceleration_z\n";
            [header writeToFile:_filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        
        [self loadEventsFromFile];
    }
    return self;
}

- (void)loadEventsFromFile {
    dispatch_async(self.fileQueue, ^{
        NSString *fileContent = [NSString stringWithContentsOfFile:self.filePath
                                                          encoding:NSUTF8StringEncoding
                                                             error:nil];
        if (!fileContent) return;
        
        NSArray<NSString *> *lines = [fileContent componentsSeparatedByString:@"\n"];
        if (lines.count <= 1) return;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        
        for (NSInteger i = 1; i < lines.count; i++) {
            NSString *line = lines[i];
            if (line.length == 0) continue;
            
            NSArray<NSString *> *components = [line componentsSeparatedByString:@","];
            if (components.count < 5) continue;
            
            NSDate *timestamp = [dateFormatter dateFromString:components[0]];
            NSString *viewIdentifier = components[1];
            
            CMAcceleration acceleration;
            acceleration.x = [components[2] doubleValue];
            acceleration.y = [components[3] doubleValue];
            acceleration.z = [components[4] doubleValue];
            
            AccelerometerEvent *event = [[AccelerometerEvent alloc] initWithTimestamp:timestamp
                                                                       viewIdentifier:viewIdentifier
                                                                         acceleration:acceleration];
            [self.cachedEvents addObject:event];
        }
    });
}

- (void)storeEvent:(AccelerometerEvent *)event {
    if (!event) return;
    
    dispatch_async(self.fileQueue, ^{
        [self.cachedEvents addObject:event];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        
        NSString *csvLine = [NSString stringWithFormat:@"%@,%@,%.6f,%.6f,%.6f\n",
                             [dateFormatter stringFromDate:event.timestamp],
                             event.viewIdentifier,
                             event.acceleration.x,
                             event.acceleration.y,
                             event.acceleration.z];
        
        if (csvLine) {
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.filePath];
            [fileHandle seekToEndOfFile];
            [fileHandle writeData:[csvLine dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle closeFile];
        }
    });
}

- (NSArray<AccelerometerEvent *> *)retrieveEvents {
    __block NSArray *events;
    dispatch_sync(self.fileQueue, ^{
        events = [self.cachedEvents copy];
    });
    return events;
}

- (void)clearEvents {
    dispatch_async(self.fileQueue, ^{
        [self.cachedEvents removeAllObjects];
        
        NSString *header = @"timestamp,viewIdentifier,acceleration_x,acceleration_y,acceleration_z\n";
        [header writeToFile:self.filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    });
}

@end
