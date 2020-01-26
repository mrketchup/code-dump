//
//  AirportStatusParser.m
//  Airport
//
//  Created by Matt Jones on 8/8/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "AirportStatusParser.h"
#import "Airport.h"
#import "AirportStatus.h"
#import "Weather.h"

// Constants
static NSString * const DELAY = @"Delay";
static NSString * const IATA = @"IATA";
static NSString * const STATE = @"State";
static NSString * const NAME = @"Name";
static NSString * const VISIBILITY = @"Visibility";
static NSString * const WEATHER = @"Weather";
static NSString * const CREDIT = @"Credit";
static NSString * const UPDATED = @"Updated";
static NSString * const TEMP = @"Temp";
static NSString * const WIND = @"Wind";
static NSString * const ICAO = @"ICAO";
static NSString * const CITY = @"City";
static NSString * const REASON = @"Reason";
static NSString * const CLOSURE_BEGIN = @"ClosureBegin";
static NSString * const END_TIME = @"EndTime";
static NSString * const MIN_DELAY = @"MinDelay";
static NSString * const AVG_DELAY = @"AvgDelay";
static NSString * const MAX_DELAY = @"MaxDelay";
static NSString * const CLOSURE_END = @"ClosureEnd";
static NSString * const TREND = @"Trend";
static NSString * const TYPE = @"Type";
static NSString * const TRUE_STRING = @"true";
static NSString * const FLOAT_REGEX = @"[-+]?[0-9]*\\.?[0-9]+";
static NSString * const FIRST_WORD_REGEX = @"^\\w+";


#pragma mark - Private Interface

@interface AirportStatusParser () <NSXMLParserDelegate>
@property (nonatomic, strong) Airport *airport;
@property (nonatomic, strong) AirportStatus *status;
@property (nonatomic, strong) Weather *weather;
@property (nonatomic, strong) NSString *currentString;
@end


@implementation AirportStatusParser


#pragma mark - Synthesis Override

/* Lazy load. */
- (Airport *)airport {
    if (!_airport) {
        _airport = [[Airport alloc] init];
    }
    return _airport;
}

/* Lazy load. */
- (AirportStatus *)status {
    if (!_status) {
        _status = [[AirportStatus alloc] init];
    }
    return _status;
}

/* Lazy load. */
- (Weather *)weather {
    if (!_weather) {
        _weather = [[Weather alloc] init];
    }
    return _weather;
}


#pragma mark - Method Implementation

/* Set the xml data and delegate to what is given. */
- (id)initWithStatusData:(NSData *)data
                delegate:(id<AirportStatusParserDelegate>)delegate {
    self = [super init];
    if (self) {
        _data = data;
        _delegate = delegate;
    }
    return self;
}

/* Init the xml parser and kick it off. Alert delegate if anything is wrong. */
- (void)parseStatus {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.data];
    if (parser) {
        parser.delegate = self;
        if (![parser parse]) {
            [self.delegate airportStatusParser:self
                              didFailWithError:parser.parserError];
        }
    } else {
        [self.delegate airportStatusParser:self
                          didFailWithError:parser.parserError];
    }
}

/* Reset the current string. */
- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qualifiedName
     attributes:(NSDictionary *)attributeDict {
    self.currentString = @"";
}

