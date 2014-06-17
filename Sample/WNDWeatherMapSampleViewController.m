//
//  WNDWeatherMapSampleViewController.m
//  RevTranslator
//
//  Created by unchi on 2014/06/05.
//  Copyright (c) 2014年 mochico. All rights reserved.
//

#import "WNDWeatherMapSampleViewController.h"

#import "WNDWeatherMap.h"


@implementation WNDWeatherMapSampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
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
    WNDWeatherMap* w = [WNDWeatherMap new];
    
    NSString* query = @"MI/Ann_Arbor";
    NSDictionary* params = @{
                             @"num": @"6",
                             @"delay": @"50",
                             @"interval": @"30",
                             };
    WNDWeatherMapFeature feature = WNDWeatherMapFeatureRadar | WNDWeatherMapFeatureSatellite;
    
    [w request:feature animated:true query:query params:params handler:^(id data, NSHTTPURLResponse *operation, NSError *error) {
        
        //
        
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
