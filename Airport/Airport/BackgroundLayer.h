//
//  BackgroundLayer.h
//  Airport
//
//  Created by Matt Jones on 8/10/13.
//  Copyright (c) 2013 Mattjones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


/**
 * Convenience class for the background gradient.
 * @author Matt Jones
 */
@interface BackgroundLayer : NSObject

/**
 * Returns the layer for the gradient.
 * @return the gradient layer
 */
+ (CAGradientLayer *)gradient;

@end