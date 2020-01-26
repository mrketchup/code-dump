//
//  Problem036.h
//  Project Euler
//
//  Created by Matt Jones on 1/26/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Problem.h"
#import "ProblemViewController.h"

@interface Problem36 : Problem 

- (NSString *) solve:(ProblemViewController *)pvc;
- (NSString *) baseTwo:(int)n;
- (BOOL) isPalindrome:(NSString *)n;

@end
