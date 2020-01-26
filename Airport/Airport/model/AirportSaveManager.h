//
//  AirportSaveManager.h
//  Airport
//
//  Created by Matt Jones on 8/10/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Airport;


/**
 * The AirportSaveManager class. Used for saving and loading airports.
 * @author Matt Jones
 */
@interface AirportSaveManager : NSObject

/**
 * Gets the list of airports saved to disk.
 * @return the array of airports
 */
+ (NSMutableArray *)getSavedAirports;

/**
 * Save the given airport to disk.
 * @param airport the airport to save
 */
+ (void)saveAirport:(Airport *)airport;

/**
 * Remove the given airport from the saved list.
 * @param airport the airport to remove
 */
+ (void)removeAirport:(Airport *)airport;

@end
