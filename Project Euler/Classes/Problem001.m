//
//  Problem1.m
//  Project Euler
//
//  Created by Matt Jones on 12/7/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem001.h"


@implementation Problem1

- (id) init
{
	NSString *t = @"Problem 1";
	NSString *st = @"Add all natural numbers below one thousand that are "
					"multiples of 3 or 5.";
	NSString *d = @"If we list all the natural numbers below 10 that are "
				   "multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of "
				   "these multiples is 23.\n\nFind the sum of all the "
				   "multiples of 3 or 5 below 1000.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	NSInteger sum = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=1; i<=999; i++) 
	{
		if (i % 3 == 0 || i % 5 == 0) 
		{
			sum += i;
		}
	}
	
	return [NSString stringWithFormat:@"%d", sum];
}

@end
