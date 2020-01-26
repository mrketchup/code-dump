//
//  Problem7.m
//  Project Euler
//
//  Created by Matt Jones on 12/9/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem007.h"


@implementation Problem7

- (id) init
{
	NSString *t = @"Problem 7";
	NSString *st = @"Find the 10001st prime.";
	NSString *d = @"By listing the first six prime numbers: 2, 3, 5, 7, 11, "
				   "and 13, we can see that the 6th prime is 13.\n\nWhat is "
				   "the 10001st prime number?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSInteger num = 3;
	NSInteger prime = 0;
	int n = 1;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	while (n < 10001) 
	{
		if ([self isPrime:num]) {
			n += 1;
			prime = num;
		}
		num += 2;
	}
	
	return [NSString stringWithFormat:@"%d", prime];
}

- (BOOL) isPrime:(NSInteger)n
{
	for (int i=2; i<=n/2; i++) 
	{
		if (n % i == 0) 
		{
			return NO;
		}
	}
	
	return YES;
}

@end
