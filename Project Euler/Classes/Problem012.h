//
//  Problem12.h
//  Project Euler
//
//  Created by Matt Jones on 12/10/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Problem.h"
#import "ProblemViewController.h"


@interface Problem12 : Problem 

- (NSString *) solve:(ProblemViewController *)pvc;
- (NSInteger) numberOfDivisors:(long long int)n;

@end
