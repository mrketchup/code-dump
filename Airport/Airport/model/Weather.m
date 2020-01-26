//
//  Weather.m
//  Airport
//
//  Created by Matt Jones on 8/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "Weather.h"

// Constants
static NSString * const WEST = @"West";
static NSString * const SOUTHWEST = @"Southwest";
static NSString * const SOUTH = @"South";
static NSString * const SOUTHEAST = @"Southeast";
static NSString * const EAST = @"East";
static NSString * const NORTHEAST = @"Northeast";
static NSString * const NORTH = @"North";
static NSString * const NORTHWEST = @"Northwest";


@implementation Weather

/* Figure out the given string's enumeration equivalent.  */
+ (WindDirection)windDirectionFromString:(NSString *)string {
    WindDirection dir = 0;
    
    if ([string isEqualToString:WEST]) {
        dir = WindDirectionWest;
    } else if ([string isEqualToString:SOUTHWEST]) {
        dir = WindDirectionSouthWest;
    } else if ([string isEqualToString:SOUTH]) {
        dir = WindDirectionSouth;
    } else if ([string isEqualToString:SOUTHEAST]) {
        dir = WindDirectionSouthEast;
    } else if ([string isEqualToString:EAST]) {
        dir = WindDirectionEast;
    } else if ([string isEqualToString:NORTHEAST]) {
        dir = WindDirectionNorthEast;
    } else if ([string isEqualToString:NORTH]) {
        dir = WindDirectionNorth;
    } else if ([string isEqualToString:NORTHWEST]) {
        dir = WindDirectionNorthWest;
    }
    
    return dir;
}

@end
