//
//  AirportViewHeaderView.m
//  Airport
//
//  Created by Matt Jones on 8/12/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "AirportViewHeaderView.h"

// Constants
CGFloat const AIRPORT_VIEW_HEADER_HEIGHT = 220.0f;
static NSString * const NIB_NAME = @"AirportViewHeaderView";


@implementation AirportViewHeaderView

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
