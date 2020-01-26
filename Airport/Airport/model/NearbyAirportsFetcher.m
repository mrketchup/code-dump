//
//  NearbyAirportFetcher.m
//  Airport
//
//  Created by Matt Jones on 8/11/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "NearbyAirportsFetcher.h"
#import "Airport.h"

// Constants
static NSString * const URL = @"http://www.allplaces.us/afz.cgi?s=";
static NSString * const ARGS = @"&rad=50";


#pragma mark - Private Interface

@interface NearbyAirportsFetcher () <NSURLConnectionDelegate,
                                    NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSMutableData *data;
@end


@implementation NearbyAirportsFetcher


#pragma mark - Synthesis Override

/* Lazy load. */
- (NSData *)data {
    if (!_data) {
        _data = [[NSMutableData alloc] init];
    }
    return _data;
}


#pragma mark - Method Implementation

/* Set the zip and the delegate. */
- (id)initWithZipcode:(NSString *)zipcode
             delegate:(id<NearbyAirportsFetcherDelegate>)delegate {
    self = [super init];
    if (self) {
        _zipcode = zipcode;
        _delegate = delegate;
    }
    return self;
}

/*
 * Create the connection with the request for the server url and zip code of the
 * users location. If the connection is nil, something went wrong and we need to
 * alert the delegate.
 */
- (void)fetchList {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",
                                       URL, self.zipcode, ARGS]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request
                                                                delegate:self];
    if (!connection) {
        [self.delegate nearbyAirportsFetcher:self didFailWithError:nil];
    }
    
}


#pragma mark - NSURLConnectionDelegate & NSURLConnectionDataDelegate Methods

/* Raise the error up to the delegate. */
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error {
    [self.delegate nearbyAirportsFetcher:self didFailWithError:error];
}

/* Append the data to the existing data. */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

/* Crunch through the html for the codes and make an airport array. */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *html = [[NSString alloc] initWithData:self.data
                                           encoding:NSUTF8StringEncoding];
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:@"FAA ID.*<strong>\\w+</strong>"
                                              options:0
                                                error:NULL];
    NSRange range = [html rangeOfString:html];
    NSArray *matches = [regex matchesInString:html
                                      options:0
                                        range:range];
    
    NSMutableArray *iatas = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *m in matches) {
        NSString *code = [html substringWithRange:m.range];
        code = [code stringByReplacingOccurrencesOfString:@"FAA ID: <font color=navy><strong>"
                                               withString:@""];
        code = [code stringByReplacingOccurrencesOfString:@"</strong>"
                                               withString:@""];
        [iatas addObject:code];
    }
    
    [self.delegate nearbyAirportsFetcher:self didFetchAirportCodes:iatas];
}

@end