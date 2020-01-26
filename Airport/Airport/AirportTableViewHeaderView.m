//
//  AirportTableViewHeaderView.m
//  Airport
//
//  Created by Matt Jones on 8/11/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "AirportTableViewHeaderView.h"

// Constants
CGFloat const AIRPORT_TABLE_VIEW_HEADER_HEIGHT = 48.0f;
static NSString * const NIB_NAME = @"AirportTableViewHeaderView";

@implementation AirportTableViewHeaderView

/* Load the view from the nib. */
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NIB_NAME
                                                     owner:self
                                                   options:nil];
        for (id thing in nib) {
            if ([thing isKindOfClass:[self class]]) {
                self = thing;
                break;
            }
        }
    }
    return self;
}

@end
