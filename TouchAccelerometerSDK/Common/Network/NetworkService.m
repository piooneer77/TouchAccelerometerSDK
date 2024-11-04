//
//  NetworkService.m
//  TouchAccelerometerSDK
//
//  Created by Halawany on 03.11.24.
//

#import "NetworkService.h"

@interface NetworkService ()
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, assign) NSInteger maxRetries;
@property (nonatomic, assign) NSTimeInterval delay;
@end

@implementation NetworkService

+ (NetworkService *)shared {
    static NetworkService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initPrivate];
    });
    return sharedInstance;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _maxRetries = 3;
        _delay = 2.0;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 30.0;
        configuration.timeoutIntervalForResource = 30.0;
        
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Use +[NetworkService shared] instead"
                                 userInfo:nil];
}

- (void)requestWithEndpoint:(APIEndpoint *)endpoint
                 completion:(void(^)(id _Nullable response, NSError * _Nullable error))completion {
    NSURLRequest *request = [self createRequestWithEndpoint:endpoint];
    
    [self executeRequest:request
                 attempt:0
              completion:completion];
}

- (void)executeRequest:(NSURLRequest *)request
               attempt:(NSInteger)attempt
            completion:(void(^)(id _Nullable response, NSError * _Nullable error))completion {
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData * _Nullable data,
                                                                     NSURLResponse * _Nullable response,
                                                                     NSError * _Nullable error) {
        if (error) {
            if (attempt < self.maxRetries) {
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                                          (int64_t)(self.delay * pow(2, attempt) * NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    [self executeRequest:request
                                 attempt:attempt + 1
                              completion:completion];
                });
                return;
            }
            
            completion(nil, error);
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!(httpResponse.statusCode >= 200 && httpResponse.statusCode < 300)) {
            NSError *statusError = [NSError errorWithDomain:@"com.yourdomain.app"
                                                       code:httpResponse.statusCode
                                                   userInfo:nil];
            completion(nil, statusError);
            return;
        }
        
        NSError *jsonError;
        id jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                          options:0
                                                            error:&jsonError];
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        
        completion(jsonResponse, nil);
    }];
    
    [task resume];
}

- (NSURLRequest *)createRequestWithEndpoint:(APIEndpoint *)endpoint {
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:endpoint.url
                                               resolvingAgainstBaseURL:NO];
    
    if (endpoint.queryItems) {
        components.queryItems = endpoint.queryItems;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:components.URL];
    request.HTTPMethod = [self stringFromHTTPMethod:endpoint.method];
    
    if (endpoint.headers) {
        [request setAllHTTPHeaderFields:endpoint.headers];
    }
    
    NSError *bodyError;
    NSData *bodyData = [endpoint body:&bodyError];
    if (bodyData) {
        request.HTTPBody = bodyData;
    }
    
    return request;
}

- (NSString *)stringFromHTTPMethod:(HTTPMethod)method {
    switch (method) {
        case HTTPMethodGET:
            return @"GET";
        case HTTPMethodPOST:
            return @"POST";
    }
}

@end
