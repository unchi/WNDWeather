//
//  WNDWeather.m
//
//  Created by unchi on 2014/06/04.
//  Copyright (c) 2014年 unchi. All rights reserved.
//

#import "WNDWeatherData.h"
#import "WNDApiRequest.h"


@implementation WNDWeatherData

static NSString* const SampleApiKey = @"c9cda7f7c2000a4f";
static NSString* const BaseUrl = @"http://api.wunderground.com/api/";


#define COMPILE_ASSERT(a)   {char b[a?1:0];(void*)b;}
#define NELEMS(a)   (sizeof(a)/sizeof(*a))


- (instancetype) init {
    self = [super init];
    if (!self) return self;

    _apiKey = SampleApiKey;

    _language = WNDWeatherLanguageJapanese;
    _usePersonalWeatherStations = false;
    _useBestForecast = false;

    return self;
}

- (void)request:(WNDWeatherDataFeature)features
          query:(NSString*)query
         params:(NSDictionary*)params
        handler:(WNDWeatherDataHandler)handler {
    
    NSString* const langText = [self.class WND_stringFromLang:_language];
    NSString* const featuresText = [self.class WND_stringFromFeatures:features];
    
    NSDictionary* const settings = @{
                                     @"lang": langText,
                                     @"pws": _usePersonalWeatherStations ? @"1" : @"0",
                                     @"bestfct": _useBestForecast ? @"1" : @"0",
                                     };

    NSString* const settingText = [self.class WND_stringFromMap: settings];
    
    NSString* const url = [NSString stringWithFormat:@"%@%@%@%@/q/%@.json",
                           BaseUrl,
                           _apiKey,
                           featuresText,
                           settingText,
                           query];
    
    WNDApiRequest* api = [WNDApiRequest new];
    
    [api get: url params:params completionHandler:^(NSDictionary* data, NSHTTPURLResponse *response, NSError *error) {
        handler(data, response, error);
    }];
}

+ (WNDWeatherCurrentConditionPhraseSummary)currentConditionPhraseFromString:(NSString*)whether {
    
    if (whether == nil) return WNDWeatherCurrentConditionPhraseSummaryUnknown;
    
#include "WNDWeatherCurrentConditionPhrasesDefine.h"
    
    const size_t phrasNum = NELEMS(WNDWeatherCurrentConditionPhrases);
    const size_t indexNum = NELEMS(WNDWeatherCurrentConditionPhraseSummaryIndexs);


    COMPILE_ASSERT(phrasNum == indexNum);
    

    for (size_t i = 0; i < phrasNum; ++i) {
        
        NSString* const pattern = WNDWeatherCurrentConditionPhrases[i];
        
        NSRegularExpression* const regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
        NSTextCheckingResult* const match = [regex firstMatchInString:whether options:0 range:NSMakeRange(0, whether.length)];
        
        if(match.numberOfRanges) {
            return WNDWeatherCurrentConditionPhraseSummaryIndexs[i];
        }
        
    }
    
    return WNDWeatherCurrentConditionPhraseSummaryUnknown;
}

+ (NSString*) WND_stringFromLang: (WNDWeatherDataLanguage)lang {
#define __WND_WEATHER_LANG_CASE__
    switch (lang) {
#include "WNDWeatherLanguageDefine.h"
    }
#undef __WND_WEATHER_LANG_CASE__
    assert(!"program error! invalid WNDWeatherLanguage.");
    return @"";
}

+ (NSString*) WND_stringFromMap: (NSDictionary*)datas {
    
    NSMutableString* ret = [NSMutableString new];
    
    for (NSString* key in datas) {
        [ret appendFormat:@"/%@:%@", key, datas[key]];
    }
    
    return ret;
}

+ (NSString*) WND_stringFromFeatures: (WNDWeatherDataFeature)flags {
    NSMutableString* ret = [NSMutableString new];
#define __WND_WEATHER_DATA_FEATURE_CASE__
#include "WNDWeatherDataFeatureDefine.h"
#undef __WND_WEATHER_DATA_FEATURE_CASE__
    return ret;
}

@end

#undef NELEMS
#undef COMPILE_ASSERT
