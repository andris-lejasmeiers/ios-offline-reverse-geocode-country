//
//  CMViewController.m
//  countrymap
//
//  Created by Initlabs on 2/25/14.
//  Copyright (c) 2014 Initlabs. All rights reserved.
//

#import "CMViewController.h"
#import "ReverseGeocodeCountry.h"

@interface CMViewController () {
    ReverseGeocodeCountry *_geocoder;
}

@end

@implementation CMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    NSURL *countries = [[NSBundle mainBundle] URLForResource:@"ReverseGeocodeCountry" withExtension:@"json"];

    _geocoder = [[ReverseGeocodeCountry alloc] initWithGeoJSONFileUrl:countries];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    // call the ReverseGeocodeCountry mehtod to get country name
    country.text = [_geocoder countryCodeForCoordinate:map.centerCoordinate];
}

@end
