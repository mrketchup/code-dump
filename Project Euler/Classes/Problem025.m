//
//  Problem025.m
//  Project Euler
//
//  Created by Matt Jones on 12/22/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem025.h"


@implementation Problem25

- (id) init
{
	NSString *t = @"Problem 25";
	NSString *st = @"What is the first term in the Fibonacci sequence to "
					"contain 1000 digits?";
	NSString *d = @"The Fibonacci sequence is defined by the recurrence "
				   "relation:\n\n\tF(n) = F(n-1) + F(n-2), where F(1) = 1 and "
				   "F(2) = 1.\n\nHence the first 12 terms will be:\n\n\tF(1) = "
				   "1\n\tF(2) = 1\n\tF(3) = 2\n\tF(4) = 3\n\tF(5) = 5\n\tF(6) "
				   "= 8\n\tF(7) = 13\n\tF(8) = 21\n\tF(9) = 34\n\tF(10) = 55"
				   "\n\tF(11) = 89\n\tF(12) = 144\n\nThe 12th term, F(12), is "
				   "the first term to contain three digits.\n\nWhat is the "
				   "first term in the Fibonacci sequencee to contain 1000 "
				   "digits?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int term = 2;
	int current[1000];
	int last[1000];
	for (int i=0; i<1000; i++) 
	{
		current[i] = 0;
		last[i] = 0;
	}
	current[999] = 1;
	last[999] = 1;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	while (current[0] == 0) 
	{
		int carry = 0;
		for (int i=999; i>=0; i--) 
		{
			int result = last[i] + current[i] + carry;
			carry = result / 10;
			last[i] = current[i];
			current[i] = result % 10;
		}
		term++;
	}
	
	return [NSString stringWithFormat:@"%d", term];
}

@end
