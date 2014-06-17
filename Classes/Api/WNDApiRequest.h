//
//  WNDApiRequest.h
//
//  Created by unchi on 2014/06/04.
//  Copyright (c) 2014年 unchi. All rights reserved.
//

#import <Foundation/Foundation.h>


@class NSURLResponse;

@interface WNDApiRequest : NSObject

typedef void (^WNDApiHandler)(id data, NSHTTPURLResponse* response, NSError* error);

@property NSInteger timeoutInterval;

- (void)        get:(NSString*)url
  completionHandler:(WNDApiHandler)func;

- (void)        get:(NSString*)url
             params:(NSDictionary*)params
  completionHandler:(WNDApiHandler)func;

- (void)        get:(NSString*)url
             params:(NSDictionary*)params
            headers:(NSDictionary*)headers
  completionHandler:(WNDApiHandler)func;

@end
