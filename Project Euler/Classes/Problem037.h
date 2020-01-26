//
//  Problem037.h
//  Project Euler
//
//  Created by Matt Jones on 1/26/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Problem.h"
#import "ProblemViewController.h"

@interface Problem37 : Problem 

- (NSString *) solve:(ProblemViewController *)pvc;
- (NSMutableArray *) getPrimesTo:(NSInteger)n;
- (NSMutableArray *) addNextPrime:(NSMutableArray *)list;
- (BOOL) isTruncatableRight:(NSInteger)num primes:(NSMutableArray *)p;
- (BOOL) isTruncatableLeft:(NSInteger)num primes:(NSMutableArray *)p;

@end
