//
//  WNDWeatherMap.h
//
//  Created by unchi on 2014/06/04.
//  Copyright (c) 2014年 unchi. All rights reserved.
//

#import <Foundation/Foundation.h>



@class NSHTTPURLResponse;

@interface WNDWeatherMap: NSObject

typedef NS_OPTIONS(int, WNDWeatherMapFeature) {
    WNDWeatherMapFeatureRadar = 1 << 0,
    WNDWeatherMapFeatureSatellite = 1 << 1,
};

typedef NS_ENUM(int, WNDWeatherMapFormat) {
    WNDWeatherMapFormatPng,
    WNDWeatherMapFormatGif,
};


@property NSString* apiKey;
@property WNDWeatherMapFormat format;

typedef void (^WNDWeatherMapHandler)(id data, NSHTTPURLResponse* operation, NSError* error);

/** 画像取得
 * @param[in] features
 * @param[in] animated
 * @param[in] query
 * @param[in] params
 * @param[out] handler レスポンスコールバック
 * @note http://www.wunderground.com/weather/api/d/docs?d=data/index&MR=1
 */
- (void)request:(WNDWeatherMapFeature)features animated:(bool)animated query:(NSString*)query params:(NSDictionary*)params handler:(WNDWeatherMapHandler)handler;


@end
