//
//  Problem023.m
//  Project Euler
//
//  Created by Matt Jones on 12/22/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem023.h"


@implementation Problem23

- (id) init
{
	NSString *t = @"Problem 23";
	NSString *st = @"Find the sum of all the positive integers which cannot be "
					"written as the sum of two abundant numbers.";
	NSString *d = @"A perfect number is a number for which the sum of its "
				   "proper divisors is exactly equal to the number. For "
				   "example, the sum of the proper divisors of 28 would be 1 + "
				   "2 + 4 + 7 + 14 = 28, which means that 28 is a perfect "
				   "number.\n\nA number n is called deficient if the sum of "
				   "its proper divisors is less than n and it is called "
				   "abundant if this sum exceeds n.\n\nAs 12 is the smallest "
				   "abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest "
				   "number that can be written as the sum of two abundant "
				   "numbers is 24. By mathematical analysis, it can be shown "
				   "that all integers greater than 28123 can be written as the "
				   "sum of two abundant numbers. However, this upper limit "
				   "cannot be reduced any further by analysis even though it "
				   "is known that the greatest number that cannot be expressed "
				   "as the sum of two abundant numbers is less than this limit."
				   "\n\nFind the sum of all the positive integers which cannot "
				   "be written as the sum of two abundant numbers.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	long long int sum = 0;
	NSMutableArray *isSumOfAbundants = [[NSMutableArray alloc] init];
	NSMutableArray *abundants = [[NSMutableArray alloc] init];
	for (int i=0; i<=28123; i++) 
	{
		[isSumOfAbundants addObject:@(NO)];
		[isSumOfAbundants addObject:@(NO)];
		if ([self sumOfFactors:i] > i) 
		{
			[abundants addObject:@(i)];
		}
	}
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=0; i<[abundants count]; i++) 
	{
		for (int j=i; j<[abundants count]; j++) 
		{
			NSInteger ab1 = [[abundants objectAtIndex:i]intValue];
			NSInteger ab2 = [[abundants objectAtIndex:j]intValue];
			[isSumOfAbundants replaceObjectAtIndex:ab1+ab2 withObject:@(YES)];
		}
	}
	
	for (int i=0; i<[isSumOfAbundants count]/2; i++) 
	{
		if (![[isSumOfAbundants objectAtIndex:i]boolValue]) 
		{
			sum += i;
		}
	}
	
	return [NSString stringWithFormat:@"%qi", sum];
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
