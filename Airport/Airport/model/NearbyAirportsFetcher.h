//
//  NearbyAirportFetcher.h
//  Airport
//
//  Created by Matt Jones on 8/11/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NearbyAirportsFetcher;


/**
 * The protocol for handling the NearbyAirportsFetcher class.
 * @author Matt Jones
 */
@protocol NearbyAirportsFetcherDelegate <NSObject>

/**
 * Sent to the delegate after the airports' codes have been successfully
 * fetched.
 * @param fetcher the NearbyAirportsFetcher instance
 * @param iataCodes the nearby airports' IATA codes.
 */
- (void)nearbyAirportsFetcher:(NearbyAirportsFetcher *)fetcher
         didFetchAirportCodes:(NSArray *)iataCodes;

/**
 * Sent to the delegate if an error occurs in the fetch process.
 * @param fetcher the NearbyAirportsFetcher instance
 * @param error the error
 */
- (void)nearbyAirportsFetcher:(NearbyAirportsFetcher *)fetcher
             didFailWithError:(NSError *)error;

@end


/**
 * The class for fetching the list of nearby airports.
 * @author Matt Jones
 */
@interface NearbyAirportsFetcher : NSObject

/** The zipcode for looking up nearby airports. */
@property (nonatomic, strong) NSString *zipcode;

/** The delegate for the NearbyAirportsFetcher. */
@property (nonatomic, weak) id<NearbyAirportsFetcherDelegate> delegate;

/**
 * Initialize the NearbyAirportsFetcher with a given zipcode and delegate.
 * @param zipcode the user's zipcode
 * @param delegate the delegate
 */
- (id)initWithZipcode:(NSString *)zipcode
             delegate:(id<NearbyAirportsFetcherDelegate>)delegate;

/**
 * Fires the fetch process. Callbacks go to the delegate.
 */
- (void)fetchList;

@end
