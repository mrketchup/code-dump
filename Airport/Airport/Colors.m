//
//  Colors.m
//  Airport
//
//  Created by Matt Jones on 8/10/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "Colors.h"

// Constants
static float const DARK_BLUE_RED = 0.267;
static float const DARK_BLUE_GREEN = 0.420;
static float const DARK_BLUE_BLUE = 0.573;
static float const LIGHT_BLUE_RED = 0.443;
static float const LIGHT_BLUE_GREEN = 0.596;
static float const LIGHT_BLUE_BLUE = 0.749;
static float const ALPHA = 1.000;

@implementation Colors

/* Create the UIColor. */
+ (UIColor *)darkBlue {
    return [UIColor colorWithRed:DARK_BLUE_RED
                           green:DARK_BLUE_GREEN
                            blue:DARK_BLUE_BLUE
                           alpha:ALPHA];
}

/* Create the UIColor. */
+ (UIColor *)lightBlue {
    return [UIColor colorWithRed:LIGHT_BLUE_RED
                           green:LIGHT_BLUE_GREEN
                            blue:LIGHT_BLUE_BLUE
                           alpha:ALPHA];
}

@end