/*
 * Set the appropriate field with the current string. Do some regex kung fu to
 * pick out the data from the wind and temperature strings.
 */
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName {
    if ([elementName isEqualToString:DELAY]) {
        self.status.isDelay = [self.currentString isEqualToString:TRUE_STRING];
    } else if ([elementName isEqualToString:IATA]) {
        self.airport.IATA = self.currentString;
    } else if ([elementName isEqualToString:STATE]) {
        self.airport.state = self.currentString;
    } else if ([elementName isEqualToString:NAME]) {
        self.airport.name = self.currentString;
    } else if ([elementName isEqualToString:VISIBILITY]) {
        self.weather.visibility = [self.currentString floatValue];
    } else if ([elementName isEqualToString:WEATHER]) {
        if (!self.weather.weather) {
            self.weather.weather = self.currentString;
        }
    } else if ([elementName isEqualToString:CREDIT]) {
        self.weather.credit = self.currentString;
    } else if ([elementName isEqualToString:UPDATED]) {
        self.weather.timeUpdated = self.currentString;
    } else if ([elementName isEqualToString:TEMP]) {
        NSRegularExpression *regex =
        [NSRegularExpression regularExpressionWithPattern:FLOAT_REGEX
                                                  options:0
                                                    error:NULL];
        NSRange range = [self.currentString rangeOfString:self.currentString];
        NSArray *matches = [regex matchesInString:self.currentString
                                          options:0
                                            range:range];
        
        NSMutableArray *temps = [[NSMutableArray alloc] init];
        for (NSTextCheckingResult *m in matches) {
            [temps addObject:[self.currentString substringWithRange:m.range]];
        }
        
        self.weather.temperature = [temps[0] floatValue];
        self.weather.temperatureCelcius = [temps[1] floatValue];
    } else if ([elementName isEqualToString:WIND]) {
        self.weather.wind = self.currentString;
        
        NSRegularExpression *regexDir =
        [NSRegularExpression regularExpressionWithPattern:FIRST_WORD_REGEX
                                                  options:0
                                                    error:NULL];
        NSRegularExpression *regexSpd =
        [NSRegularExpression regularExpressionWithPattern:FLOAT_REGEX
                                                  options:0
                                                    error:NULL];
        NSRange range = [self.currentString rangeOfString:self.currentString];
        NSTextCheckingResult *matchDir =
        [regexDir firstMatchInString:self.currentString options:0 range:range];
        NSTextCheckingResult *matchSpd =
        [regexSpd firstMatchInString:self.currentString options:0 range:range];
        
        NSString *dir = [self.currentString substringWithRange:matchDir.range];
        NSString *spd = [self.currentString substringWithRange:matchSpd.range];
        self.weather.windDirection = [Weather windDirectionFromString:dir];
        self.weather.windSpeed = [spd floatValue];
    } else if ([elementName isEqualToString:ICAO]) {
        self.airport.ICAO = self.currentString;
    } else if ([elementName isEqualToString:CITY]) {
        self.airport.city = self.currentString;
    } else if ([elementName isEqualToString:REASON]) {
        self.status.reason = self.currentString;
    } else if ([elementName isEqualToString:CLOSURE_BEGIN]) {
        self.status.closureBegin = self.currentString;
    } else if ([elementName isEqualToString:END_TIME]) {
        self.status.endTime = self.currentString;
    } else if ([elementName isEqualToString:MIN_DELAY]) {
        self.status.minDelay = self.currentString;
    } else if ([elementName isEqualToString:AVG_DELAY]) {
        self.status.avgDelay = self.currentString;
    } else if ([elementName isEqualToString:MAX_DELAY]) {
        self.status.maxDelay = self.currentString;
    } else if ([elementName isEqualToString:CLOSURE_END]) {
        self.status.closureEnd = self.currentString;
    } else if ([elementName isEqualToString:TREND]) {
        self.status.trend = self.currentString;
    } else if ([elementName isEqualToString:TYPE]) {
        self.status.type = self.currentString;
    }
}

/* Append the string to the current string. */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    self.currentString = [self.currentString stringByAppendingString:string];
}

/*
 * Give the weather to the status and the status ot the airport. Pass stuff up
 * to delegate.
 */
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    self.status.weather = self.weather;
    self.airport.status = self.status;
    [self.delegate airportStatusParser:self
                        didFetchStatus:self.status
                            forAirport:self.airport];
}

/* Pass up any errors to the delegate. */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    [self.delegate airportStatusParser:self didFailWithError:parseError];
}

@end
