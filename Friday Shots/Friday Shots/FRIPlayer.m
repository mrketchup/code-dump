//
//  FRIPlayer.m
//  Friday Shots
//
//  Created by Matt Jones on 3/26/14.
//  Copyright (c) 2014 Mattjones. All rights reserved.
//

#import "FRIPlayer.h"

@implementation FRIPlayer

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"playerID": @"id",
              @"name": @"name",
              @"height": @"height",
              @"weight": @"weight",
              @"shotIDs": @"shot_set",
              @"hits": @"hits",
              @"accuracy": @"accuracy",
              @"totalWinnings": @"total_winnings" };
}

@end
