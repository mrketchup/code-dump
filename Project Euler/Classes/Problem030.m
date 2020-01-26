//
//  Problem030.m
//  Project Euler
//
//  Created by Matt Jones on 1/3/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem030.h"


@implementation Problem30

- (id) init
{
	NSString *t = @"Problem 30";
	NSString *st = @"Find the sum of all the numbers that can be written as "
					"the sum of fifth powers of their digits.";
	NSString *d = @"Suprisingly there are only three numbers that can be "
	"written as the sum of fourth powers of their digits:\n\n"
	"\t1634 = 1^4 + 6^4 + 3^4 + 4^4\n"
	"\t8208 = 8^4 + 2^4 + 0^4 + 8^4\n"
	"\t9474 = 9^4 + 4^4 + 7^4 + 4^4\n\nAs 1 = 1^4 is not as sum it is not "
	"included.\n\nThe sum of these numbers is 1634 + 8208 + 9474 = 19316.\n\n"
	"Find the sum of all the numbers that can be written as the sum of fifth "
	"powers of their digits.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int power = 5;
	int totalSum = 0;
	int digits = 1;
	int limit = pow(9,power);
	int max = pow(10,digits+1);
	while (max / limit < 10) 
	{
		digits++;
		limit += pow(9,power);
		max = pow(10,digits+1);
	}

	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int i=2; i<=limit; i++) 
	{
		int sum = 0;
		for (int j=0; j<digits; j++) 
		{
			int div = pow(10,j);
			int digit = (i / div) % 10;
			sum += pow(digit,power);
		}
		
		if (i == sum) 
		{
			totalSum += i;
		}
	}
	
	return [NSString stringWithFormat:@"%d", totalSum];
}

@end
