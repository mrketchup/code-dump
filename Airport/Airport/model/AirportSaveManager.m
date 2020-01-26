//
//  AirportSaveManager.m
//  Airport
//
//  Created by Matt Jones on 8/10/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "AirportSaveManager.h"
#import "Airport.h"

// Constants
static NSString * const ARRAY_KEY = @"airport_array";
static NSString * const NAME_KEY = @"airport_name";
static NSString * const CITY_KEY = @"airport_city";
static NSString * const STATE_KEY = @"airport_state";
static NSString * const IATA_KEY = @"airport_iata";
static NSString * const ICAO_KEY = @"airport_icao";


@implementation AirportSaveManager

/*
 * Load the array of dictionaries of airport info and convert to a mutable array
 * of airport objects.
 */
+ (NSMutableArray *)getSavedAirports {
    [self setup];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *airportArray = [[NSMutableArray alloc] init];
    for (NSDictionary *info in [defaults arrayForKey:ARRAY_KEY]) {
        Airport *airport = [[Airport alloc] init];
        airport.name = info[NAME_KEY];
        airport.city = info[CITY_KEY];
        airport.state = info[STATE_KEY];
        airport.IATA = info[IATA_KEY];
        airport.ICAO = info[ICAO_KEY];
        [airportArray addObject:airport];
    }
    
    return airportArray;
}

/*
 * Convert the airport to dictionary and replace the saved array with a new one
 * including the new dictionary.
 */
+ (void)saveAirport:(Airport *)airport {
    [self setup];
    
    NSDictionary *info = @{NAME_KEY: airport.name,
                           CITY_KEY: airport.city,
                           STATE_KEY: airport.state,
                           IATA_KEY: airport.IATA,
                           ICAO_KEY: airport.ICAO};
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *airports = [[defaults arrayForKey:ARRAY_KEY] mutableCopy];
    [airports addObject:info];
    [defaults setObject:airports forKey:ARRAY_KEY];
    
    [defaults synchronize];
}

/* Pull up the array of saved airports and search for the one to remove. */
+ (void)removeAirport:(Airport *)airport {
    [self setup];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *airports = [[defaults arrayForKey:ARRAY_KEY] mutableCopy];
    
    for (NSInteger i = 0; i < [airports count]; i++) {
        NSDictionary *info = [airports objectAtIndex:i];
        if ([info[IATA_KEY] isEqualToString:airport.IATA]) {
            [airports removeObjectAtIndex:i];
            break;
        }
    }
    
    [defaults setObject:airports forKey:ARRAY_KEY];
    
    [defaults synchronize];
}

/* Just making sure the airport array exists. */
+ (void)setup {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults arrayForKey:ARRAY_KEY]) {
        [defaults setObject:@[] forKey:ARRAY_KEY];
    }
}

@end
