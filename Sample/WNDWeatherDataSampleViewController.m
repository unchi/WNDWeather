//
//  WNDWeatherDataSampleViewController.m
//  RevTranslator
//
//  Created by unchi on 2014/06/05.
//  Copyright (c) 2014年 mochico. All rights reserved.
//

#import "WNDWeatherDataSampleViewController.h"

#import "WNDWeatherData.h"


@implementation WNDWeatherDataSampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    WNDWeatherData* w = [WNDWeatherData new];
    w.language = WNDWeatherLanguageJapanese;
    
    NSString* query = @"37.8,-122.4";
    WNDWeatherDataFeature feature = WNDWeatherDataFeatureHourly | WNDWeatherDataFeatureAlerts;

    [w request:feature query:query params:@{} handler:^(NSDictionary* data, NSHTTPURLResponse *operation, NSError *error) {
        
        if (error) return;
        
        NSArray* hf = data[@"hourly_forecast"];
        
        if ([hf isEqual:[NSNull null]]) return;
        
        NSDictionary* r = hf.firstObject;
        
        if (r == nil) return;
        
        NSString* pop = r[@"pop"];
        
        NSLog (@"%@", pop);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
