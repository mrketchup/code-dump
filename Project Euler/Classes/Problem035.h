//
//  Problem035.h
//  Project Euler
//
//  Created by Matt Jones on 1/13/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Problem.h"
#import "ProblemViewController.h"

@interface Problem35 : Problem 

- (NSString *) solve:(ProblemViewController *)pvc;
- (BOOL) isCircularPrime:(int)n;
- (BOOL) isPrime:(int)n;

@end
