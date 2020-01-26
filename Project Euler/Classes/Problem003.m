//
//  Problem3.m
//  Project Euler
//
//  Created by Matt Jones on 12/9/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem003.h"


@implementation Problem3

- (id) init
{
	NSString *t = @"Problem 3";
	NSString *st = @"Find the largest prime factor of a composite number.";
	NSString *d = @"The prime factors of 13195 are 5, 7, 13 and 29.\n\n What "
				   "is the largest prime factor of the number 600851475143?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	long long int factor = 0;
	const long long int NUMBER = 600851475143;
	long long int n = 2;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	while (factor == 0) 
	{
		long long int f = NUMBER / n;
		if (NUMBER % f == 0 && [self isPrime:f]) 
		{
			factor = f;
		}
		n++;
	}
		
	return [NSString stringWithFormat:@"%qi", factor];
}

- (BOOL) isPrime:(long long int)n
{
	for (int i=2; i<n/2; i++) 
	{
		if (n % i == 0) 
		{
			return NO;
		}
	}
	
	return YES;
}

@end