//
//  Problem033.m
//  Project Euler
//
//  Created by Matt Jones on 1/13/11.
//  Copyright 2011 Mr Mustard Media. All rights reserved.
//

#import "Problem033.h"


@implementation Problem33

- (id) init
{
	NSString *t = @"Problem 33";
	NSString *st = @"Discover all the fractions with an unorthodox cancelling "
					"method.";
	NSString *d = @"The fraction 49/98 is a curious fraction, as an "
	"inexperienced mathematician in attempting to simplify may incorrectly "
	"believe that 49/98 = 4/8, which is correct, is obtained by cancelling the "
	"9s.\n\nWe shall consider fractions like, 30/50 = 3/5, to be trivial "
	"examples.\n\nThere are exactly four non-trivial examples of this type of "
	"fraction, less than one in value, and containing two digits in the "
	"numerator and denominator.\n\nIf the product of these four fractions is "
	"given in its lowest common terms, find the value of the denominator.";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int num = 1;
	int den = 1;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int n=10; n<100; n++) 
	{
		for (int d=10; d<100; d++) 
		{
			if (d != n) 
			{
				double number = (double)n / (double)d;
				int nTens = n / 10;
				int nOnes = n % 10;
				int dTens = d / 10;
				int dOnes = d % 10;
				
				double nTens_dOnes = (double)nTens / (double)dOnes;
				if (nOnes == dTens && nTens_dOnes == number) 
				{
					num *= n;
					den *= d;
				}
			}
		}
	}
	
	int n = MIN(num, den);
	for (int i=n; i>1; i--) 
	{
		if (den % i == 0) 
		{
			den /= i;
			i = 0;
		}
	}
	
	return [NSString stringWithFormat:@"%d", den];
}

@end
