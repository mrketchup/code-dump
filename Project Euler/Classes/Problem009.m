//
//  Problem9.m
//  Project Euler
//
//  Created by Matt Jones on 12/9/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem009.h"


@implementation Problem9

- (id) init
{
	NSString *t = @"Problem 9";
	NSString *st = @"Find the only Pythagorean triplet, {a, b, c}, for which a "
					"+ b + c = 1000.";
	NSString *d = @"A Pythagorean triplet is a set of three natural numbers, a "
				   "< b < c, for which,\n\n\ta^2 + b^2 = c^2\n\nFor example, "
				   "3^2 + 4^2 = 9 + 16 = 25 = 5^2.\n\nThere exists exactly one "
				   "Pythagorean triplet for which a + b + c = 1000. Find the "
				   "product abc.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int c=997; c>2; c--) 
	{
		for (int b=1000-c-1; b>(1000-c-1)/2; b--) 
		{
			int a = 1000 - c - b;
			if (pow(a, 2) + pow(b, 2) == pow(c, 2)) 
			{
				return [NSString stringWithFormat:@"%d", (a * b * c)];
			}
		}
	}
	
	return [NSString stringWithFormat:@"%d", 0];
}

@end
