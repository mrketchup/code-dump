//
//  Problem023.h
//  Project Euler
//
//  Created by Matt Jones on 12/22/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Problem.h"
#import "ProblemViewController.h"


@interface Problem23 : Problem 

- (NSString *) solve:(ProblemViewController *)pvc;
- (int) sumOfFactors:(int)n;

@end
