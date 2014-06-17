//
//  WNDApiRequest.m
//
//  Created by unchi on 2014/06/04.
//  Copyright (c) 2014年 unchi. All rights reserved.
//

#import "WNDApiRequest.h"

#import <AFNetworking.h>


@implementation WNDApiRequest

- (id) init {
    if (self = [super init]) {
        // do nothing
        
        _timeoutInterval = 20;
    }
    return self;
}

- (void)        get:(NSString*)url
  completionHandler:(WNDApiHandler)func {
    
    [self get: url params:@{} headers:@{} completionHandler:func];
}

- (void)        get:(NSString*)url
             params:(NSDictionary*)params
  completionHandler:(WNDApiHandler)func {
    
    [self get: url params:params headers:@{} completionHandler:func];
}

- (void)        get:(NSString*)url
             params:(NSDictionary*)params
            headers:(NSDictionary*)headers
  completionHandler:(WNDApiHandler)func {
    
    NSLog (@"%@", url);
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    AFHTTPRequestSerializer* request = [AFHTTPRequestSerializer serializer];
    
    for (NSString* key in headers) {
        NSString* val = [headers objectForKey: key];
        [request setValue: val forHTTPHeaderField: key];
    }
    
    request.timeoutInterval = _timeoutInterval;
    
    manager.requestSerializer = request;
    
    NSArray* responseSerializers = @[
                                     [AFImageResponseSerializer serializer],
                                     [AFJSONResponseSerializer serializer],
                                ];
    AFCompoundResponseSerializer* responseSerializer =
    [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:responseSerializers];
    
    manager.responseSerializer = responseSerializer;
    
    
    [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        func(responseObject, (NSHTTPURLResponse*)[task response], nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        func(nil, (NSHTTPURLResponse*)[task response], error);
    }];
    
    [manager operationQueue];
    
#else
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestSerializer* request = [AFHTTPRequestSerializer serializer];
    
    for (NSString* key in headers) {
        NSString* val = [headers objectForKey: key];
        [request setValue: val forHTTPHeaderField: key];
    }
    
    request.timeoutInterval = _timeoutInterval;
    
    manager.requestSerializer = request;
    
    NSArray* responseSerializers = @[
                                     [AFImageResponseSerializer serializer],
                                     [AFJSONResponseSerializer serializer],
                                ];
    AFCompoundResponseSerializer* responseSerializer =
    [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:responseSerializers];
    
    manager.responseSerializer = responseSerializer;

    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        func(responseObject, operation.response, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        func(nil, operation.response, error);
    }];
    
    [manager operationQueue];
#endif
}

@end
