//
//  Problem038.h
//  Project Euler
//
//  Created by Matt Jones on 1/26/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Problem.h"
#import "ProblemViewController.h"

@interface Problem38 : Problem 

- (NSString *) solve:(ProblemViewController *)pvc;
- (NSString *) nineDigitNumber:(NSInteger)n;
- (BOOL) isPandigital:(NSString *)num;

@end
