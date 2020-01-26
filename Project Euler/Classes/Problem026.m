//
//  Problem026.m
//  Project Euler
//
//  Created by Matt Jones on 1/3/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem026.h"


@implementation Problem26

- (id) init
{
	NSString *t = @"Problem 26";
	NSString *st = @"Find the value of d < 1000 for which 1/d contains the "
					"longest recurring cycle.";
	NSString *d = @"A unit fraction contains 1 in the numerator. The decimal "
	"representation of the unit fractions with denominators 2 "
	"to 10 are given:\n"
	"\n\t1/2  = 0.5"
	"\n\t1/3  = 0.(3)"
	"\n\t1/4  = 0.25"
	"\n\t1/5  = 0.2"
	"\n\t1/6  = 0.1(6)"
	"\n\t1/7  = 0.(142857)"
	"\n\t1/8  = 0.125"
	"\n\t1/9  = 0.(1)"
	"\n\t1/10 = 0.1\n"
	"\nWhere 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It "
	"can be seen that 1/7 has a 6-digit recurring cycle.\n\nFind the value of "
	"d < 1000 for which 1/d contains the longest recurring cycle in its "
	"decimal fraction part.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int d = 0;
	int max = 0;
	NSMutableArray *primes = [[NSMutableArray alloc] init];
	for (int i=7; i<1000; i+=2) 
	{
		if ([self isPrime:i]) 
		{
			[primes addObject:@(i)];
		}
	}
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=0; i<[primes count]; i++) 
	{
		int num = [[primes objectAtIndex:i] intValue];
		
		int length = [self lengthOfPattern:num];
		if (length > max) 
		{
			max = length;
			d = num;
		}
	}
	
	return [NSString stringWithFormat:@"%d", d];
}

- (BOOL) isPrime:(int)n
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

- (int) lengthOfPattern:(int)n
{
	int loop = 1;
	int remainder = 9;
	while (remainder > 0) 
	{
		remainder = (remainder * 10 + 9) % n;
		loop++;
	}
	
	return loop;
}

@end
