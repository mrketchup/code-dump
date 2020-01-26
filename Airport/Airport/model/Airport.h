//
//  Airport.h
//  Airport
//
//  Created by Matt Jones on 8/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AirportStatus;


/**
 * The Airport class. It contains all the info about the airport.
 * @author Matt Jones
 */
@interface Airport : NSObject

/** The name of the airport. */
@property (nonatomic, strong) NSString *name;

/** The city which the airport is in. */
@property (nonatomic, strong) NSString *city;

/** The state which the airport is in. */
@property (nonatomic, strong) NSString *state;

/** The airport's International Association of Travel Agents Airport code. */
@property (nonatomic, strong) NSString *IATA;

/** The airport's International Civil Aviation Organization Airport code. */
@property (nonatomic, strong) NSString *ICAO;

/** The object containing status info about the airport. */
@property (nonatomic, strong) AirportStatus *status;

@end
