//
//  Problem020.m
//  Project Euler
//
//  Created by Matt Jones on 12/19/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem020.h"


@implementation Problem20

- (id) init
{
	NSString *t = @"Problem 20";
	NSString *st = @"Find the sum of digits in 100!";
	NSString *d = @"n! means n x (n - 1) x ... x 3 x 2 x 1\n\n"
				  "Find the sum of the digits in the number 100!";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int sum = 0;
	int number[160];
	for (int i=0; i<160; i++) 
	{
		number[i] = 0;
	}
	number[157] = 1;
	int inter[2][160];
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int n=99; n>0; n--) 
	{
		int digitTens = n / 10;
		int digitOnes = n % 10;
		
		for (int i=0; i<160; i++) 
		{
			inter[0][i] = 0;
			inter[1][i] = 0;
		}
		
		for (int i=1; i<160; i++) 
		{
			inter[0][i] = number[i] * digitOnes;
			inter[1][i-1] = number[i] * digitTens;
		}
		
		int carry = 0;
		for (int i=159; i>=0; i--) 
		{
			int result = inter[0][i] + inter[1][i] + carry;
			carry = result / 10;
			number[i] = result % 10;
		}
	}
	
	for (int i=0; i<160; i++) 
	{
		sum += number[i];
	}
	
	return [NSString stringWithFormat:@"%d", sum];
}

@end
