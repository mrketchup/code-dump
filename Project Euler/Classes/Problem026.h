//
//  Problem026.h
//  Project Euler
//
//  Created by Matt Jones on 1/3/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Problem.h"
#import "ProblemViewController.h"


@interface Problem26 : Problem 

- (NSString *) solve:(ProblemViewController *)pvc;
- (BOOL) isPrime:(int)n;
- (int) lengthOfPattern:(int)n;

@end
