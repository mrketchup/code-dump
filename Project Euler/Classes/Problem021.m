//
//  Problem21.m
//  Project Euler
//
//  Created by Matt Jones on 12/22/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem021.h"


@implementation Problem21

- (id) init
{
	NSString *t = @"Problem 21";
	NSString *st = @"Evaluate the sum of all amicable pairs under 10000.";
	NSString *d = @"Let d(n) be defined as the sum of proper divisors of n "
				   "(numbers less than n which dvide evenly into n).\nIf d(a) "
				   "= b and d(b) = a, where a != b, then a and b are an "
				   "amicable pair and each of a and b are called amicable "
				   "numbers.\n\nFor example, the proper divisors of 220 are 1, "
				   "2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) "
				   "= 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; "
				   "so d(284) = 220.\n\nEvaluate the sum of al the amicable "
				   "numbers under 10000.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int sum = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int a=0; a<10000; a++) 
	{
		int b = [self sumOfFactors:a];
		int dOfB = [self sumOfFactors:b];
		if (dOfB == a && a != b) 
		{
			sum += a;
		}
	}
	
	return [NSString stringWithFormat:@"%d", sum];
}

- (int) sumOfFactors:(int)n
{
	if (n < 2) 
	{
		return 0;
	}
	
	int sum = 0;
	for (int i=1; i<n/2+1; i++) 
	{
		if (n % i == 0) 
		{
			sum += i;
		}
	}
	
	return sum;
}

@end
