//
//  Problem16.m
//  Project Euler
//
//  Created by Matt Jones on 12/19/10.
//  Copyright 2010 Mr Mustard Media. All rights reserved.
//

#import "Problem016.h"


@implementation Problem16

- (id) init
{
	NSString *t = @"Problem 16";
	NSString *st = @"What is the sum of the digits of the number 2^1000?";
	NSString *d = @"2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + "
				   "8 = 26.\n\nWhat is the sum of the digits of the number "
				   "2^1000?";
	self = [super initWithTitle:t subtitle:st description:d solved:YES];
	
	return self;
}

- (NSString *) solve:(ProblemViewController *)pvc
{	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Initializing..." waitUntilDone:NO];
	int sum = 0;
	int number[305];
	for (int i=0; i<305; i++) 
	{
		number[i] = 0;
	}
	number[304] = 2;
	
	[pvc performSelectorOnMainThread:@selector(addToConsole:) withObject:@"Calculating..." waitUntilDone:NO];
	for (int power=1; power<1000; power++) 
	{
		int carry = 0;
		for (int i=304; i>=0; i--) 
		{
			int result = 2 * number[i] + carry;
			carry = result / 10;
			number[i] = result % 10;
		}
	}
	
	for (int i=0; i<305; i++) 
	{
		sum += number[i];
	}
	
	return [NSString stringWithFormat:@"%d", sum];
}

@end
