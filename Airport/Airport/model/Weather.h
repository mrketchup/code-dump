//
//  Weather.h
//  Airport
//
//  Created by Matt Jones on 8/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The Weather class. It holds info on the weather.
 * @author Matt Jones
 */
@interface Weather : NSObject

/** An enumeration of the 8 possible wind directions. */
typedef NS_ENUM(NSInteger, WindDirection) {
    WindDirectionWest,
    WindDirectionSouthWest,
    WindDirectionSouth,
    WindDirectionSouthEast,
    WindDirectionEast,
    WindDirectionNorthEast,
    WindDirectionNorth,
    WindDirectionNorthWest
};

/** The miles of visibility. */
@property (nonatomic) float visibility;

/** The temperature in fahrenheit. */
@property (nonatomic) float temperature;

/** The temperature in celcius. */
@property (nonatomic) float temperatureCelcius;

/** The direction of the wind. */
@property (nonatomic) WindDirection windDirection;

/** The speed of the wind. */
@property (nonatomic) float windSpeed;

/** The full description of wind direction and speed. */
@property (nonatomic, strong) NSString *wind;

/** The description of the weather conditions. */
@property (nonatomic, strong) NSString *weather;

/** The credit for where the weather data came from. */
@property (nonatomic, strong) NSString *credit;

/** The time of the weather update. */
@property (nonatomic, strong) NSString *timeUpdated;


/**
 * A convenience method for getting the enumeration value from a string of the
 * wind direction. Default return value is 0 (WindDirectionWest).
 * @param string the wind direction string
 * @return the WindDirection enumeration value
 */
+ (WindDirection)windDirectionFromString:(NSString *)string;

@end
