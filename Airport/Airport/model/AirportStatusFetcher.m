//
//  AirportStatusFetcher.m
//  Airport
//
//  Created by Matt Jones on 8/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "AirportStatusFetcher.h"
#import "Airport.h"
#import "AirportStatusParser.h"

// Constants
static NSString * const URL = @"http://services.faa.gov/airport/status/";
static NSString * const ARGS = @"?format=application/xml";


#pragma mark - Private Interface

@interface AirportStatusFetcher () <NSURLConnectionDelegate,
                                    NSURLConnectionDataDelegate,
                                    AirportStatusParserDelegate>
@property (nonatomic, strong) NSMutableData *data;
@end


@implementation AirportStatusFetcher


#pragma mark - Synthesis Override

/* Lazy load. */
- (NSData *)data {
    if (!_data) {
        _data = [[NSMutableData alloc] init];
    }
    return _data;
}


#pragma mark - Method Implementation

/* Set the airport and delegate to what is given. */
- (id)initWithAirport:(Airport *)airport
             delegate:(id<AirportStatusFetcherDelegate>)delegate {
    self = [super init];
    if (self) {
        _airport = airport;
        _delegate = delegate;
    }
    return self;
}

/*
 * Create the connection with the request for the server url and IATA code of
 * the airport. If the connection is nil, something went wrong and we need to
 * alert the delegate.
 */
- (void)fetchStatus {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",
                                       URL, self.airport.IATA, ARGS]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request
                                                                delegate:self];
    if (!connection) {
        [self.delegate airportStatusFetcher:self didFailWithError:nil];
    }
    
}


#pragma mark - NSURLConnectionDelegate & NSURLConnectionDataDelegate Methods

/* Raise the error up to the delegate. */
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error {
    [self.delegate airportStatusFetcher:self didFailWithError:error];
}

/* Append the data to the existing data. */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

/* Kick off the parser with the xml data from the server. */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    AirportStatusParser *parser =
    [[AirportStatusParser alloc] initWithStatusData:self.data
                                           delegate:self];
    [parser parseStatus];
}


#pragma mark - AirporstStatusParserDelegate Methods

/* Raise the error up to the delegate. */
- (void)airportStatusParser:(AirportStatusParser *)parser
           didFailWithError:(NSError *)error {
    [self.delegate airportStatusFetcher:self didFailWithError:error];
}

/* Parse success! Send up the airport and status to the delegate. */
- (void)airportStatusParser:(AirportStatusParser *)parser
             didFetchStatus:(AirportStatus *)status
                 forAirport:(Airport *)airport {
    [self.delegate airportStatusFetcher:self
                         didFetchStatus:status
                             forAirport:airport];
}

@end
