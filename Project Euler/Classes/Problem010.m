//
//  Problem10.m
//  Project Euler
//
//  Created by Matt Jones on 12/9/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem010.h"


@implementation Problem10

- (id) init
{
	NSString *t = @"Problem 10";
	NSString *st = @"Calculate the sum of all the primes below two million.";
	NSString *d = @"The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.\n\n"
				   "Find the sum of all the primes below two million.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	long long int sum = 0;
	NSMutableArray *isPrime = [[NSMutableArray alloc] init];
	for (int i=0; i<2000000; i++) 
	{
		[isPrime addObject:@(YES)];
	}
	
	int term = (int)sqrt(2000000.0) + 1;
	for (int i=2; i<=term; i++) 
	{
		for (int j=2*i; j<2000000; j+=i) 
		{
			[isPrime replaceObjectAtIndex:j withObject:@(NO)];
		}
	}
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=2; i<2000000; i++) 
	{
		if ([[isPrime objectAtIndex:i] boolValue]) 
		{
			sum += i;
		}
	}
	
	return [NSString stringWithFormat:@"%qi", sum];
}

@end
