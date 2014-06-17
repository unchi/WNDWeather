//
//  WNDWeather.m
//
//  Created by unchi on 2014/06/04.
//  Copyright (c) 2014年 unchi. All rights reserved.
//

#import "WNDWeatherMap.h"
#import "WNDApiRequest.h"


@implementation WNDWeatherMap

static NSString* const SampleApiKey = @"c9cda7f7c2000a4f";
static NSString* const BaseUrl = @"http://api.wunderground.com/api/";


- (instancetype) init {
    self = [super init];
    if (!self) return self;

    _apiKey = SampleApiKey;

    return self;
}

- (void)request:(WNDWeatherMapFeature)features
       animated:(bool)animated
          query:(NSString*)query
         params:(NSDictionary*)params
        handler:(WNDWeatherMapHandler)handler {

    NSString* const featuresText = [self.class WND_stringFromMapFeatures:features animated:animated];
    NSString* const formatText = [self.class WND_stringFromMapFormat: _format];

    NSString* const url = [NSString stringWithFormat:@"%@%@%@/q/%@.%@",
                           BaseUrl,
                           _apiKey,
                           featuresText,
                           query,
                           formatText];

    WNDApiRequest* api = [WNDApiRequest new];

    [api get: url params:params completionHandler:^(id data, NSHTTPURLResponse *response, NSError *error) {
        handler(data, response, error);
    }];
}

+ (NSString*) WND_stringFromMapFormat: (WNDWeatherMapFormat)format {
    switch (format) {
        case WNDWeatherMapFormatGif: return @"gif";
        case WNDWeatherMapFormatPng: return @"png";
    }
    return @"gif";
}

+ (NSString*) WND_stringFromMapFeatures: (WNDWeatherMapFeature)flags animated:(bool)animated {
    NSMutableString* ret = [NSMutableString new];

    if (animated) {
        if((flags & WNDWeatherMapFeatureRadar) == WNDWeatherMapFeatureRadar) [ret appendString:@"/animatedradar"];
        if((flags & WNDWeatherMapFeatureSatellite) == WNDWeatherMapFeatureSatellite) [ret appendString:@"/animatedsatellite"];
    } else {
        if((flags & WNDWeatherMapFeatureRadar) == WNDWeatherMapFeatureRadar) [ret appendString:@"/radar"];
        if((flags & WNDWeatherMapFeatureSatellite) == WNDWeatherMapFeatureSatellite) [ret appendString:@"/satellite"];
    }
    return ret;
}

@end
