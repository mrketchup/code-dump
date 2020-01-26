//
//  BackgroundLayer.m
//  Airport
//
//  Created by Matt Jones on 8/10/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import "BackgroundLayer.h"
#import "Colors.h"

@implementation BackgroundLayer

/* Set up the blue gradient for the background. */
+ (CAGradientLayer *)gradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = @[(id)[Colors darkBlue].CGColor,
                        (id)[Colors lightBlue].CGColor];;
    return gradient;
}

@end
