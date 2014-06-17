//
//  WNDWeather.h
//
//  Created by unchi on 2014/06/04.
//  Copyright (c) 2014年 unchi. All rights reserved.
//

#import <Foundation/Foundation.h>



@class NSHTTPURLResponse;

@interface WNDWeatherData : NSObject

#define __WND_WEATHER_LANG_ENUM__
typedef NS_ENUM(int, WNDWeatherDataLanguage) {
#include "WNDWeatherLanguageDefine.h"
};
#undef __WND_WEATHER_LANG_ENUM__


#define __WND_WEATHER_DATA_FEATURE_ENUM__
typedef NS_OPTIONS(int, WNDWeatherDataFeature) {
#include "WNDWeatherDataFeatureDefine.h"
};
#undef __WND_WEATHER_DATA_FEATURE_ENUM__


typedef NS_ENUM(int, WNDWeatherCurrentConditionPhraseSummary) {
    WNDWeatherCurrentConditionPhraseSummaryUnknown = 0,
    WNDWeatherCurrentConditionPhraseSummaryClear = 1,
    WNDWeatherCurrentConditionPhraseSummaryCloud = 2,
    WNDWeatherCurrentConditionPhraseSummaryRain = 3,
    WNDWeatherCurrentConditionPhraseSummarySnow = 4,
    WNDWeatherCurrentConditionPhraseSummaryFog = 5,
    WNDWeatherCurrentConditionPhraseSummarySmoke = 6,
    WNDWeatherCurrentConditionPhraseSummarySand = 7,
    WNDWeatherCurrentConditionPhraseSummaryVolcanicAsh = 8,
    WNDWeatherCurrentConditionPhraseSummaryFunnelCloud = 9,
};


@property NSString* apiKey;
@property WNDWeatherDataLanguage language;
@property bool usePersonalWeatherStations;
@property bool useBestForecast;

typedef void (^WNDWeatherDataHandler)(id data, NSHTTPURLResponse* operation, NSError* error);

/** 情報取得
 * @param[in] features
 * @param[in] query
 * @param[in] params
 * @param[out] handler レスポンスコールバック
 * @note http://www.wunderground.com/weather/api/d/docs?d=data/index&MR=1
 */
- (void)request:(WNDWeatherDataFeature)features query:(NSString*)query params:(NSDictionary*)params handler:(WNDWeatherDataHandler)handler;

/** 概要に変換する
 * @param[in] whether 現在の天気情報文字列
 */
+ (WNDWeatherCurrentConditionPhraseSummary)currentConditionPhraseFromString:(NSString*)whether;

@end
