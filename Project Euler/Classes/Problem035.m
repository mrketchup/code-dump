//
//  Problem035.m
//  Project Euler
//
//  Created by Matt Jones on 1/13/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem035.h"


@implementation Problem35

- (id) init
{
	NSString *t = @"Problem 35";
	NSString *st = @"How many circular primes are there below on million?";
	NSString *d = @"The number, 197, is called a circular prime because all "
	"rotations of the digits: 197, 971, 719, are themselves prime.\n\nThere "
	"are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, "
	"73, 79, and 97.\n\nHow many circular primes are there below on million?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int count = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=2; i<1000000; i++) 
	{
		if ([self isCircularPrime:i]) 
		{
			count++;
		}
	}
	
	return [NSString stringWithFormat:@"%d", count];
}

- (BOOL) isCircularPrime:(int)n
{
	if ([self isPrime:n]) 
	{
		NSString *num = [NSString stringWithFormat:@"%d",n];
		for (int i=0; i<[num length]-1; i++) 
		{
			NSString *last = [num substringFromIndex:[num length]-1];
			NSString *first = [num substringToIndex:[num length]-1];
			num = [NSString stringWithFormat:@"%@%@",last,first];
			if (![self isPrime:[num intValue]]) 
			{
				return NO;
			}
		}
				  
		return YES;
	}
	
	return NO;
}

- (BOOL) isPrime:(int)n
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
