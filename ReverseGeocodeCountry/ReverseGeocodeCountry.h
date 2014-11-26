//
//  ReverseGeocodeCountry.h
//
//  Created by Initlabs on 2/25/14.
//  Copyright (c) 2014 Initlabs. All rights reserved.
//
// This code is distributed under the terms and conditions of the MIT license.


#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

/**
 @brief     A static country reverse geocoding.
 @details   Geocoding is performed offline using data from a provided JSON file.
*/
@interface ReverseGeocodeCountry : NSObject

/**
 @brief     Initializes the instance and unserializes GeoJSON data from provided file.
 @param     fileUrl     Provide a local GeoJSON file URL of country codes matching country boundaries
                        in geometric poligons. The GeoJSON may contain only coordinates of countries you 
                        are interested in.
  @return   The initialized instance on success else nil,
*/
- (instancetype)initWithGeoJSONFileUrl:(NSURL *)fileUrl;

/**
 @brief     Find a matching country code for a provideed coordinate.
 @return    A country code if the coordinate is within country boundaries.
            nil if matching country not found or coordinate is invalid.
*/
- (NSString *)countryCodeForCoordinate:(CLLocationCoordinate2D)coordinate;

@end
