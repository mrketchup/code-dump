//
//  Problem5.m
//  Project Euler
//
//  Created by Matt Jones on 12/9/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem005.h"


@implementation Problem5

- (id) init
{
	NSString *t = @"Problem 5";
	NSString *st = @"What is the smallest number divisible by each of the "
					"numbers 1 to 20?";
	NSString *d = @"2520 is the smallest number that can be divided by each of "
				   "the numbers from 1 to 10 without any remainder.\n\nWhat is "
				   "the smallest positive number that is evenly divisible by "
				   "all of the numbers 1 to 20?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSInteger n = 0;
	NSInteger x = 20;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	while (n == 0) 
	{
		BOOL isIt = YES;
		for (int i=1; i<=20; i++) 
		{
			if (x % i != 0) 
			{
				isIt = NO;
			}
		}
		
		if (isIt) 
		{
			n = x;
		}
		
		x += 20;
	}
	
	return [NSString stringWithFormat:@"%d", n];
}

@end
