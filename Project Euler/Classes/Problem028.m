//
//  Problem028.m
//  Project Euler
//
//  Created by Matt Jones on 1/3/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem028.h"


@implementation Problem28

- (id) init
{
	NSString *t = @"Problem 28";
	NSString *st = @"What is the sum of both diagonals in a 1001 by 1001 "
					"spiral?";
	NSString *d = @"Starting with the number 1 and moving to the right in a "
	"clockwise direction a 5 by 5 spiral is formed as follows:\n"
	"\n\t*21*22 23 24*25*"
	"\n\t 20 *7* 8 *9*10"
	"\n\t 19  6 *1* 2 11"
	"\n\t 18 *5* 4 *3*12"
	"\n\t*17*16 15 14*13*\n\n"
	"It can be verified that the sum of the numbers on the diagonals is 101.\n"
	"\nWhat is the sum of the numbers on the diagonals in a 1001 by 1001 "
	"spiral formed in the same way?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int sum = 1;
	int n = 1;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int jump=2; jump<1001; jump+=2) 
	{
		for (int i=0; i<4; i++) 
		{
			n += jump;
			sum += n;
		}
	}
	
	return [NSString stringWithFormat:@"%d", sum];
}

@end
