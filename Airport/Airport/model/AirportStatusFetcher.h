//
//  AirportStatusFetcher.h
//  Airport
//
//  Created by Matt Jones on 8/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Airport;
@class AirportStatus;
@class AirportStatusFetcher;


/**
 * The protocol for handling the AirportStatusFetcher class.
 * @author Matt Jones
 */
@protocol AirportStatusFetcherDelegate <NSObject>

/**
 * Sent to the delegate after the status has been successfully fetched for the
 * airport.
 * @param fetcher the AirportStatusFetcher instance
 * @param status the status for the airport
 * @param airport the airport the status belongs to
 */
- (void)airportStatusFetcher:(AirportStatusFetcher *)fetcher
              didFetchStatus:(AirportStatus *)status
                  forAirport:(Airport *)airport;

/**
 * Sent to the delegate if an error occurs in the fetch process.
 * @param fetcher the AirportStatusFetcher instance
 * @param error the error
 */
- (void)airportStatusFetcher:(AirportStatusFetcher *)fetcher
            didFailWithError:(NSError *)error;

@end


/**
 * The class for fetching the status of a certain airport.
 * @author Matt Jones
 */
@interface AirportStatusFetcher : NSObject

/** The airport whose status the fetcher is fetching. */
@property (nonatomic, strong) Airport *airport;

/** The delegate for the AirportStatusFetcher. */
@property (nonatomic, weak) id<AirportStatusFetcherDelegate> delegate;

/**
 * Initialize the AirportStatusFetcher with a given airport and delegate. The
 * only field in airport that needs to be set is IATA for the fetcher to work.
 * @param airport the airport
 * @param delegate the delegate
 */
- (id)initWithAirport:(Airport *)airport
             delegate:(id<AirportStatusFetcherDelegate>)delegate;

/**
 * Fires the fetch process. Callbacks go to the delegate.
 */
- (void)fetchStatus;

@end
