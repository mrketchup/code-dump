//
//  AirportStatusParser.h
//  Airport
//
//  Created by Matt Jones on 8/8/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AirportStatusParser;
@class AirportStatus;
@class Airport;


/**
 * The protocol for handling the AirportStatusParser class.
 * @author Matt Jones
 */
@protocol AirportStatusParserDelegate <NSObject>

/**
 * Sent to the delegate when the parse completes for the airport status.
 * @param parser the AirportStatusParser instance
 * @param status the status for the airport
 * @param airport the airport the status belongs to
 */
- (void)airportStatusParser:(AirportStatusParser *)parser
             didFetchStatus:(AirportStatus *)status
                 forAirport:(Airport *)airport;

/**
 * Sent to the delegate if an error occurs in the parse process.
 * @param parser the AirportStatusParser instance
 * @param error the error
 */
- (void)airportStatusParser:(AirportStatusParser *)parser
           didFailWithError:(NSError *)error;

@end


/**
 * The AirportStatusParser class. Parses the status xml data.
 * @author Matt Jones
 */
@interface AirportStatusParser : NSObject

/** The xml data. */
@property (nonatomic, strong) NSData *data;

/** The delegate. */
@property (nonatomic, weak) id<AirportStatusParserDelegate> delegate;

/**
 * Initialize the parser with given xml data and delegate.
 * @param data the status xml data
 * @param delegate the delegate
 */
- (id)initWithStatusData:(NSData *)data
                delegate:(id<AirportStatusParserDelegate>)delegate;

/**
 * Fires the parse process. Callbacks go to the delegate.
 */
- (void)parseStatus;

@end
