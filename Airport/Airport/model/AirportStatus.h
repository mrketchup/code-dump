//
//  AirportStatus.h
//  Airport
//
//  Created by Matt Jones on 8/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Weather;


/**
 * The AirportStatus class. It holds info on the status of an airport.
 * @author Matt Jones
 */
@interface AirportStatus : NSObject

/** If there is a delay or not. */
@property (nonatomic) BOOL isDelay;

/** The reason for the delay. */
@property (nonatomic, strong) NSString *reason;

/** The time when the closure began. Empty if no closure. */
@property (nonatomic, strong) NSString *closureBegin;

/** The time when the closure will end. Empty if no closure. */
@property (nonatomic, strong) NSString *closureEnd;

/** The minimum expected delay. Empty if no delay. */
@property (nonatomic, strong) NSString *minDelay;

/** The maximum expected delay. Empty if no delay. */
@property (nonatomic, strong) NSString *maxDelay;

/** The average expected delay. Empty if no delay. */
@property (nonatomic, strong) NSString *avgDelay;

/** Not really sure what this is... */
@property (nonatomic, strong) NSString *endTime;

/** The trend of the delay length. Empty if no delay. */
@property (nonatomic, strong) NSString *trend;

/** The type of delay. Empty if no delay. */
@property (nonatomic, strong) NSString *type;

/** The object containing info about the weather. */
@property (nonatomic, strong) Weather *weather;

@end
