//
//  Problem027.h
//  Project Euler
//
//  Created by Matt Jones on 1/3/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Problem.h"
#import "ProblemViewController.h"

@interface Problem27 : Problem 

- (NSString *) solve:(ProblemViewController *)pvc;
- (BOOL) isPrime:(int)n;
- (int) chain:(int)a and:(int)b;

@end
