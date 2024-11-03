//
//  TouchEventFileStorage.m
//
//
//  Created by Halawany on 03.11.24.
//

#import "TouchEventFileStorage.h"
#import "TouchEvent.h"

@interface TouchEventFileStorage ()
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSMutableArray<TouchEvent *> *cachedEvents;
@property (nonatomic, strong) dispatch_queue_t fileQueue;
@end

@implementation TouchEventFileStorage

- (instancetype)init {
    return [self initWithFilename:@"touch_events.csv"];
}

- (instancetype)initWithFilename:(NSString *)filename {
    self = [super init];
    if (self) {
        NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _filePath = [documentsPath stringByAppendingPathComponent:filename];
        _cachedEvents = [NSMutableArray array];
        _fileQueue = dispatch_queue_create("com.toucheventsdk.filestorage", DISPATCH_QUEUE_SERIAL);
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:_filePath]) {
            NSString *header = @"timestamp,viewIdentifier,eventType,location_x,location_y,swipeDirection\n";
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
            if (components.count < 6) continue;
            
            NSDate *timestamp = [dateFormatter dateFromString:components[0]];
            NSString *viewIdentifier = components[1];
            TouchEventType type = [components[2] integerValue];
            CGPoint location = CGPointMake([components[3] floatValue], [components[4] floatValue]);
            UISwipeGestureRecognizerDirection direction = [components[5] integerValue];
            
            TouchEvent *event = [[TouchEvent alloc] initWithTimestamp:timestamp
                                                       viewIdentifier:viewIdentifier
                                                             location:location
                                                                 type:type
                                                       swipeDirection:direction];
            [self.cachedEvents addObject:event];
        }
    });
}

- (void)storeEvent:(TouchEvent *)event {
    if (!event) return;
    
    dispatch_async(self.fileQueue, ^{
        [self.cachedEvents addObject:event];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        
        NSString *csvLine = [NSString stringWithFormat:@"%@,%@,%ld,%.2f,%.2f,%ld\n",
                             [dateFormatter stringFromDate:event.timestamp],
                             event.viewIdentifier,
                             (long)event.type,
                             event.location.x,
                             event.location.y,
                             (long)event.swipeDirection];
        if (csvLine) {
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.filePath];
            [fileHandle seekToEndOfFile];
            [fileHandle writeData:[csvLine dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle closeFile];
        }
    });
}

- (NSArray<TouchEvent *> *)retrieveEvents {
    __block NSArray *events;
    dispatch_sync(self.fileQueue, ^{
        events = [self.cachedEvents copy];
    });
    return events;
}

- (void)clearEvents {
    dispatch_async(self.fileQueue, ^{
        [self.cachedEvents removeAllObjects];
        
        NSString *header = @"timestamp,viewIdentifier,eventType,location_x,location_y,swipeDirection\n";
        [header writeToFile:self.filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    });
}

@end
