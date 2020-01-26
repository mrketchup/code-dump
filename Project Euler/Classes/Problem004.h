//
//  Problem4.h
//  Project Euler
//
//  Created by Matt Jones on 12/9/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Problem.h"
#import "ProblemViewController.h"


@interface Problem4 : Problem 

- (NSString *) solve:(ProblemViewController *)pvc;
- (BOOL) isPalindrome:(NSString *)n;

@end
