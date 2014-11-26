//
//  ReverseGeocodeCountry.m
//
//  Created by Initlabs on 2/25/14.
//  Copyright (c) 2014 Initlabs. All rights reserved.
//
// This code is distributed under the terms and conditions of the MIT license. 

#import "ReverseGeocodeCountry.h"


@implementation ReverseGeocodeCountry
{
    NSArray *_countryData;
}

- (instancetype)initWithGeoJSONFileUrl:(NSURL *)fileUrl
{
    NSArray *countryData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:fileUrl]
                                                           options:0
                                                             error:nil];
    if (!countryData)
        return nil;

    if (self = [self init])
    {
        _countryData = countryData;
    }

    return self;
}

/**
 @brief     Checks if a latitude and longitude of a point are contained in a polygon.
 @details   Based on the Jordan curve theorem, for more info:
            http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html
 @param     polygon     Series of the polygon's coordinates.
 @return    YES if the point lies within the polygon, NO otherwise.
*/
- (BOOL)isLatitude:(double)lat
         longitude:(double)lng
         inPolygon:(NSArray *)polygon
{
    BOOL found = NO;
    NSUInteger i, j, count = polygon.count;
    for (i = 0, j = count - 1; i < count; j = i++)
    {
        if((([polygon[i][1] doubleValue] > lat) != ([polygon[j][1] doubleValue] > lat)) &&
           (lng < ([polygon[j][0] doubleValue] - [polygon[i][0] doubleValue])
            * (lat - [polygon[i][1] doubleValue])
            / ([polygon[j][1] doubleValue] - [polygon[i][1] doubleValue]) + [polygon[i][0] doubleValue])
        ) {
            found = !found;
        }
    }

    return found;
}

- (NSString *)countryCodeForCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (!CLLocationCoordinate2DIsValid(coordinate))
        return nil;

    double lat = coordinate.latitude, lng = coordinate.longitude;

    for (NSDictionary *country in _countryData)
    {
        NSDictionary *geometry = country[@"geometry"];
        NSArray *coordinates = geometry[@"coordinates"];

        if (coordinates.count == 0)
        {
            continue;
        }
        
        if([geometry[@"type"] isEqualToString:@"Polygon"])
        {
            // For some reason the coordinates in GeoJSON format are layed out so that each geometric polygon
            // is wrapped in an array.
            if([self isLatitude:lat
                      longitude:lng
                      inPolygon:coordinates.firstObject])
            {
                return country[@"id"];
            }
        }

        else if([geometry[@"type"] isEqualToString:@"MultiPolygon"])
        {
            for (NSArray *polygon in coordinates)
            {
                // For some reason the coordinates in GeoJSON format are layed out so that each geometric polygon
                // is wrapped in an array.
                if([self isLatitude:lat
                          longitude:lng
                          inPolygon:polygon.firstObject])
                {
                    return country[@"id"];
                }
            }
        }
    }

    return nil;
}

@end
