//
//  Problem6.m
//  Project Euler
//
//  Created by Matt Jones on 12/9/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem006.h"


@implementation Problem6

- (id) init
{
	NSString *t = @"Problem 6";
	NSString *st = @"What is the difference between the sum of the squares and "
					"the square of the sums?";
	NSString *d = @"The sum of the squares of the first ten natural numbers is,"
				   "\n\n\t1^2 + 2^2 + ... + 10^2 = 385\n\nThe square of the sum "
				   "of the first ten natural numbers is,\n\n\t(1 + 2 + ... + "
				   "10)^2 = 55^2 = 3025\n\nHence the difference between the "
				   "sum of the squares of the first ten natural numbers and "
				   "the square of the sum is 3025 - 385 = 2640.\n\nFind the "
				   "difference between the sum of the squares of the first one "
				   "hundred natural numbers and the square of the sum.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSInteger sumOfSquares = 0;
	NSInteger sum = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=1; i<=100; i++) 
	{
		sumOfSquares += pow(i, 2);
		sum += i;
	}	
	NSInteger squareOfSum = pow(sum, 2);
	
	return [NSString stringWithFormat:@"%d", (squareOfSum - sumOfSquares)];
}

@end