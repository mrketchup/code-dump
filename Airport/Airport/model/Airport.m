//
//  Airport.m
//  Airport
//
//  Created by Matt Jones on 8/7/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "Airport.h"

@implementation Airport

/* Added for easy removal from arrays. */
- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[Airport class]]) {
        return NO;
    }
    
    Airport *other = object;
    return [self.IATA isEqualToString:other.IATA];
}

@end
