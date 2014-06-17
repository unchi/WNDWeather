//
//  WNDWeatherMapFeatureDefine.h
//
//  Created by unchi on 2014/06/04.
//  Copyright (c) 2014年 unchi. All rights reserved.
//

#if defined __WND_WEATHER_DATA_FEATURE_ENUM__
#define DEFINE_FEATURE(index, name, value)      WNDWeatherDataFeature##name = (1 << index),
#elif defined __WND_WEATHER_DATA_FEATURE_CASE__
#define DEFINE_FEATURE(index, name, value)      if((flags & (1 << index)) == (1 << index)){[ret appendFormat:@"/%@", value];}
#else
#define DEFINE_FEATURE(index, name, value)
#endif

DEFINE_FEATURE(0, Alerts, @"alerts")
DEFINE_FEATURE(1, Almanac, @"almanac")
DEFINE_FEATURE(2, Astronomy, @"astronomy")
DEFINE_FEATURE(3, Conditions, @"conditions")
DEFINE_FEATURE(4, Currenthurricane, @"currenthurricane")
DEFINE_FEATURE(5, Forecast, @"forecast")
DEFINE_FEATURE(6, Forecast10day, @"forecast10day")
DEFINE_FEATURE(7, Geolookup, @"geolookup")
DEFINE_FEATURE(8, History, @"history")
DEFINE_FEATURE(9, Hourly, @"hourly")
DEFINE_FEATURE(10, Hourly10day, @"hourly10day")
DEFINE_FEATURE(11, Planner, @"planner")
DEFINE_FEATURE(12, Rawtide, @"rawtide")
DEFINE_FEATURE(13, Tide, @"tide")
DEFINE_FEATURE(14, Webcams, @"webcams")
DEFINE_FEATURE(15, Yesterday, @"yesterday")

#undef DEFINE_FEATURE