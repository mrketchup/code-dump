//
//  Problem014.m
//  Project Euler
//
//  Created by Matt Jones on 12/14/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem014.h"


@implementation Problem14

- (id) init
{
	NSString *t = @"Problem 14";
	NSString *st = @"Find the longest sequence using a starting number under "
					"one million";
	NSString *d = @"The following iterative sequence is defined for the set of "
				   "positive integers:\n\n\tn->n/2 (n is even)\n\tn->3n+1 (n "
				   "is odd)\n\nUsing the rule above and starting with 13, we "
				   "generate the following sequence:\n\n\t13->40->20->10->5->16"
				   "->8->4->2->1\n\nIt can be seen that this sequence "
				   "(starting at 13 and finishing at 1) contains 10 terms. "
				   "Although it has not been proved yet (Collatz Problem), it "
				   "is thought that all starting numbers finish at 1.\n\nWhich "
				   "starting number, under one million, produces the longest "
				   "chain?\n\nNOTE: Once the chain starts the terms are "
				   "allowed to go above one million.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int maxChain = 0;
	int max = 0;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=1; i<1000000; i++) 
	{
		int chain = 1;
		unsigned int n = i;
		while (n > 1) 
		{
			
			if (n % 2 == 0) 
			{
				n /= 2;
			}
			else 
			{
				n *= 3;
				n++;
			}
			chain++;
		}
		
		if (chain >= maxChain) 
		{
			maxChain = chain;
			max = i;
		}
	}
	
	return [NSString stringWithFormat:@"%d", max];
}

@end
