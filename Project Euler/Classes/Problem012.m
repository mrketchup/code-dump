//
//  Problem12.m
//  Project Euler
//
//  Created by Matt Jones on 12/10/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem012.h"


@implementation Problem12

- (id) init
{
	NSString *t = @"Problem 12";
	NSString *st = @"What is the value of the first triangle number to have "
					"over five hundred divisors?";
	NSString *d = @"The sequence of triangle numbers is generated by adding "
				   "the natural numbers. So the 7th triangle number would be 1 "
				   "+ 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:"
				   "\n\n\t1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...\n\nLet us "
				   "list the factors of the first seven triangle numbers:\n\n\t"
				   " 1: 1\n\t 3: 1,3\n\t 6: 1,2,3,6\n\t10: 1,2,5,10\n\t"
				   "15: 1,3,5,15\n\t21: 1,3,7,21\n\t28: 1,2,4,7,14,28\n\nWe "
				   "can see that 28 is the first triangle number to have over "
				   "five divisors.\n\nWhat is the value of the first triangle "
				   "number to have over five hundred divisors?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	long long int num = 1;
	long long int add = 2;
	long long int answer = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	while (answer == 0) 
	{
		if ([self numberOfDivisors:num] > 500) 
		{
			answer = num;
		}
		num += add;
		add++;
	}
	
	return [NSString stringWithFormat:@"%qi", answer];
}

- (NSInteger) numberOfDivisors:(long long int)n
{ 	
	NSMutableArray *isPrime = [[NSMutableArray alloc] init];
	long long int term = (int)sqrt(1.0 * n) + 2;
	
	for (long long int i=0; i<=term; i++) 
	{
		[isPrime addObject:@(YES)];
	}
	
	for (long long int i=2; i<=term; i++) 
	{
		for (long long int j=2*i; j<=term; j+=i) 
		{
			[isPrime replaceObjectAtIndex:j withObject:@(NO)];
		}
	}
	
	NSMutableArray *factors = [[NSMutableArray alloc] init];
	for (long long int i=0; i<=term; i++) 
	{
		[factors addObject:@0];
	}
	
	long long int remaining = n;
	long long int index = 2;
	while (index <= term) 
	{
		while (remaining % index == 0) 
		{
			int num = [[factors objectAtIndex:index] intValue] + 1;
			[factors replaceObjectAtIndex:index withObject:@(num)];
			remaining = remaining / index;
		}
		
		index++;
		while (index <= term && ![[isPrime objectAtIndex:index] boolValue]) 
		{
			index++;
		}
	}
	
	for (long long int i=0; i<=term; i++) 
	{
		if ([[factors objectAtIndex:i] intValue] > 0) 
		{
			int num = [[factors objectAtIndex:i] intValue] + 1;
			[factors replaceObjectAtIndex:i withObject:@(num)];
		}
	}
	
	int divisors = 1;
	for (long long int i=0; i<=term; i++) 
	{
		if ([[factors objectAtIndex:i] intValue] > 0) 
		{
			int num = [[factors objectAtIndex:i] intValue];
			divisors *= num;
		}
	}
	
	return divisors;
}

@end
