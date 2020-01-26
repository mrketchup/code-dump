//
//  Problem034.m
//  Project Euler
//
//  Created by Matt Jones on 1/13/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem034.h"


@implementation Problem34

- (id) init
{
	NSString *t = @"Problem 34";
	NSString *st = @"Find the sum of all the numbers which are equal to the "
					"sum of the factorials of their digits.";
	NSString *d = @"145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = "
				   "145.\n\nFind the sum of all numbers which are equal to the "
				   "sum of the factorial of their digits.\n\nNote: as 1! = 1 "
				   "and 2! = 2 are not sums they are not included.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int totalSum = 0;
	int digits = 1;
	int limit = [self factorial:9];
	int max = pow(10,digits+1);
	while (max / limit < 10) 
	{
		digits++;
		limit += [self factorial:9];
		max = pow(10,digits+1);
	}
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=10; i<=limit; i++) 
	{
		int sum = 0;
		for (int j=0; j<digits; j++) 
		{
			int div = pow(10,j);
			if (i > div) 
			{
				int digit = (i / div) % 10;
				sum += [self factorial:digit];
			}
		}
		
		if (i == sum) 
		{
			totalSum += i;
		}
	}
	
	return [NSString stringWithFormat:@"%d", totalSum];
}

- (NSInteger) factorial:(NSInteger)n
{
	if (n <= 1) 
	{
		return 1;
	}
	
	return n * [self factorial:n-1];
}

@end
